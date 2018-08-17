//
//  CheckVC.m
//  PoporPopNC_Example
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 wangkq. All rights reserved.
//

#import "CheckVC.h"

@interface CheckVC ()

@end

@implementation CheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"check";
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextVC)];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
}

- (void)pushNextVC {
    [self.navigationController pushViewController:[CheckVC new] animated:YES];
}

/// 是否需要拦截系统返回按钮的事件，只有当这里返回YES的时候，才会询问方法：`canPopViewControllerByButton`,'canPopViewControllerByPopGestureRecognizer'
- (BOOL)shouldHoldPopEvent {
    return YES;
}

/// 是否允许点击返回按钮返回
- (BOOL)canPopViewControllerByButton {
    [self showAlert];
    return NO;
}

/// 是否允许侧滑手势返回
- (BOOL)canPopViewControllerByPopGestureRecognizer {
    [self showAlert];
    return NO;
}

- (void)showAlert {
    {
        UIAlertController * oneAC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确认返回吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [oneAC addAction:cancleAction];
        [oneAC addAction:okAction];
        
        [self presentViewController:oneAC animated:YES completion:nil];
    }
}

@end
