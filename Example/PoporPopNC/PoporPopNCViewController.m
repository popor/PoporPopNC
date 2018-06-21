//
//  PoporPopNCViewController.m
//  PoporPopNC
//
//  Created by wangkq on 06/21/2018.
//  Copyright (c) 2018 wangkq. All rights reserved.
//

#import "PoporPopNCViewController.h"

#import "CheckVC.h"

@interface PoporPopNCViewController ()

@end

@implementation PoporPopNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"first";
    self.navigationController.title = self.title;
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextVC)];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
}

- (void)pushNextVC {
    [self.navigationController pushViewController:[CheckVC new] animated:YES];
}


@end
