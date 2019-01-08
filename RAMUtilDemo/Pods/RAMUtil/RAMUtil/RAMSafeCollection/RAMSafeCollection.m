#import "RAMSafeCollection.h"
// #import <Crashlytics/Crashlytics.h>

static void Log(NSString *fmt, ...) {
    NSMutableString *reportStr = [NSMutableString string];
    va_list ap;
    va_start(ap, fmt);
    NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
    [reportStr appendString:@"***Terminating app due to uncaught exception\r\n"];
    [reportStr appendFormat:@"***reason:-%@\r\n", content];
    va_end(ap);
    [reportStr appendFormat:@"*** First throw call stack:\n%@", [NSThread callStackSymbols]];
    /// 项目中如果集成了fabric可以使用下面的代码逻辑
//     NSArray<NSString *> *callStackSymbols = [NSThread callStackSymbols];
//     NSMutableArray<CLSStackFrame *> *stackFrames = [NSMutableArray arrayWithCapacity:callStackSymbols.count];
//     for (NSString *callStachSymbol in callStackSymbols) {
//         [stackFrames addObject:[CLSStackFrame stackFrameWithSymbol:callStachSymbol]];
//     }
// #ifdef DEBUG
//     [NSException raise:NSInvalidArgumentException format:@"***reason%@", content];
// #else
//     [CrashlyticsKit recordCustomExceptionName:@"自捕获崩溃" reason:content frameArray:stackFrames];
// #endif
    NSLog(@"%@", reportStr);
}

@implementation NSArray (RAMSafety)

- (id)at:(NSUInteger)i {
    if (i < self.count) {
        return self[i];
    } else {
        Log(@"NSArray objectAtIndex beyond the bound: %lu is beyond the count:%lu!", (unsigned long)i, (unsigned long)self.count);
        return nil;
    }
}

+ (instancetype)create:(id)firstObj, ... {
    NSMutableArray *array = [NSMutableArray new];
    
    va_list args;
    va_start(args, firstObj);
    for (id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
        [array add:arg];
    }
    va_end(args);
    
    if ([self isEqual:NSMutableDictionary.class]) {
        return array;
    } else {
        return [array copy];
    }
}

@end

@implementation NSDictionary (RAMSafety)

+ (instancetype)kv:(id)firstObj, ... {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    va_list args;
    va_start(args, firstObj);
    id key, value;
    int i = 0;
    for (id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
        if (i % 2 == 0) {
            key = arg;
        } else {
            value = arg;
            [dic key:key value:value];
        }
        i++;
    }
    va_end(args);
    
    if ([self isEqual:NSMutableDictionary.class]) {
        return dic;
    } else  {
        return dic.copy;
    }
}

@end

@implementation NSMutableArray (RAMSafety)

- (void)add:(id)object {
    if (object == nil) {
        Log(@"NSMutableArray added a nil object!");
        return;
    }
    
    [self addObject:object];
}

- (void)insert:(id)o at:(NSUInteger)i {
    if (o == nil) {
        Log(@"NSMutableArray inserted a nil object!");
    } else if (i > self.count) { //这里得是> 而不能>=，因为insert能插入到最后一个
        Log(@"NSArray insertObject:atIndex: beyond the bound: %lu is beyond the count:%lu!", (unsigned long)i, (unsigned long)self.count);
    } else {
        [self insertObject:o atIndex:i];
    }
}

- (void)removeAt:(NSUInteger)i {
    if (i < self.count) {
        [self removeObjectAtIndex:i];
    } else {
        Log(@"NSArray removeObjectAtIndex beyond the bound: %lu is beyond the count:%lu!", (unsigned long)i, (unsigned long)self.count);
    }
}

@end

@implementation NSMutableDictionary (RAMSafety)

- (void)key:(id)k value:(id)v {
    if (k == nil || ![k conformsToProtocol:@protocol(NSCopying)]) {
        Log(@"NSMutableDictionary setObject:forKey:, key %@ is invalid!", k);
        return;
    }

    self[k] = v;
}

@end

@implementation NSMutableAttributedString (RAMSafety)

+ (instancetype)yx_newWithString:(NSString *)string attributes:(nullable NSDictionary *)attrs {
    if (string == nil) {
        return nil;
    } else {
        return [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    }
}

@end

