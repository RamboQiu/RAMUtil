
#import <Foundation/Foundation.h>


#pragma mark - 收集实现了该宏的类

#define RAM_FUNCTIONNAME_EXPORT __attribute__((used, section("__RAM, __funcName"))) \
static const char *__ram_funcName__ = __func__

#pragma mark - 实现存储字符串
struct RAM_String {
    __unsafe_unretained NSObject *key;
    __unsafe_unretained NSObject *value;
};
/// id 参数，在同一个.m文件中调用此宏需要id唯一
#define RAM_STRINGS_EXPORT(key, value, id) __attribute__((used, section("__RAM,__ram.data"))) \
static const struct RAM_String __S##id= (struct RAM_String){key, value};

#pragma mark - 实现存储block
struct RAM_Block {
    char *key;
    __unsafe_unretained void (^block)(void);
};

#define RAM_BLOCKS_EXPORT(key, block) __attribute__((used, section("__RAM," "__"#key ".block"))) \
static const struct RAM_Block __B##key = (struct RAM_Block){((char *)&#key), block};

#pragma mark - 实现存储方法
struct RAM_Function {
    char *key;
    void (*function)(void);
};

#define RAM_FUNCTION_EXPORT(key) \
static void _ram##key(void); \
__attribute__((used, section("__RAM," "__"#key ".func"))) \
static const struct RAM_Function __F##key = (struct RAM_Function){(char *)(&#key), (void *)(&_ram##key)}; \
static void _ram##key \


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

- (BOOL)hasPlacedAtSection:(NSString *)section;
@end

