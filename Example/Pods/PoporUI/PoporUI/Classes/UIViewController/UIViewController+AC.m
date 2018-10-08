//
//  UIViewController+AC.m
//  PoporUI
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIViewController+AC.h"

#import <objc/runtime.h>
#import <PoporFoundation/NSObject+Swizzling.h>
#import <PoporFoundation/prefixFun.h>

@implementation UIViewController (AC)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(presentViewController:animated:completion:) bySwizzledSelector:@selector(safePresentViewController:animated:completion:)];
    });
}

- (void)safePresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController * ac = (UIAlertController *)viewControllerToPresent;
        if (ac.preferredStyle == UIAlertControllerStyleActionSheet) {
            if (IsIpadDevice) {
                UIPopoverPresentationController *popPresenter = [ac popoverPresentationController];
                if (!popPresenter.sourceView) {
                    popPresenter.sourceView = self.view;
                    popPresenter.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 50, 1, 1);
                }
            }
        }
    }
    
    [self safePresentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
