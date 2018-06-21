//
//  PoporPopNC.m
//  popor
//
//  Created by popor on 2017/4/25.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "PoporPopNC.h"

#import "UIViewController+ncBar.h"
#import "UIViewController+PoporPopCheck.h"

#import <objc/runtime.h>
#import <PoporFoundation/NSObject+Swizzling.h>

@interface PoporPopNC () <UINavigationControllerDelegate>

// 是否通过手势返回
@property (nonatomic, getter=isPopByGR) BOOL popByGR;
// 当前是否可以返回
@property (nonatomic, getter=isPopAvailable) BOOL popAvailable;

@end

@implementation PoporPopNC

#if !TARGET_IPHONE_SIMULATOR
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(popViewControllerAnimated:) bySwizzledSelector:@selector(lockPopViewControllerAnimated:)];
        
        [self methodSwizzlingWithOriginalSelector:@selector(popToViewController:animated:) bySwizzledSelector:@selector(lockPopToViewController:animated:)];
    });
}

- (void)lockPopViewControllerAnimated:(BOOL)animated {
    if (self.isPopAvailable) {
        //NSLog(@"ParentNC侧滑: Runtime交换pop函数 执行 1");
        self.popAvailable = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lockPopViewControllerAnimated:animated];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.popAvailable = YES;
            });
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lockPopViewControllerAnimated:animated];
        });
        //NSLog(@"ParentNC侧滑: Runtime交换pop函数 异常执行 1");
    }
}

- (nullable NSArray<__kindof UIViewController *> *)lockPopToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.isPopAvailable) {
        self.popAvailable = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.popAvailable = YES;
        });
        return [self lockPopToViewController:viewController animated:animated];
    }else {
        return nil;
    }
}
#endif

#pragma mark - 初始化
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController updateBarBackTitle:(BOOL)updateBarBackTitle barBackTitle:(NSString *)barBackTitle {
    PoporPopNC * nc = [super initWithRootViewController:rootViewController];
    nc.updateBarBackTitle = updateBarBackTitle;
    nc.barBackTitle       = barBackTitle;
    
    if (nc.isUpdateBarBackTitle) {
        rootViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nc.barBackTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    nc.popAvailable = YES;
    
    return nc;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    PoporPopNC * nc = [super initWithRootViewController:rootViewController];
    nc.popAvailable = YES;
    return nc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.delegate                  = self;
    
    [self setInteractivePopGRDelegate];
}

- (void)setBarTitleColorStyleBlock:(void (^)(void))barTitleColorStyleBlock {
    barTitleColorStyleBlock();
}

- (void)setBarBackImage:(UIImage *)barBackImage{
    self.navigationBar.backIndicatorImage               = barBackImage;
    self.navigationBar.backIndicatorTransitionMaskImage = barBackImage;
}

- (void)setInteractivePopGRDelegate {
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

//- (void)barTitleColorStyleEvent {
//    // 设置标题颜色
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//    [dict setObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName];
//
//    self.navigationBar.titleTextAttributes = dict;
//
//    // 设置bar背景颜色
//    //[self.navigationBar setBarTintColor:RGB16(0X4077ED)];
//    //[self.navigationBar setBarTintColor:ColorNCBar];
//    //RGB16(0X68D3FF)
//    [self.navigationBar setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenSize.width, 1) andColors:@[RGB16(0X68D3FF), RGB16(0X4585F5)] gradientHorizon:YES] forBarMetrics:UIBarMetricsDefault];
//
//
//    // 设置返回按钮字体颜色.
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    // 需要设置plist以下2项,才可以起作用.
//    // View controller-based status bar appearance : NO
//    // Status bar style : Opaque black style
//    // https://www.jianshu.com/p/68e0c19ffa1f
//
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//}

// 是否隐藏状态栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigationController setNavigationBarHidden:viewController.needHiddenNVBar.boolValue animated:YES];
}

// 设置返回按钮title
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.isUpdateBarBackTitle) {
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.barBackTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    if (self.forbiddenPushSameViewController) {
        if(![self.topViewController isMemberOfClass:[viewController class]]){
            if (self.autoHidesBottomBarWhenPushed) {
                if (self.viewControllers.count > 0) {
                    viewController.hidesBottomBarWhenPushed = YES;
                }
            }
            [super pushViewController:viewController animated:animated];
        }else{
            NSLog(@"PoporPopNC: forbidden Push Same ViewController.");
        }
    }else{
        [super pushViewController:viewController animated:animated];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count == 1) {
            [self.topViewController rootVCDismissApply];
            return NO;
        }else{
            self.popByGR = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.popByGR = NO;
                });
            });
