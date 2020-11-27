//
//  main.m
//  TestComandLine
//
//  Created by 裘俊云 on 2019/12/5.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

/// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m
/// 生成main.cpp文件
/// clang -rewrite-objc -fobjc-arc -stdlib=libc++ -mmacosx-version-min=10.7 -fobjc-runtime=macosx-10.7 -Wno-deprecated-declarations main.m

//struct __block_impl {
//  void *isa;
//  int Flags;
//  int Reserved;
//  void *FuncPtr;
//};
//
//
//struct __main_block_impl_0 {
//  struct __block_impl impl;
//  struct __main_block_desc_0* Desc;
//  int a;
//  int *b;
//  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _a, int *_b, int flags=0) : a(_a), b(_b) {
//    impl.isa = &_NSConcreteStackBlock;
//    impl.Flags = flags;
//    impl.FuncPtr = fp;
//    Desc = desc;
//  }
//};
//static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
//  int a = __cself->a; // bound by copy
//  int *b = __cself->b; // bound by copy
//
//            NSLog((NSString *)&__NSConstantStringImpl__var_folders_6z_r69_k_f946bd4vjplpcnr3ch0000gn_T_main_0b3dac_mi_0, a,(*b));
//        }
//
//static struct __main_block_desc_0 {
//  size_t reserved;
//  size_t Block_size;
//} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//        auto int a = 10;
//        static int b = 11;
//        void(*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, a, &b));
//        a = 1;
//        b = 2;
//        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
//    }
//    return 0;
//}
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };

typedef void(^Block)(NSString *);

#define MAXA(A,B) A>B?A:B

@interface TestDemoObj : NSObject
@property (nonatomic, strong) Block blk;
@end

@implementation TestDemoObj
- (instancetype)initWithBlock:(Block)block {
    if (self = [super init]) {
        _blk = block;
    }
    return self;
}

- (void)Block:(Block)block {
    _blk = block;
    NSLog(@"====%@",block);
    int a = MAXA(10, 20);
}


- (void)execute {
    _blk(@"回调数据");
}

-(void)dealloc {
    NSLog(@"TestDemoObj释放了");
}
@end

int c = 12;

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        __block int a = 10;
//        static int b = 11;
//        TestDemoObj *testObj = [[TestDemoObj alloc] init];
//        void(^block)(void) = ^{
//            a = 2;
//            NSLog(@"hello, a = %d, b = %d, c = %d", a,b,c);
//            testObj.stringDemo = @"s";
//            testObj.intDemo = 2;
//            NSLog(@"testObj.intDemo: %d", testObj.intDemo);
//        };
//        a = 1;
//        b = 2;
//        c = 13;
//        block();
//        // log : hello, a = 10, b = 2
//        // block中a的值没有被改变而b的值随外部变化而变化。
//    }
//    return 0;
//}
