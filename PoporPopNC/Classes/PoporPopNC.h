//
//  PoporPopNC.h
//  popor
//
//  Created by popor on 2017/4/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 不在模拟器中工作,因为会崩溃.
 
 It doesn't work in the simulator because it will crash.
    -- by http://cidian.youdao.com/
 
//*/

@interface PoporPopNC : UINavigationController

@property (nonatomic, getter=isUpdateBarBackTitle) BOOL updateBarBackTitle;
@property (nonatomic, strong) NSString * barBackTitle; // 如果
@property (nonatomic, strong) UIImage * barBackImage;

@property (nonatomic        ) BOOL autoHidesBottomBarWhenPushed;
@property (nonatomic        ) BOOL forbiddenPushSameViewController;

- (void)setInteractivePopGRDelegate;

@end
