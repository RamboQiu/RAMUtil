# \_\_attribute\_\_ used section 简单应用

## 文章思路起源
美团的启动优化分享中的Kylin<br>

```objective-c
KLN_FUNCTIONS_EXPORT(STAGE_KEY_A)() { // 在a.m文件中，通过注册宏，把启动项A声明为在STAGE_KEY_A阶段执行
    // 启动项代码A
}
KLN_FUNCTIONS_EXPORT(STAGE_KEY_A)() { // 在b.m文件中，把启动项B声明为在STAGE_KEY_A阶段执行
    // 启动项代码B
}
·
·
·
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 其他逻辑
    [[KLNKylin sharedInstance] executeArrayForKey:STAGE_KEY_A];  // 在此触发所有注册到STAGE_KEY_A时间节点的启动项
    // 其他逻辑
    return YES;
}
```

严选的路由机制关键代码HT_Export<br>

```objective-c
@interface YXDemoController : UIViewController

@end
@implementation YXDemoController
+ (RouterConfig *)configureRouter {
    HT_EXPORT();
    RouterConfig *config = ···
    return config;
}
@end
```

这里的两个宏KLN\_FUNCTIONS\_EXPORT和HT\_EXPORT都用到了一个技术：
**\_\_attribute\_\_ used section**

可以认为，这是一种可以快速读取配置表的类似技术 -- 范爷

Kylin的核心思想就是在编译时把数据（如函数指针）写入到可执行文件的__DATA段中，运行时再从__DATA段取出数据进行相应的操作（调用函数）-- Kylin

对技术的好奇，让我写下了这篇分享

