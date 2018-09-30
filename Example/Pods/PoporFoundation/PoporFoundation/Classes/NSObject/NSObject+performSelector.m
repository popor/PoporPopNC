//
//  NSObject+performSelector.m
//  Term
//
//  Created by popor on 2017/10/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "NSObject+performSelector.h"
#import <objc/runtime.h>

@implementation NSObject (performSelector)

+ (void)target:(id)target voidAction:(SEL)action {
    if (!target) { return; }
    IMP imp = [target methodForSelector:action];
    void (*func)(id, SEL) = (void *)imp;
    func(target, action);
}

//// 带参数的和返回值的
//+ (void)target1:(id)target action:(SEL)action {
//    SEL selector = NSSelectorFromString(@"processRegion:ofView:");
//    IMP imp = [target methodForSelector:selector];
//    CGRect (*func)(id, SEL, CGRect, UIView *) = (void *)imp;
//    CGRect result = target ? func(target, selector, someRect, someView) : CGRectZero;
//}

@end
