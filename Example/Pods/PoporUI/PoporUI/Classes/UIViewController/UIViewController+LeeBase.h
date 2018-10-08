

#import <UIKit/UIKit.h>

@interface UIViewController (LeeBase)
- (UIBarButtonItem *)loadLeftItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (UIBarButtonItem *)loadRightItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title color:(UIColor *)titleColor target:(id)target action:(SEL)action;
- (UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title color:(UIColor *)titleColor target:(id)target action:(SEL)action;

- (UIBarButtonItem *)itemWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

//- (void)loadWxChatVCLeftItemWithTitle:(NSString *)title action:(SEL)action;

- (void)loadItemWithFirstImage:(UIImage *)image1 firstAction:(SEL)action1
                   secondImage:(UIImage *)image2 secondAction:(SEL)action2
                        target:(id)target
                          left:(BOOL)isLeft;

#pragma mark - 返回方法
- (void)popVC_leeBase;

@end
