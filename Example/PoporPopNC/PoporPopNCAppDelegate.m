//
//  PoporPopNCAppDelegate.m
//  PoporPopNC
//
//  Created by wangkq on 06/21/2018.
//  Copyright (c) 2018 wangkq. All rights reserved.
//

#import "PoporPopNCAppDelegate.h"

#import <PoporPopNC/PoporPopNC.h>
#import <PoporFoundation/SizePrefix.h>
#import <PoporFoundation/ColorPrefix.h>
#import <PoporUI/UIImage+Tool.h>


#import "PoporPopNCViewController.h"

@implementation PoporPopNCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PoporPopNC * nc = [[PoporPopNC alloc] initWithRootViewController:[PoporPopNCViewController new]];
    nc.barBackImage = [UIImage imageNamed:@"NCBack"];
    
    __weak typeof(nc) weakNC = nc;
    nc.barTitleColorStyleBlock = ^{
        // 设置标题颜色
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [dict setObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName];
        weakNC.navigationBar.titleTextAttributes = dict;
        // 设置bar背景颜色
        //[self.navigationBar setBarTintColor:RGB16(0X4077ED)];
        //[self.navigationBar setBarTintColor:ColorNCBar];
        //RGB16(0X68D3FF)
        [weakNC.navigationBar setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenSize.width, 1)
                                                                      andColors:@[RGB16(0X68D3FF), RGB16(0X4585F5)] gradientHorizon:YES] forBarMetrics:UIBarMetricsDefault];
        // 设置返回按钮字体颜色.
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        // 需要设置plist以下2项,才可以起作用.
        // View controller-based status bar appearance : NO
        // Status bar style : Opaque black style
        // https://www.jianshu.com/p/68e0c19ffa1f
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    };
    
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
