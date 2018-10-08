

#import "UIViewController+LeeBase.h"

#import <PoporFoundation/NSString+Size.h>

// NCbartitle 颜色
#define NCBarTitleColor   [UIColor colorWithRed:60.0/255.0f green:60.0/255.0f blue:60.0/255.0f alpha:1]

@implementation UIViewController (LeeBase)

- (UIBarButtonItem *)loadLeftItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [self itemWithImage:image title:nil titleColor:nil target:target action:action isLeft:YES];
}

- (UIBarButtonItem *)loadRightItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [self itemWithImage:image title:nil titleColor:nil target:target action:action isLeft:NO];
}

- (UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self itemWithImage:nil title:title titleColor:nil target:target action:action isLeft:YES];
}

- (UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self itemWithImage:nil title:title titleColor:nil target:target action:action isLeft:NO];
}

- (UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title color:(UIColor *)titleColor target:(id)target action:(SEL)action {
    return [self itemWithImage:nil title:title titleColor:titleColor target:target action:action isLeft:YES];
}

- (UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title color:(UIColor *)titleColor target:(id)target action:(SEL)action {
    return [self itemWithImage:nil title:title titleColor:titleColor target:target action:action isLeft:NO];
}

- (UIBarButtonItem *)itemWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIBarButtonItem *saveItem;
    if (!image && !title) {
        title = @"";
    }
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        saveBtn.frame=CGRectMake(0, 5, MAX(CGImageGetWidth(image.CGImage)/2, 54), 34);
        [saveBtn setImage:image forState:UIControlStateNormal];
        //saveBtn.backgroundColor = [UIColor redColor];
    }else{
        [saveBtn setTitle:title forState:UIControlStateNormal];
        if (titleColor) {
            [saveBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }else{
            [saveBtn setTitleColor:NCBarTitleColor forState:UIControlStateNormal];
        }
        
        [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        
        CGSize size = [title sizeInFont:saveBtn.titleLabel.font width:100];
        [saveBtn setFrame:CGRectMake(0, 5, MAX(size.width, 54), 34)];
    }
    if (isLeft) {
        saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else{
        saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    if (target) {
        [saveBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        [saveBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    saveItem=[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    if (isLeft) {
        self.navigationItem.leftBarButtonItem  = saveItem;
    }else{
        self.navigationItem.rightBarButtonItem = saveItem;
    }
    return saveItem;
}

#pragma mark - 旺信聊天详情返回按钮
- (void)loadWxChatVCLeftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    //    UIFont * titleFont  = [UIFont systemFontOfSize:15.0];
    //
    //    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:titleFont, NSFontAttributeName,nil];
    //
    //    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(80, 44) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    //
    //    UIButton * saveBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    //    saveBtn.frame = CGRectMake(0, 0, 9+titleSize.width, 44);
    //
    //    [saveBtn setImage:[BITool commonImageNamed:@"common_back_btn_dark_small"] forState:UIControlStateNormal];
    //    [saveBtn setTitle:title forState:UIControlStateNormal];
    //    [saveBtn setTitleColor:NCBarTitleColor forState:UIControlStateNormal];
    //    saveBtn.titleLabel.font = titleFont;
    //    [saveBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //    [saveBtn addTarget:self target:target action:action forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    //
    //    self.navigationItem.leftBarButtonItem = barButtonItem;
}

#pragma mark - 两个按钮的情况
- (void)loadItemWithFirstImage:(UIImage *)image1 firstAction:(SEL)action1
                   secondImage:(UIImage *)image2 secondAction:(SEL)action2
                        target:(id)target
                          left:(BOOL)isLeft {
    UIButton * saveBtn1;
    UIButton * saveBtn2;
    
    {
        saveBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn1.frame=CGRectMake(0, 0, MAX(CGImageGetWidth(image1.CGImage)/2, 20), 44);
        [saveBtn1 setImage:image1 forState:UIControlStateNormal];
        if (target) {
            [saveBtn1 addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];
        }else{
            [saveBtn1 addTarget:self action:action1 forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        saveBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn2.frame=CGRectMake(0, 0, MAX(CGImageGetWidth(image2.CGImage)/2, 20), 44);
        [saveBtn2 setImage:image2 forState:UIControlStateNormal];
        if (target) {
            [saveBtn2 addTarget:target action:action2 forControlEvents:UIControlEventTouchUpInside];
        }else{
            [saveBtn2 addTarget:self action:action2 forControlEvents:UIControlEventTouchUpInside];
        }
    }
    if (isLeft) {
        saveBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        saveBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else{
        saveBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        saveBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    UIBarButtonItem * barBT1 = [[UIBarButtonItem alloc] initWithCustomView:saveBtn1];
    UIBarButtonItem * barBT2 = [[UIBarButtonItem alloc] initWithCustomView:saveBtn2];
    if (isLeft) {
        [self.navigationItem setLeftBarButtonItems:@[barBT1, barBT2]];
    }else{
        [self.navigationItem setRightBarButtonItems:@[barBT1, barBT2]];
    }
}

#pragma mark - 返回方法
- (void)popVC_leeBase {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
