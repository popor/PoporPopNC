//
//  UIViewController+ncBar.h
//  popor
//
//  Created by popor on 2017/4/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ncBar)

@property (nonatomic, strong) NSNumber * needHiddenNVBar;// 隐藏导航栏的视图

- (BOOL)isInNC;

@end
