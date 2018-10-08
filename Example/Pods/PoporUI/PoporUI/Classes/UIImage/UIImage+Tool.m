//
//  UIImage+Tool.m
//  PoporUI
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//
#import "UIImage+Tool.h"

@implementation UIImage (Tool)

#pragma mark - 根据颜色
// 不继承最全的函数,是为了省资源
+ (UIImage *)imageFromColor:(UIColor*)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    UIImage* imageResult = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageResult;
}
// 不继承最全的函数,是为了省资源
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner
{
    CGFloat w = size.width;
    CGFloat h = size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (corner < 0){
        corner = 0;
    } else if (corner > MIN(w, h)){
        corner = MIN(w, h) / 2.0;
    }
    
    UIImage *image;
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:corner];
    [path addClip]; // 超出边界的,都会被忽略掉
    {
        //image = [UIImage imageFromColor:color size:size];
        //[image drawInRect:imageFrame]; // 这里也可以绘制同样效果的图片,比较浪费cpu.
    }
    [color setFill]; // 描边
    [path fill];     // 描边
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    return [UIImage imageFromColor:color size:size corner:corner corners:UIRectCornerAllCorners borderWidth:borderWidth borderColor:borderColor];
}

#pragma mark - 制定圆角
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    return [UIImage imageFromColor:color size:size inset:UIEdgeInsetsZero corner:corner corners:corners borderWidth:borderWidth borderColor:borderColor];
}

