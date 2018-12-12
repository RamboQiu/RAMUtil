#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (RAMSafety)
- (ObjectType)at:(NSUInteger)i;

/// 安全方法，即使传了obj为空也没事。必须以nil为结尾
+ (instancetype)create:(id)firstObj, ...; // [NSArray create:@1, @2, @3, nil];
@end

@interface NSMutableArray<ObjectType> (RAMSafety)
- (void)add:(ObjectType)o;
- (void)insert:(ObjectType)o at:(NSUInteger)i;
- (void)removeAt:(NSUInteger)i;
@end

@interface NSMutableDictionary<KeyType, ObjectType> (RAMSafety)
- (void)key:(KeyType)k value:(ObjectType)v; // 设置key value
@end

@interface NSDictionary<KeyType, ObjectType> (RAMSafety)

/// 安全方法，即使传了key/value为空也没事。必须以nil为结尾
+(instancetype)kv:(id)firstObj, ...; //[NSDictionary kv:@"a", @1,  @"b", @2,  nil];
@end

@interface NSMutableAttributedString (RAMSafety)
+ (instancetype)yx_newWithString:(NSString *)string attributes:(nullable NSDictionary *)attrs;
@end