#if TARGET_IPHONE_SIMULATOR
            return YES;
#else
            if ([self canPopInteractorViewController:self.topViewController]) {
                //NSLog(@"ParentNC侧滑: 允许侧滑");
                return YES;
            }else{
                //NSLog(@"ParentNC侧滑: 不允许侧滑");
                return NO;
            }
#endif
        }
    }else{
        return YES;
    }
}

#if !TARGET_IPHONE_SIMULATOR
// 返回按钮+侧滑总入口
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    //NSLog(@"ParentNC总开关: 返回按钮_侧滑判断 0");
    if (!self.isPopAvailable && !self.isPopByGR) {
        //NSLog(@"ParentNC总开关: 返回按钮_侧滑判断 1, 防止快速点击, 返回YES并且修正导航栏UI");
        [self resetSubviewsInNavBar:navigationBar];
        return YES;
    }
    // 如果nav的vc栈中有两个vc，第一个是root，第二个是second。这是second页面如果点击系统的返回按钮，topViewController获取的栈顶vc是second，而如果是直接代码写的pop操作，则获取的栈顶vc是root。也就是说只要代码写了pop操作，则系统会直接将顶层vc也就是second出栈，然后才回调的，所以这时我们获取到的顶层vc就是root了。然而不管哪种方式，参数中的item都是second的item。
    UINavigationItem * cItem = self.topViewController.navigationItem;
    BOOL isPopedByCoding = item != cItem;
    
    // !isPopedByCoding 要放在前面，这样当 !isPopedByCoding 不满足的时候就不会去询问 canPopViewController 了，可以避免额外调用 canPopViewController 里面的逻辑导致
    BOOL canPopViewController = !isPopedByCoding && [self canPopBtViewController:self.topViewController ?: [self topViewController]];
    
    BOOL isCan = YES;
    if (canPopViewController || isPopedByCoding) {
        if (self.isPopByGR) {
            self.popByGR = NO;
            //NSLog(@"ParentNC总开关: __0 未执行返回事件");
        }else{
            if (self.isPopAvailable) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self popViewControllerAnimated:YES];
                });
                //NSLog(@"ParentNC总开关: __1 执行了返回事件");
            }else{
                //NSLog(@"ParentNC总开关: __2 未执行返回事件");
            }
        }
        isCan = YES;
    } else {
        //NSLog(@"ParentNC总开关: __3 未执行返回事件");
        //[self resetSubviewsInNavBar:navigationBar];
        isCan = NO;
    }
    
    [self resetSubviewsInNavBar:navigationBar];
    return isCan;
}

// 更新navBar UI
- (void)resetSubviewsInNavBar:(UINavigationBar *)navBar {
    // Workaround for >= iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
    for(UIView *subview in [navBar subviews]) {
        if(subview.alpha < 1.0) {
            [UIView animateWithDuration:.25 animations:^{
                subview.alpha = 1.0;
            }];
        }
    }
}

#pragma mark - 工具函数
- (BOOL)canPopBtViewController:(UIViewController *)viewController {
    BOOL canPopViewController = YES;
    
    if ([viewController respondsToSelector:@selector(shouldHoldBackButtonEvent)] &&
        [viewController shouldHoldBackButtonEvent] &&
        [viewController respondsToSelector:@selector(canPopViewControllerByButton)] &&
        ![viewController canPopViewControllerByButton]) {
        canPopViewController = NO;
    }
    
    return canPopViewController;
}

- (BOOL)canPopInteractorViewController:(UIViewController *)viewController {
    BOOL canPopViewController = YES;
    
    if ([viewController respondsToSelector:@selector(shouldHoldBackButtonEvent)] &&
        [viewController shouldHoldBackButtonEvent] &&
        [viewController respondsToSelector:@selector(canPopViewControllerByPopGestureRecognizer)] &&
        ![viewController canPopViewControllerByPopGestureRecognizer]) {
        canPopViewController = NO;
    }
    
    return canPopViewController;
}
#endif

@end