## 先看看怎么用
我在[DEMO](https://github.com/RamboQiu/RAMUtil/tree/dev/RAMUtil/RAMExport)中大致复现了Kylin的实现（具体实现实现肯定比demo复杂），实现了四种使用方式：

1. 获取注册宏的所有类名
2. 实现对字符串存储的key-value机制
3. 存储block方法集合
4. 存储function方法集合

```objective-c
@interface RAMExport : NSObject
+ (instancetype)sharedInstance;

/// 导出所有实现了RAM_FUNCTIONNAME_EXPORT的类
- (NSArray<Class> *)classExport;
/// 执行注册为key的function
- (void)executeArrayForKey:(NSString *)key;
/// 执行注册为key的block
- (void)executeBlockForKey:(NSString *)key;
/// key value获取存储的字符串
- (id)valueForKey:(NSString *)key;
@end

```

（具体实现可以查看DEMO这里不做copy-paste了）

## WHY
### attribute
attribute是gcc的编译属性，主要用于改变所声明或定义的函数或数据的特性，它有很多子项，用于改变作用对象的特性。比如对函数，noline将禁止进行内联扩展、noreturn表示没有返回值、pure表明函数除 返回值外，不会通过其它（如全局变量、指针）对函数外部产生任何影响。但这里我们研究的是对代码段起作用子项section。[详见](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491c/BABCJJID.html) <br>
![attribute.png](https://upload-images.jianshu.io/upload_images/8250011-b29df200686fcb2c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

例如: <br>

```
#define RAM_STRINGS_EXPORT(key, value, id) __attribute__((used, section("__DATA,__ram.data"))) \
static const struct RAM_String __S##id= (struct RAM_String){key, value};

#define RAM_BLOCKS_EXPORT(key, block) __attribute__((used, section("__TEXT," "__"#key ".block"))) \
static const struct RAM_Block __B##key = (struct RAM_Block){((char *)&#key), block};

#define RAM_FUNCTION_EXPORT(key) \
static void _ram##key(void); \
__attribute__((used, section("__TEXT," "__"#key ".func"))) \
static const struct RAM_Function __F##key = (struct RAM_Function){(char *)(&#key), (void *)(&_ram##key)}; \
static void _ram##key \
```

[How to find where a symbol is placed when linking](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0474c/CACJAJGD.html)

#### section

>The section function attribute enables you to place code in different sections of the image.<br>
>Normally, the ARM compiler places the objects it generates in sections like .data and .bss. However, you might require additional data sections or you might want a variable to appear in a special section, for example, to map to special hardware. The section attribute specifies that a variable must be placed in a particular data section. If you use the section attribute, read-only variables are placed in RO data sections, read-write variables are placed in RW data sections unless you use the zero_init attribute. In this case, the variable is placed in a ZI section.
>
>可以使用section函数属性将代码放在映像的不同节中。<br>
>通常，ARM 编译器将它生成的对象放在节中，如data 和 bss。但是，您可能需要使用其他数据节，或者希望变量出现在特殊节中，例如，便于映射到特殊硬件。section 属性指定变量必须放在特定数据节中。如果使用section 属性，则将只读变量放在 RO 数据节中，而将读写变量放在 RW 数据节中，除非您使用 zero_init 属性。在这种情况下，变量被放在 ZI 节中。

```
void Function_Attributes_section_0 (void) 
    __attribute__ ((section ("__TEXT,new_section")));// OS X 
void Function_Attributes_section_0 (void)
{
    static int aStatic =0;
    aStatic++;
}

```
注意：\_\_attribute\_\_这种用法中的括号好像很严格，这里的几个括号好象一个也不能少。

利用\_\_attribute\_\_编译器指令，可以使函数名叫Function\_Attributes\_section\_0被放入到指定的section中（segname为\_\_TEXT；sectname为new_section），我们可以在usr/include/mach-o/loader.h中看到section是这样的一个结构体：[Mac OS X ABI Mach-O File Format Reference](https://github.com/LeoMobileDeveloper/React-Native-Files/blob/master/Mac%20OS%20X%20ABI%20Mach-O%20File%20Format%20Reference.pdf)<br>

```
struct section { /* for 32-bit architectures */
	char		sectname[16];	/* name of this section */
	char		segname[16];	/* segment this section goes in */
	uint32_t	addr;		/* memory address of this section */
	uint32_t	size;		/* size in bytes of this section */
	uint32_t	offset;		/* file offset of this section */
	uint32_t	align;		/* section alignment (power of 2) */
	uint32_t	reloff;		/* file offset of relocation entries */
	uint32_t	nreloc;		/* number of relocation entries */
	uint32_t	flags;		/* flags (section type and attributes)*/
	uint32_t	reserved1;	/* reserved (for offset or index) */
	uint32_t	reserved2;	/* reserved (for count or sizeof) */
};
```

> Segments和Sections的命名规范为：<br>
> Segments以双下划线打头全大写字母，限制长度16 bytes，如\_\_TEXT <br>
> Sections以双下划线打头全小写字母，限制长度16 bytes，如\_\_text <br>
> > **Segments** <br>
> > A segment efines a range of bytes in a Mach-O file and the addresses and memory protection attributes at which those bytes are mapped into virtual memory when the dynamic linker loads the application. As such, segments are always virtual memory page aligned. A segment contains zero or more sections.<br>


![mach-0struct.png](https://upload-images.jianshu.io/upload_images/8250011-de37964b7bdf40e7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Header 头部，包含可以执行的CPU架构，比如x86,arm64<br>
Load commands 加载命令，包含文件的组织架构和在虚拟内存中的布局方式<br>
Data，数据，包含load commands中需要的各个段(segment)的数据，每一个Segment都得大小是Page的整数倍。<br>
使用**MachOView**查看DEMOmach-o文件<br>
![mach-o.png](https://upload-images.jianshu.io/upload_images/8250011-8dca5268f0ee1440.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意：clean->build才会重新生成新的mach-o文件

#### used

>This function or variable attribute informs the compiler that a static function or variable is to be retained in the object file, even if it is unreferenced.<br>
>Static functions or variables marked as used are emitted to a single section, in the order they are declared. You can specify the section functions are placed in using \_\_attribute\_\_((section("name"))).<br>
>Functions or Data marked with \_\_attribute\_\_((used)) are tagged in the object file to avoid removal by linker unused section removal.<br>
>
>指示编译器在对象文件中保留静态函数or变量，即使将该函数or变量没有被引用也是如此。<br>
>被标注的静态变量将会按照声明的顺序，放到指定的一个section中。使用\_\_attribute\_\_((section("name")))可以指明该section.
>


```
static int keep_this(int) __attribute__((used));     /*保留目标文件，编译器不进行空间优化*/

static int lose_this = 1;
static int keep_this __attribute__((used)) = 2;     // retained in object file
static int keep_this_too __attribute__((used)) = 3; // retained in object file
```

## 后续可以继续研究的地方
RAM\_FUNCTIONNAME\_EXPORT能够获取到注册了宏的当前\_\_func\_\_，例如严选项目中的，能得到如下类名和方法
[YXDemoController configureRouter]，在使用runtime原理，能实现的本事包括检查子类是否复写了父类的强制需要重写的方法[MustOverride](https://www.jianshu.com/p/9dbbdca2515e)，以及等等其他内容。

## 参考资料<br>
[RunTime应用实例：MustOverride](https://www.jianshu.com/p/9dbbdca2515e) <br>
[arm Developer](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491c/BABCJJID.html) <br>
[Mac OS X ABI Mach-O File Format Reference](https://github.com/LeoMobileDeveloper/React-Native-Files/blob/master/Mac%20OS%20X%20ABI%20Mach-O%20File%20Format%20Reference.pdf) <br>
[美团外卖iOS App冷启动治理](https://tech.meituan.com/waimai_ios_optimizing_startup.html) <br>
[C 结构体](http://www.runoob.com/cprogramming/c-structures.html) <br>
[深入理解iOS App的启动过程](https://blog.csdn.net/Hello_Hwc/article/details/78317863) <br>
[深入理解C语言函数指针](https://www.cnblogs.com/windlaughing/archive/2013/04/10/3012012.html) <br>
[在宏定义中使用 block](https://blog.csdn.net/qq_27074387/article/details/79815359) <br>
[What is the sizeof(struct)? [duplicate]
](https://stackoverflow.com/questions/24908713/what-is-the-sizeofstruct) <br>
[attribute 用法 section 部分](http://blog.51cto.com/justinxd/567546) <br>
[宏定义单引号和双引号](https://blog.csdn.net/zll_liang/article/details/8966106) <br>
[
[iOS]深入理解__bridge - OC对象与C++对象的引用转换](https://blog.csdn.net/args_/article/details/53018656) <br>
[OC与C的内存管理及其交互](https://www.jianshu.com/p/f0a56c5bc4fe) <br>
[iOS开发中C函数调用OC方法](https://www.jianshu.com/p/bdbb0f5f0df5) <br>
[RealView编译器常用特有功能](http://www.voidcn.com/article/p-zlzztazc-bdh.html) <br>
以及其他网络优秀资源
