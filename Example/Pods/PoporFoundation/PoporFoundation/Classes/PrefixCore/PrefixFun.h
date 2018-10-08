//
//  PrefixFun.h
//  linRunShengPi
//
//  Created by popor on 2018/2/1.
//  Copyright © 2018年 popor. All rights reserved.
//

#ifndef PrefixFun_h
#define PrefixFun_h


#ifndef dispatch_main_async_safe_sd
#define dispatch_main_async_safe_sd(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#define WeakSelf(weakSelf) __weak __typeof(self)weakSelf = self

// 标记开发状态
#ifndef __OPTIMIZE__
#define IsDebugVersion                     YES
#else
#define IsDebugVersion                     NO
#endif

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)

#define NSLogSuccess(FORMAT, ...) NSLog(@"%s: %s", [@"✅" UTF8String], [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define NSLogError(FORMAT, ...)   NSLog(@"%s: %s", [@"❌" UTF8String], [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define NSLogWarm(FORMAT, ...)    NSLog(@"%s: %s", [@"⚠️" UTF8String], [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

// fprintf 和 printf 参数不一致
#define NSPrintInfo(FORMAT, ...) fprintf(stderr,"\n函数:%s 行:%d 内容:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define NSLogInfo(FORMAT, ...)   NSLog(@"函数:%s 行:%d 内容:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])


//#define NSLogInfo1(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#define NSLogInfo2(FORMAT, ...) printf("\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#define NSLog2(format, ...) printf("func:%s:\n%s\n---------------------\n\n", __PRETTY_FUNCTION__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#define NSLogRect(rect)		NSLog(@"CGRect:%s \t= %@", #rect, NSStringFromCGRect(rect));
#define NSLogSize(size)		NSLog(@"CGSize:%s \t= %@", #size, NSStringFromCGSize(size));
#define NSLogPoint(point)	NSLog(@"CGPoint:%s \t= %@", #point, NSStringFromCGPoint(point));
#define NSLogRange(range)	NSLog(@"NSRange:%s \t= %@", #range, NSStringFromRange(range));

#else

#define NSLog(...) {}

#define NSLogSuccess(FORMAT, ...) {}
#define NSLogError(FORMAT, ...) {}
#define NSLogWarm(FORMAT, ...) {}

#define NSPrintInfo(FORMAT, ...) {}
#define NSLogInfo(FORMAT, ...) ()

#define NSLogRect(rect) {}
#define NSLogSize(size) {}
#define NSLogPoint(point) {}
#define NSLogRange(range) {}

#endif

#define IsIphoneDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsIpadDevice   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 版本号小于11 */
#define IsVersionLessThan11 [UIDevice currentDevice].systemVersion.doubleValue < 11.0

#endif /* PrefixFun_h */
