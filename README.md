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
[点击查看](https://github.com/RamboQiu/RAMUtil/blob/dev/RAMUtil/RAMExport/README.md)

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



7. 运行 GraphQL 的客户端案例

```bash
RAMUtilDemo|graphql⚡ ⇒cd fullstack-tutoria/start/server
server|graphql⚡ ⇒rm node_modules
server|graphql⚡ ⇒npm install
server|graphql⚡ ⇒npm start
server|graphql⚡ ⇒ npm start

> fullstack-tutorial-server@1.0.0 start /Users/rambo/Documents/MyProject/MyGit/RAMUtil/RAMUtilDemo/fullstack-tutoria/start/server
> nodemon src/index.js

[nodemon] 1.19.4
[nodemon] to restart at any time, enter `rs`
[nodemon] watching dir(s): *.*
[nodemon] watching extensions: js,mjs,json
[nodemon] starting `node src/index.js`

      Server is running!
      Listening on port 4000
      Explore at https://studio.apollographql.com/dev
```

启动RAMUtilDemo iOS工程，点击GraphQL演示，进入swift编写的controller，后台日志会输出请求的数据，即表示成功

```
launch mission name: Starlink-15 (v1.0)
launch site: CCAFS SLC 40
launch mission name: Sentinel-6 Michael Freilich
launch site: VAFB SLC 4E
launch mission name: Crew-1
launch site: KSC LC 39A
launch mission name: GPS III SV04 (Sacagawea)
launch site: CCAFS SLC 40
launch mission name: Starlink-14 (v1.0)
launch site: CCAFS SLC 40
launch mission name: Starlink-13 (v1.0)
launch site: KSC LC 39A
```



