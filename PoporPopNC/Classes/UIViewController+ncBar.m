//
//  UIViewController+ncBar.m
//  popor
//
//  Created by popor on 2017/4/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "UIViewController+ncBar.h"
#import <objc/runtime.h>

@implementation UIViewController (ncBar)
@dynamic needHiddenNVBar;

- (void)setNeedHiddenNVBar:(NSNumber *)needHiddenNVBar {
    objc_setAssociatedObject(self, @"needHiddenNVBar", needHiddenNVBar, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)needHiddenNVBar {
    return objc_getAssociatedObject(self, @"needHiddenNVBar");
}

- (BOOL)isInNC {
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if (vc == self) {
            return YES;
        }
    }
    return NO;
}

@end
