//
//  NSString+format.m
//  Wanzi
//
//  Created by popor on 2016/11/8.
//  Copyright © 2016年 popor. All rights reserved.
//

#import "NSString+format.h"
#import <CoreText/CoreText.h>

//#pragma mark - iOS
//#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
@implementation NSString (format)

+ (NSMutableAttributedString *)underLineAttString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color
{
    NSRange range = (NSRange){0, string.length};
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    // 下划线
    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:range];
    // font
    [attString addAttribute:NSFontAttributeName value:font range:range];
    // color
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attString;
}

@end


@implementation NSMutableAttributedString (format)

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color
{
    [self addString:string font:font color:color underline:NO];
}

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color underline:(BOOL)isUnderLine
{
    [self addString:string font:font color:color bgColor:nil underline:isUnderLine];
}

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color bgColor:(COLOR_CLASS *)bgColor underline:(BOOL)isUnderLine
{
    if (!string) {
        return;
    }
    NSRange range = NSMakeRange(0, string.length);
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    if (isUnderLine) {
        // 下划线
        [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:range];
    }
    if (font) {
        [attString addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (bgColor) {
        [attString addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    }
    
    [self appendAttributedString:attString];
}

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color bgColor:(COLOR_CLASS *)bgColor underline:(BOOL)isUnderLine lineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (!string) {
        return;
    }
    NSRange range = NSMakeRange(0, string.length);
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    if (isUnderLine) {
        // 下划线
        [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:range];
    }
    if (font) {
        [attString addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (bgColor) {
        [attString addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (lineSpacing>-1) {
        paragraphStyle.lineSpacing = lineSpacing;
        [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    
    [paragraphStyle setAlignment:textAlignment];
    [paragraphStyle setLineBreakMode:lineBreakMode];
    
    [self appendAttributedString:attString];
}

// 用于纠正不同字体之间的文字,不会行居中的问题,用于•
- (void)setBaselineOffsetMaxFont:(float)maxFont miniFont:(float)miniFont range:(NSRange)range
{
    [self addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (maxFont - miniFont)) range:range];
}

- (void)setBaselineOffsetMaxFont:(float)maxFont miniFont:(float)miniFont scale:(float)scale range:(NSRange)range
{
    [self addAttribute:NSBaselineOffsetAttributeName value:@(scale * (maxFont - miniFont)) range:range];
}

#pragma mark - Size Department
- (CGSize)sizeWithWidth:(CGFloat)width {
    // UI系列
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    
    // NS系列
#elif TARGET_OS_MAC
    if (@available(macOS 10.11, *)) {
        return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    } else {
        NSLog(@"10.11之前的系统不支持该方法: %s", __func__);
        return CGSizeZero;
    }
    
#endif

}

@end


