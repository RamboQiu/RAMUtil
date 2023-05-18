//
//  RAMGCDViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/12/31.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMGCDViewController.h"

// https://juejin.im/post/5a90de68f265da4e9b592b40#heading-19
// https://www.jianshu.com/p/3684f40c9172
// https://www.jianshu.com/p/44369c02b62a

@interface RAMGCDViewController ()
@property (nonatomic, strong) dispatch_queue_t mainQueue;
@property (nonatomic, strong) dispatch_source_t myGCDTimer;
@property (nonatomic, assign) long long lastTimestamp;
@property (nonatomic, strong) NSString *testString;
@end

@implementation RAMGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"1");
//    });
    

    self.mainQueue = dispatch_queue_create("test.main", DISPATCH_QUEUE_CONCURRENT);
    
//    [self gcdBarrier];
//
//    dispatch_barrier_async(self.mainQueue, ^{
//        NSLog(@"---------1--------");
//    });
//
//    [self gcdApply];
//
//    dispatch_barrier_async(self.mainQueue, ^{
//        NSLog(@"---------2--------");
//    });
//
//    [self gcdGroup];
//
//    dispatch_barrier_async(self.mainQueue, ^{
//        NSLog(@"---------3--------");
//    });
//
//    [self gcdSemaphore];
    [self semaphore];
    
//    [self testAsyncConQueue_sync];
//    [self testAsyncConQueue_async];
//    [self testSyncConQueue_sync];
//    [self testSyncConQueue_async];
//
//    [self testAsyncSeQueue_sync];
//    [self testAsyncSeQueue_async];
//    [self testSyncSeQueue_sync];
//    [self testSyncSeQueue_async];
    
    
//    [self test];
//    [self test2];
//    [self test3];
}

- (void)test {
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue, ^{
//        NSLog(@"1");
//        dispatch_sync(queue, ^{
//            NSLog(@"2");
//        });
//    });
//    dispatch_queue_t q = dispatch_queue_create("1111111", DISPATCH_QUEUE_SERIAL);
//    for (int i = 0 ; i < 1000; i ++) {
//        
//        
//        dispatch_sync(q, ^{
//            
//            NSLog(@"%@-",[NSThread currentThread]);
//            dispatch_sync(q, ^{
//                NSLog(@"%@--",[NSThread currentThread]);
//            });
//            NSLog(@"%@---",[NSThread currentThread]);
//        });
//        
//        NSLog(@"%@----",[NSThread currentThread]);
//        NSLog(@"\n\n");
//    }
    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
//    if (timer) {
//        self.myGCDTimer = timer;
//        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
//        dispatch_source_set_event_handler(timer, ^ {
//            NSLog(@"doSomething");
//        });
//        dispatch_resume(timer);
//    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"1");
        });
        NSLog(@"2");
        NSLog(@"3");
    });
    [NSThread sleepForTimeInterval:1];
    NSLog(@"4");
}
- (void)dealloc {
    if (_myGCDTimer) {
        dispatch_cancel(_myGCDTimer);
    }
    NSLog(@"MyViewController dealloc");
}

//区别 1『异步执行+并发队列』嵌套『同一个并发队列』 2『同步执行+并发队列』嵌套『同一个并发队列』3『异步执行+串行队列』嵌套『同一个串行队列』4『同步执行+串行队列』嵌套『同一个串行队列』
//
//s同步（sync） 没有开启新的线程，串行执行任务    没有开启新线程，串行执行任务             死锁卡住不执行                       死锁卡住不执行
//a异步（async）有开启新线程，并发执行任务       有开启新线程，并发执行任务               有开启新线程（1 条），串行执行任务      有开启新线程（1 条），串行执行任务

