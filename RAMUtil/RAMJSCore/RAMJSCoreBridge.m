
#import <JavaScriptCore/JavaScriptCore.h>
#import "RAMJSCoreBridge.h"


@interface RAMJSCoreBridge ()
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation RAMJSCoreBridge

- (instancetype)init {
    if (self = [super init]) {
        _jsContext = [[JSContext alloc] init];
        
        [self regiestNativeFunction];
    }
    return self;
}

- (void)regiestNativeFunction {
    //注册一个objc方法给js调用
    self.jsContext[@"log"] = ^(NSString *msg){
        NSLog(@"js:msg:%@",msg);
    };
    //另一种方式，利用currentArguments获取参数
    self.jsContext[@"log"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) { NSLog(@"%@",obj); }
    };
    
    //使用js调用objc
//    [self.jsContext evaluateScript:@"log('hello,i am js side')"];
}

- (void)test {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"core" ofType:@"js"];
    NSString * html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.jsContext evaluateScript:html];
}
@end
