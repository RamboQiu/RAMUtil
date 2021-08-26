    //
//  RAMMacroViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/12/3.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMMacroViewController.h"
#import <RAMUtil/UIView+Frame.h>
#import <RAMUtil/RAMMacros.h>

// example(abc)； 在编译时将会展开成：printf("the input string is:/t%s/n","abc");
#define LOG(str) NSLog(@"thie input string is:/t%@/n",@#str)
// string str=example1(abc)； 将会展成：string str="abc"；
#define example1(instr) #instr
// int num9=9;
// int num=exampleNum(9); 将会扩展成 int num=num9;
#define exampleNum(n) num##n
// a = makechar(b); 将会扩展成 a= 'b';
#define makechar(x)  @#x

#define paster( n ) printf( "token" #n " = %d", token##n )


/*
 1) 在第一个宏定义中，"name"和第一个"_"之间，以及第2个"_"和第二个

 "type"之间没有被分隔，所以预处理器会把name_##type##_type解释成3段：

 “name_”、“type”、以及“_type”，这中间只有“type”是在宏前面出现过

  的，所以它可以被宏替换。


 2) 而在第二个宏定义中，“name”和第一个“_”之间也被分隔了，所以

 预处理器会把name##_##type##_type解释成4段：“name”、“_”、“type”

 以及“_type”，这其间，就有两个可以被宏替换了。
 */
#define A1(name, type)  type name_##type##_type

#define A2(name, type)  type name##_##type##_type

A1(a1, int);  /* 等价于: int name_int_type; */

A2(a1, int);  /* 等价于: int a1_int_type;   */

/**
 3) A1和A2的定义也可以如下：

        #define A1(name, type)  type name_  ##type ##_type

                                   <##前面随意加上一些空格>

        #define A2(name, type)  type name ##_ ##type ##_type

 结果是## 会把前面的空格去掉完成强连接，得到和上面结果相同的宏定义
 
 */



/**
 MODULE_DEVICE_TABLE(usb, products)  //notes: struct usb_device_id products;

 <==> MODULE_GENERIC_TABLE(usb_device,products)

 <==> extern const struct usb_device_id __mod_usb_device_table

             __attribute__ ((unused, alias("products")))

 */
#define MODULE_DEVICE_TABLE(type,name) MODULE_GENERIC_TABLE(type##_device,name)

#define MODULE_GENERIC_TABLE(gtype,name) \
 extern const struct gtype##_id __mod_##gtype##_table \
 __attribute__ ((unused, alias(__stringify(name))))

#define TESTCOUNT num##__COUNTER__

#define PP_CONCAT(A, B) PP_CONCAT_IMPL(A, B)
#define PP_CONCAT_IMPL(A, B) A##B

#define PP_GET_N(N, ...) PP_CONCAT(PP_GET_N_, N)(__VA_ARGS__)
#define PP_GET_N_0(_0, ...) _0
#define PP_GET_N_1(_0, _1, ...) _1
#define PP_GET_N_2(_0, _1, _2, ...) _2
// ...
#define PP_GET_N_8(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...) _8

@interface RAMMacroViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation RAMMacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int token9 = 9;
    paster(9);
    
    NSLog(@"%s", __func__);
    
    NSLog(@"%d", __LINE__);
    
    int foo = 1, bar = 2;
    int a = PP_GET_N(0, foo, bar);  // -> foo
    int b = PP_GET_N(1, foo, bar);  // -> bar
    
    NSLog(@"%d", __COUNTER__);//0
    NSLog(@"%d", __COUNTER__);//1
    NSLog(@"%d", __COUNTER__);//2
    
    self.label = UILabel.new;
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    
    self.label.text = @""
    "https://blog.csdn.net/xdsoft365/article/details/5911596\n"
    "\t#: 字符串化操作符。其作用是：将宏定义中的传入参数名转换成用一对双引号括起来参数名字符串。"
    "其只能用于有传入参数的宏定义中，且必须置于宏定义体中的参数名前。\n"
    "\t##: 符号连接操作符.宏定义中：参数名，即为形参，如#define sum(a,b) (a+b)；中a和b均为某一参数的代表符号，即形式参数。"
    "而##的作用则是将宏定义的多个形参成一个实际参数名。\n"
    "\t@#: 字符化操作符。只能用于有传入参数的宏定义中，且必须置于宏定义体中的参数名前。作用是将传的单字符参数名转换成字符，以一对单引用括起来。\n"
    "\t\\: 行继续操作符。当定义的宏不能用一行表达完整时，可以用\"\\\"表示下一行继续此宏的定义 \n";
    
    self.label.width = RAMScreenWidth;
    [self.label sizeToFit];
}

- (void)testAction:(id)sender {
    NSLog(@"%d", __COUNTER__);//3
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.label.y = 100;
}
@end