// 1s
- (void)testAsyncConQueue_sync {
    dispatch_queue_t asyncQueue = dispatch_queue_create("test.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue, ^{    // 异步执行 + 并发队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1s---%@",[NSThread currentThread]);
        dispatch_sync(asyncQueue, ^{  // 同步执行 + 当前并发队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1s---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
// 1a
- (void)testAsyncConQueue_async {
    dispatch_queue_t asyncQueue = dispatch_queue_create("test.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue, ^{    // 异步执行 + 并发队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1a---%@",[NSThread currentThread]);
        dispatch_async(asyncQueue, ^{  // 异步执行 + 当前并发队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1a---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
// 2s
- (void)testSyncConQueue_sync {
    dispatch_queue_t asyncQueue = dispatch_queue_create("test.queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(asyncQueue, ^{    // 同步执行 + 并发队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2s---%@",[NSThread currentThread]);
        dispatch_sync(asyncQueue, ^{  // 同步执行 + 当前并发队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2s---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
//2a
- (void)testSyncConQueue_async {
    dispatch_queue_t asyncQueue = dispatch_queue_create("test.queue4", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(asyncQueue, ^{    // 异步执行 + 并发队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2a---%@",[NSThread currentThread]);
        dispatch_async(asyncQueue, ^{  // 异步执行 + 当前并发队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2a---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}


// 3s 死锁
- (void)testAsyncSeQueue_sync {
    dispatch_queue_t syncQueue = dispatch_queue_create("test.queue5", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(syncQueue, ^{    // 异步执行 + 串行队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3s---%@",[NSThread currentThread]);
        dispatch_sync(syncQueue, ^{  // 同步执行 + 当前串行队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3s---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
// 3a
- (void)testAsyncSeQueue_async {
    dispatch_queue_t syncQueue = dispatch_queue_create("test.queue6", DISPATCH_QUEUE_SERIAL);
    dispatch_async(syncQueue, ^{    // 异步执行 + 串行队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3a---%@",[NSThread currentThread]);
        dispatch_async(syncQueue, ^{  // 异步执行 + 当前串行队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3a---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
// 4s 死锁
- (void)testSyncSeQueue_sync {
//    dispatch_queue_t syncQueue = dispatch_queue_create("test.queue7", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(syncQueue, ^{    // 同步执行 + 串行队列
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"4s---%@",[NSThread currentThread]);
//        dispatch_sync(syncQueue, ^{  // 同步执行 + 当前串行队列
//            // 追加任务 1
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"4s---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
}
//4a
- (void)testSyncSeQueue_async {
    dispatch_queue_t syncQueue = dispatch_queue_create("test.queue8", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(syncQueue, ^{    // 异步执行 + 串行队列
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"4a---%@",[NSThread currentThread]);
        dispatch_async(syncQueue, ^{  // 异步执行 + 当前串行队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"4a---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}



//    "1 GCD 栅栏方法：dispatch_barrier_async\n"
- (void)gcdBarrier {
        
        dispatch_async(self.mainQueue, ^{
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1-Barrier---%@",[NSThread currentThread]);      // 打印当前线程
        });
        dispatch_async(self.mainQueue, ^{
            // 追加任务 2
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2-Barrier---%@",[NSThread currentThread]);      // 打印当前线程
        });
        
        dispatch_barrier_async(self.mainQueue, ^{
            // 追加任务 barrier
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
        });
        
        dispatch_async(self.mainQueue, ^{
            // 追加任务 3
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3-Barrier---%@",[NSThread currentThread]);      // 打印当前线程
        });
        dispatch_async(self.mainQueue, ^{
            // 追加任务 4
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"4-Barrier---%@",[NSThread currentThread]);      // 打印当前线程
        });
}

    
//    "2 GCD 延时执行方法：dispatch_after\n"
- (void)gcdAfter {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0 秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}

//    "3 GCD 一次性代码（只执行一次）：dispatch_once\n"
- (void)gcdOnce {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行 1 次的代码（这里面默认是线程安全的）
    });
}
//    "4 GCD 快速迭代方法：dispatch_apply\n"
- (void)gcdApply {
    dispatch_async(self.mainQueue, ^{
        NSLog(@"apply---begin");
    });
    dispatch_apply(6, self.mainQueue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    dispatch_async(self.mainQueue, ^{
        NSLog(@"apply---end");
    });
}
//    "5 GCD 队列组：dispatch_group\n"
//    "5.1 dispatch_group_notify\n"
//    "5.2 dispatch_group_wait\n"
//    "5.3 dispatch_group_enter、dispatch_group_leave\n"
- (void)gcdGroup {
    dispatch_async(self.mainQueue, ^{
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"group---begin");
        
    });
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, self.mainQueue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1-group---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, self.mainQueue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2-group---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_notify(group, self.mainQueue, ^{
        // 等前面的异步任务 1、任务 2 都执行完毕后，回到主线程执行下边任务
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3-group---%@",[NSThread currentThread]);      // 打印当前线程

        NSLog(@"group---end");
    });

}
//    "6 GCD 信号量：dispatch_semaphore\n"
//    "6.1 Dispatch Semaphore 线程同步\n"
//    "6.2 Dispatch Semaphore 线"
- (void)gcdSemaphore {
    dispatch_async(self.mainQueue, ^{
        
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"semaphore---begin");
    });
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(self.mainQueue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %zd",number);
    
}

- (void)test2 {
    dispatch_async(dispatch_queue_create("test.11", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 1000; i ++) {
            long long t = [self uniqueTimestamp];
            NSLog(@"+%lld", t);
        }
    });
    dispatch_async(dispatch_queue_create("test.22", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 1000; i ++) {
            long long t = [self uniqueTimestamp];
            NSLog(@"-%lld", t);
        }
    });
}

- (NSTimeInterval)uniqueTimestamp {
//    long long now = floor(NSDate.date.timeIntervalSince1970 * 1000);
//
//    if (now <= self.lastTimestamp)
        self.lastTimestamp ++;
//    else
//        self.lastTimestamp = now;
    
    return self.lastTimestamp;
}

- (void)test3 {
    dispatch_queue_t asyncQueue1 = dispatch_queue_create("test.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue1, ^{    // 异步执行 + 并发队列
        for (int i = 0; i < 2000; i ++) {
//            @synchronized (self) {
                self.testString = [NSString stringWithFormat:@"测试%d", i];
//            }
        }
    });
    
    dispatch_queue_t asyncQueue2 = dispatch_queue_create("test.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue2, ^{    // 异步执行 + 并发队列
        for (int i = 0; i < 2000; i ++) {
//            @synchronized (self) {
                self.testString = [NSString stringWithFormat:@"赋值%d", i];
//            }
        }
    });
    
    dispatch_queue_t asyncQueue3 = dispatch_queue_create("test.queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue3, ^{    // 异步执行 + 并发队列
        for (int i = 0; i < 2000; i ++) {
            NSLog(@"%@", self.testString);
        }
    });
}

- (void)semaphore {
    dispatch_semaphore_t signal;
    // creat指定初始的singal
    signal = dispatch_semaphore_create(1);
    __block long x = 1;
    NSLog(@"0_x:%ld",x);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"waiting1");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"1_x:%ld",x);
            
        sleep(2);
        NSLog(@"waiking2");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"2_x:%ld",x);
        // 让直行结束的signal>=1 避免EXC_BAD_INSTRUCTION奔溃
//        x = dispatch_semaphore_signal(signal);
//        x = dispatch_semaphore_signal(signal);
    });
    //    dispatch_time_t duration = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000); //超时1秒
    //    dispatch_semaphore_wait(signal, duration);
        
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"3_x:%ld",x);
        
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 2");
    NSLog(@"4_x:%ld",x);
        
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 3");
    NSLog(@"5_x:%ld",x); // EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
    // semaphore结束时候的signal的初始值要>=create(1)，也就是>=1
    
//    2023-05-18 11:27:08.160356+0800 RAMUtilDemo[66437:3565466] 0_x:1
//    2023-05-18 11:27:08.160528+0800 RAMUtilDemo[66437:3565466] 3_x:0
//    2023-05-18 11:27:09.160841+0800 RAMUtilDemo[66437:3565841] waiting1
//    2023-05-18 11:27:09.161077+0800 RAMUtilDemo[66437:3565841] 1_x:1
//    2023-05-18 11:27:09.161085+0800 RAMUtilDemo[66437:3565466] wait 2
//    2023-05-18 11:27:09.161183+0800 RAMUtilDemo[66437:3565466] 4_x:0
//    2023-05-18 11:27:11.166266+0800 RAMUtilDemo[66437:3565841] waiking2
//    2023-05-18 11:27:11.166476+0800 RAMUtilDemo[66437:3565841] 2_x:1
//    2023-05-18 11:27:11.166494+0800 RAMUtilDemo[66437:3565466] wait 3
//    2023-05-18 11:27:11.166574+0800 RAMUtilDemo[66437:3565466] 5_x:0
    
}

@end
