//
//  NSString+format.h
//  Wanzi
//
//  Created by popor on 2016/11/8.
//  Copyright © 2016年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixOs.h"

@interface NSString (format)

+ (NSMutableAttributedString *)underLineAttString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color;

@end


@interface NSMutableAttributedString (format)

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color;
- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color underline:(BOOL)isUnderLine;
- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color bgColor:(COLOR_CLASS *)bgColor underline:(BOOL)isUnderLine;

- (void)addString:(NSString *)string font:(FONT_CLASS *)font color:(COLOR_CLASS *)color bgColor:(COLOR_CLASS *)bgColor underline:(BOOL)isUnderLine lineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment lineBreakMode:(NSLineBreakMode)lineBreakMode;

// 用于纠正不同字体之间的文字,不会行居中的问题
- (void)setBaselineOffsetMaxFont:(float)maxFont miniFont:(float)miniFont range:(NSRange)range;
- (void)setBaselineOffsetMaxFont:(float)maxFont miniFont:(float)miniFont scale:(float)scale range:(NSRange)range;

#pragma mark - Size Department
- (CGSize)sizeWithWidth:(CGFloat)width;

@end

