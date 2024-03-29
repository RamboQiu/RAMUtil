# RAMUtil
结合各类工具代码，已经使用pod进行管理，导入单一的工具使用

```
pod 'RAMUtil', :git => 'https://github.com/RamboQiu/RAMUtil.git', :subspecs => ['RAMCellData'], :tag => '1.0.0'
```

## 1. 静态cell代码管理 - RAMCellData

## 2. 检查父类的强制复写方法是否被子类复写 - RAMMustOverrider

## 3. 安全容器 - RAMSafeCollection
举例主要使用
```
NSArray *arr = @[@"1"];
[arr at:0];
```
## 4. \_\_attribute\_\_ section - RAMExport
[点击查看](https://github.com/RamboQiu/RAMUtil/tree/master/RAMUtil/RAMExport)

## 5. log日志中间件 - RAMLog
可以在自己的模块或是sdk中接入，然后调用主程序的日志输出，例如，自己的skd里面么有接入DDLog，但是项目中都是封装了使用ddlog来写入日志的，这个时候可以在项目中调用如下，进行sdk中的日志中转即可

```
[RAMAdditionalLogger setBlock:^(int level, const char *fullpath, int line, const char *prefix, NSString *content) {
	[DDLog yx_channelLog:level fullpath:fullpath line:line prefix:prefix content:content];
}];
```

在sdk里面只需要使用

```
RAMLOG_INFO("I'm a test message.");
```

## 6. Runtime编译调用

使用的runtime版本为objc4-750.1

[下载地址](https://opensource.apple.com/release/macos-10145.html) [github](https://github.com/acBool/RuntimeSourceCode)

没找到方法直接调用demo里面的runtime的源码工程，只能把想测试的runtime代码，copy到objc项目中去单独跑，然后看源码实现

![image-20191128173217662](https://github.com/RamboQiu/RAMUtil/blob/master/RAMUtilDemo/RAMUtilDemo/RAMTestUI/RAMRuntime/debug.png?raw=true)