//
//  UIImage+Tool.h
//  PoporUI
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (Tool)

#pragma mark - 根据颜色
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner;
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size inset:(UIEdgeInsets)inset corner:(CGFloat)corner corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 30 ], NSForegroundColorAttributeName :[ UIColor whiteColor ] }
// 文字在图片中间
+ (UIImage *)imageFromImage:(UIImage *)image str:(NSString *)str dic:(NSDictionary *)dic;

//  CGSize strSize = [str sizeWithAttributes:dic];
//+ (UIImage *)imageInSize:(CGSize)size image:(UIImage *)image imagePoint:(CGPoint)imagePoint text:(NSString *)text textPoint:(CGPoint)textPoint;

// 渐变色
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors gradientHorizon:(BOOL)gradientHorizon;

#pragma mark - 根据图片
+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size corner:(float)corner;
+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)imageFromImage:(UIImage *)image changecolor:(UIColor *)color;
+ (UIImage *)imageFromImage:(UIImage *)image bgColor:(UIColor *)color;

#pragma mark - 图片排列
+ (UIImage *)imageFromImageArray:(NSArray *)imageArray horizon:(BOOL)isHorizon;

#pragma mark - 从View上截图
+ (UIImage *)imageFromView:(UIView *)view;

#pragma mark - 或许模仿苹果聊天的背景图片
+ (UIImage *)stretchableImage:(NSString *)imageName withOrient:(UIImageOrientation)direction withPoint:(CGPoint)thePoint;

#pragma mark - 读写函数
+ (NSString *)absoPathInBundleResource:(NSString *)fileName;// 只用下一个就足够了.
+ (UIImage *)createWithImageName:(NSString *)imageName;
+ (UIImage *)createWithAbsImageName:(NSString *)imageName;

+ (BOOL)saveImage:(UIImage *)image 	To:(NSString *)imagePath;

+ (NSString *)getAppLaunchImage;

//#pragma mark - 修改图片尺寸
/**
 图片等比缩放  scale:缩放百分比
 */
-(UIImage *)scale:(CGFloat)scale;
-(UIImage *)scaleSize:(CGSize)size;
-(UIImage *)scaleW:(CGFloat)width;


@end

/*
 // 单独某个角设置圆角
 UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.noteReadStatusL.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CustomizeCellCorner, CustomizeCellCorner)];
 
 CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
 maskLayer.frame = self.noteReadStatusL.bounds;
 maskLayer.path = maskPath.CGPath;
 self.noteReadStatusL.layer.mask = maskLayer;
 */