#pragma mark - 制定圆角, 移动
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size inset:(UIEdgeInsets)inset corner:(CGFloat)corner corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    CGFloat w = size.width;
    CGFloat h = size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (corner < 0){
        corner = 0;
    } else if (corner > MIN(w, h)){
        corner = MIN(w, h) / 2.0;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    UIBezierPath *path;// = [UIBezierPath bezierPath];
    // 添加圆到path
    CGRect rect;
    
    // UIEdgeInsetsZero的情况
    // rect = CGRectMake(borderWidth, borderWidth, w - borderWidth*2, h - borderWidth*2);
    rect = CGRectMake(  borderWidth + inset.left // 加上左边的set
                      , borderWidth + inset.top  // 加上上面的set
                      , w - borderWidth*2 - inset.left - inset.right   // 减去左边右边的set
                      , h - borderWidth*2 - inset.top  - inset.bottom);// 减去上边下边的set
    
    float radii = corner-borderWidth;
    path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    
    
    // 设置描边宽度（为了让描边看上去更清楚）
    [path setLineWidth:borderWidth];
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [borderColor setStroke]; // 描边
    [color setFill];         // 填充
    [path stroke];           // 描边
    [path fill];             // 填充
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 30 ], NSForegroundColorAttributeName :[ UIColor whiteColor ] }
+ (UIImage *)imageFromImage:(UIImage *)image str:(NSString *)str dic:(NSDictionary *)dic
{
    CGSize size= CGSizeMake(image.size.width, image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO, [UIScreen mainScreen].scale);
    
    [image drawAtPoint:CGPointMake (0 ,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context= UIGraphicsGetCurrentContext ();
    CGContextDrawPath (context, kCGPathStroke);
    
    CGSize strSize = [str sizeWithAttributes:dic];
    [str drawAtPoint:CGPointMake((size.width - strSize.width)/2, (size.height - strSize.height)/2) withAttributes:dic];
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    
    return newImage;
}


/**
 *  获取矩形的渐变色的UIImage(此函数还不够完善)
 *
 *  @param bounds          UIImage的bounds
 *  @param colors          渐变色数组，可以设置两种颜色
 *  @param gradientHorizon 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors gradientHorizon:(BOOL)gradientHorizon {
    CGPoint start;
    CGPoint end;
    
    if (gradientHorizon) {
        start = CGPointMake(0.0, 0.0);
        end = CGPointMake(bounds.size.width, 0.0);
    }else{
        start = CGPointMake(0.0, 0.0);
        end = CGPointMake(0.0, bounds.size.height);
    }
    
    UIImage *image = [self gradientImageWithBounds:bounds andColors:colors addStartPoint:start addEndPoint:end];
    return image;
}

+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors addStartPoint:(CGPoint)startPoint addEndPoint:(CGPoint)endPoint {
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);

    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}



//+ (UIImage *)imageInSize:(CGSize)size image:(UIImage *)image imagePoint:(CGPoint)imagePoint text:(NSString *)text textPoint:(CGPoint)textPoint
//{
//    UIGraphicsBeginImageContextWithOptions (size, NO, [UIScreen mainScreen].scale);
//
//    [image drawAtPoint:imagePoint];
//
//    // 获得一个位图图形上下文
//    CGContextRef context= UIGraphicsGetCurrentContext ();
//    CGContextDrawPath (context, kCGPathStroke);
//
//    [text drawAtPoint:textPoint withAttributes:dic];
//    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
//    UIGraphicsEndImageContext ();
//
//    return newImage;
//}

#pragma mark - 根据图片
//+ (UIImage*)imageFromImage:(UIImage*)image size:(CGSize)size
//{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
//}

+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size
{
    return [UIImage imageFromImage:image size:size corner:0 borderWidth:0 borderColor:nil];
}

+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size corner:(float)corner
{
    return [UIImage imageFromImage:image size:size corner:corner borderWidth:0 borderColor:nil];
}

+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)size corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect drawRect;
    {
        // 图片要居中显示
        float ImageOW = image.size.width;
        float ImageOH = image.size.height;
        float ImageMinScale = MIN(ImageOW/size.width, ImageOH/size.height);
        
        float ImageSW = ImageOW/ImageMinScale;
        float ImageSH = ImageOH/ImageMinScale;
        
        drawRect = CGRectMake(-(ImageSW-size.width)/2, -(ImageSH-size.height)/2, ImageSW, ImageSH);
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    UIBezierPath * path;// = [UIBezierPath bezierPath];
    if (corner>0) {
        // 添加圆到path
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth, borderWidth, size.width - borderWidth*2, size.height - borderWidth*2) cornerRadius:corner-borderWidth];
        [path addClip]; // 超出边界的,都会被忽略掉
    }else{
        path = [UIBezierPath bezierPath];
    }
    
    [image drawInRect:drawRect];
    if (borderWidth>0) {
        // 设置描边宽度（为了让描边看上去更清楚）
        [path setLineWidth:borderWidth];
        //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
        [borderColor setStroke]; // 描边
        [path stroke];           // 描边
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromImage:(UIImage *)image changecolor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageFromImage:(UIImage *)image bgColor:(UIColor *)color {
    CGSize size= CGSizeMake(image.size.width, image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO, [UIScreen mainScreen].scale);
    
    // 设置背景色
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    [image drawAtPoint:CGPointMake (0 ,0)];
    // 获得一个位图图形上下文
    CGContextRef context= UIGraphicsGetCurrentContext ();
    CGContextDrawPath (context, kCGPathStroke);
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    
    return newImage;
}

#pragma mark - 图片排列
+ (UIImage *)imageFromImageArray:(NSArray *)imageArray horizon:(BOOL)isHorizon
{
    UIImage * firstImage;
    UIImage * drawImage;
    CGRect  drawRect;
    float   imageW;
    float   imageH;
    if (imageArray.count>0) {
        firstImage = imageArray[0];
        if (isHorizon) {
            drawRect = CGRectMake(0, 0, firstImage.size.width*imageArray.count, firstImage.size.height);
        }else{
            drawRect = CGRectMake(0, 0, firstImage.size.width, firstImage.size.height*imageArray.count);
        }
        imageW = firstImage.size.width;
        imageH = firstImage.size.height;
    }else{
        return nil;
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(drawRect.size, NO, scale);
    for (int i=0; i<imageArray.count; i++) {
        UIImage * oneImage = imageArray[i];
        CGRect  oneRect;
        if (isHorizon) {
            oneRect = CGRectMake(imageW*i, 0, imageW, imageH);
        }else{
            oneRect = CGRectMake(0, imageH*i, imageW, imageH);
        }
        [oneImage drawInRect:oneRect];
    }
    
    drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return drawImage;
}

#pragma mark - 从View上截图
+ (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    } else {
        // 这是老版本方法,假如运行在ios10中,截取的NCBarTitle为半透明色
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 或许模仿苹果聊天的背景图片
+ (UIImage *)stretchableImage:(NSString *)imageName withOrient:(UIImageOrientation)direction withPoint:(CGPoint)thePoint
{
    UIImage * oneI;
    if (imageName==nil) {
        oneI=[UIImage imageNamed:@"chat.png"];
    }else {
        oneI=[UIImage imageNamed:imageName];
    }
    {
        UIImage * twoI=[UIImage imageWithCGImage:oneI.CGImage
                                           scale:1.0
                                     orientation:direction];
        return [twoI stretchableImageWithLeftCapWidth:thePoint.x
                                         topCapHeight:thePoint.y];
    }
    //    if (leftOrRight) {
    //        return [oneI stretchableImageWithLeftCapWidth:thePoint.x
    //                                         topCapHeight:thePoint.y];
    //    }else {
    //        UIImage * twoI=[UIImage imageWithCGImage:oneI.CGImage scale:1.0
    //                                     orientation:direction];
    //        return [twoI stretchableImageWithLeftCapWidth:thePoint.x
    //                                         topCapHeight:thePoint.y];
    //    }
}


#pragma mark - 读写函数

+ (NSString *)absoPathInBundleResource:(NSString *)fileName
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
}

+ (UIImage *)createWithImageName:(NSString *)imageName
{
    //return [UIImage imageNamed:imageName];
    return [UIImage imageWithContentsOfFile:[self absoPathInBundleResource:imageName]];
}

+ (UIImage *)createWithAbsImageName:(NSString *)imageName
{
    UIImage * image=[UIImage imageWithContentsOfFile:imageName];
    if (image.imageOrientation != UIImageOrientationUp) {
        image=[UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationUp];
    }
    return image;
}

+ (BOOL)saveImage:(UIImage *)image To:(NSString *)imagePath
{
    return [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

+ (NSString *)getAppLaunchImage
{
    NSDictionary * dic = @{
                           @"320x480" : @"LaunchImage-700",
                           @"320x568" : @"LaunchImage-700-568h",
                           @"375x667" : @"LaunchImage-800-667h",
                           @"414x736" : @"LaunchImage-800-Portrait-736h"
                           };
    NSString * key = [NSString stringWithFormat:@"%dx%d", (int)[UIScreen mainScreen].bounds.size.width, (int)[UIScreen mainScreen].bounds.size.height];
    return [dic objectForKey:key];
}


-(UIImage *)scale:(CGFloat)scale {
    CGSize size = CGSizeMake(self.size.width*scale, self.size.height*scale);
    
    CGImageRef imgRef = self.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);            //[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  设置CGContext集插值质量
     *  kCGInterpolationHigh 插值质量高
     */
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage *)scaleSize:(CGSize)size {
    return [self scale:(size.width / self.size.width)];
}

-(UIImage *)scaleW:(CGFloat)width {
    return [self scale:(width / self.size.width)];
}

/*
作者：ITCodeShare
链接：https://www.jianshu.com/p/99c3e6a6c033
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
*/
#pragma mark - 图片压缩
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

@end
