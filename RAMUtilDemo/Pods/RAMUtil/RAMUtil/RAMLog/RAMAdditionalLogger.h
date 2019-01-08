//
//  RAMAdditionalLogger.h, create by https://github.com/imoldman/AdditionalLogger
//

#import <Foundation/Foundation.h>

#ifndef ALLOGGERLEVELDEFINED
#define ALLOGGERLEVELDEFINED 1
#define ALLOGGERLEVEL_VERBOSE 1
#define ALLOGGERLEVEL_DEBUG 2
#define ALLOGGERLEVEL_INFO 3
#define ALLOGGERLEVEL_WARN 4
#define ALLOGGERLEVEL_ERROR 5
#endif

#define RAMLOG(level, content, ...) do { \
    [RAMAdditionalLogger logWithLevel:level file:__FILE__ line:__LINE__ prefix:"RAM" log:(content), ##__VA_ARGS__]; \
} while(0)

#define RAMLOG_VERBOSE(content, ...) RAMLOG(ALLOGGERLEVEL_VERBOSE, content, ##__VA_ARGS__)
#define RAMLOG_DBUG(content, ...) RAMLOG(ALLOGGERLEVEL_DEBUG, content, ##__VA_ARGS__)
#define RAMLOG_INFO(content, ...) RAMLOG(ALLOGGERLEVEL_INFO, content, ##__VA_ARGS__)
#define RAMLOG_WARN(content, ...) RAMLOG(ALLOGGERLEVEL_WARN, content, ##__VA_ARGS__)
#define RAMLOG_ERROR(content, ...) RAMLOG(ALLOGGERLEVEL_ERROR, content, ##__VA_ARGS__)


#ifndef ALLOGGERBLOCKTYPEDEFINED
#define ALLOGGERBLOCKTYPEDEFINED 1
typedef void(^ALLoggerBlockType)(int level, const char* fullpath, int line, const char* prefix, NSString* content);
#endif


@interface RAMAdditionalLogger : NSObject
+ (void)setBlock:(ALLoggerBlockType)block;
+ (ALLoggerBlockType)block;

+ (void)logWithLevel:(int)level file:(const char *)fullpath line:(int)line prefix:(const char*)prefix log:(NSString *)content, ...;
@end
