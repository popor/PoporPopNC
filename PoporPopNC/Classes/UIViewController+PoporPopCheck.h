//
//  UIViewController+PoporPopCheck.h
//  popor
//
//  Created by popor on 2017/4/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - VC 协议
@protocol PoporPopCheckDelegate <NSObject>
@optional

/// 是否需要拦截系统返回按钮的事件，只有当这里返回YES的时候，才会询问方法：`canPopViewControllerByButton`,'canPopViewControllerByPopGestureRecognizer'
- (BOOL)shouldHoldBackButtonEvent;

/// 是否允许点击返回按钮返回
- (BOOL)canPopViewControllerByButton;

/// 是否允许侧滑手势返回
- (BOOL)canPopViewControllerByPopGestureRecognizer;

// 假如 nc.viewcontrollers.count==1,侧滑会触发该函数.
- (void)rootVCDismissApply;

@end


@interface UIViewController (PoporPopCheck) <PoporPopCheckDelegate>

@end
