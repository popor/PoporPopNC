//
//  UIViewController+ncBar.m
//  PoporUI
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIViewController+ncBar.h"
#import <objc/runtime.h>

@implementation UIViewController (ncBar)
@dynamic hiddenNcBar;

- (void)setHiddenNcBar:(BOOL)hiddenNcBar {
    objc_setAssociatedObject(self, @"hiddenNcBar", @(hiddenNcBar), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hiddenNcBar {
    NSNumber * n = objc_getAssociatedObject(self, @"hiddenNcBar");
    return n.boolValue;
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
