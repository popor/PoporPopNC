//
//  NSObject+Swizzling.m
//  Term
//
//  Created by popor on 2017/10/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "NSObject+Swizzling.h"

#import <objc/message.h>

@implementation NSObject (Swizzling)

// 交换方法
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector {
    if (!originalSelector || !swizzledSelector) {
        NSLog(@"交换方法失败! %s", __func__);
        return;
    }
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//
+(BOOL)SwizzleClass:(Class)destClass instanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector{
    Method originalMethod = class_getInstanceMethod(destClass, originalSelector);
    Method alternativeMethod = class_getInstanceMethod(destClass, newSelector);
    if(originalMethod==NULL||alternativeMethod==NULL){
        NSLog(@"交换方法失败! %s", __func__);
        return NO;
    }
    
    if(class_addMethod(destClass, originalSelector, method_getImplementation(alternativeMethod), method_getTypeEncoding(alternativeMethod))) {
        class_replaceMethod(destClass, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, alternativeMethod);
    }
    return YES;
}

+(BOOL)SwizzleClass:(Class)destClass classMethod:(SEL)originalSelector withMethod:(SEL)newSelector{
    return [self SwizzleClass:object_getClass(destClass) instanceMethod:originalSelector withMethod:newSelector];
}

+(BOOL)AddClassMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass{
    return [self AddInstanceMethod:methodTypes toSelector:selector implement:imp toClass:object_getClass(destClass)];
}

+(BOOL)AddInstanceMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass{
    return class_addMethod(destClass, selector, imp, methodTypes);
}

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClass:(Class)destaClass toReplaceSelector:(SEL)selector{
    if(destaClass == NULL || callback == NULL || selector == NULL){
        NSLog(@"交换方法失败! %s", __func__);
        return NO;
    }
    Method originMethod = class_getInstanceMethod(destaClass, selector);
    NSString *originSelectorName = NSStringFromSelector(selector);
    NSString *replaceSelectorName = [NSString stringWithFormat:@"%@_%@",@"rep",originSelectorName];
    SEL repSelector = NSSelectorFromString(replaceSelectorName);
    for(int i=1;[destaClass respondsToSelector:repSelector];i++){
        replaceSelectorName = [NSString stringWithFormat:@"%@%d_%@",@"rep",i,originSelectorName];
        repSelector = NSSelectorFromString(replaceSelectorName);
    }
    IMP imp = imp_implementationWithBlock(callback);
    
    if(!class_addMethod(destaClass, repSelector, imp , method_getTypeEncoding(originMethod))){
        NSLog(@"交换方法失败! %s", __func__);
        return NO;
    }
    [self SwizzleClass:destaClass instanceMethod:selector withMethod:repSelector];
    return YES;
}

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName{
    if(className==nil || selectorName==nil){
        NSLog(@"交换方法失败! %s", __func__);
        return NO;
    }
    return [self AddHookInstanceMethodImp:callback toClass:NSClassFromString(className) toReplaceSelector:NSSelectorFromString(selectorName)];
}

+(BOOL)AddHookClassMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName{
    if(className==nil || selectorName==nil){
        NSLog(@"交换方法失败! %s", __func__);
        return NO;
    }
    Class aClass = NSClassFromString(className);
    SEL selector = NSSelectorFromString(selectorName);
    if(aClass==nil ){
        return NO;
    }
    return [self AddHookInstanceMethodImp:callback toClass:object_getClass(aClass) toReplaceSelector:selector];
}

@end
