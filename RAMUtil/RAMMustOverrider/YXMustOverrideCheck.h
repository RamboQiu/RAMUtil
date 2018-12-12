
#import <Foundation/Foundation.h>

#define RAM_SUBCLASS_MUST_OVERRIDE __attribute__((used, section("__DATA,RAMMustOverride" \
))) static const char *__must_override_entry__ = __func__
