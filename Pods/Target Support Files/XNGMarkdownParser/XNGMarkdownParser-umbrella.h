#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "fmemopen.h"
#import "XNGMarkdownParser.h"
#import "XNGMarkdownTokens.h"

FOUNDATION_EXPORT double XNGMarkdownParserVersionNumber;
FOUNDATION_EXPORT const unsigned char XNGMarkdownParserVersionString[];

