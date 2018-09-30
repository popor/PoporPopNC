//
//  NSObject+Swizzling.h
//  Term
//
//  Created by popor on 2017/10/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef id (^OCDynamicHookUtilsImpCallback)(id self,...);

@interface NSObject (Swizzling)

// 交换方法
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

/**
 OCDynamicHookUtils
 https://github.com/enefry/OCDynamicHookUtils
 */
+(BOOL)SwizzleClass:(Class)destClass instanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

+(BOOL)SwizzleClass:(Class)destClass classMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

+(BOOL)AddClassMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass;

+(BOOL)AddInstanceMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass;

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClass:(Class)destaClass toReplaceSelector:(SEL)selector;

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName;

+(BOOL)AddHookClassMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName;

@end
