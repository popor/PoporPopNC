//
//  NSString+Size.h
//  Wanzi
//
//  Created by popor on 2016/10/20.
//  Copyright © 2016年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrefixOs.h"

@interface NSString (Size)

- (CGSize)sizeInFont:(FONT_CLASS *)font;

- (CGSize)sizeInFont:(FONT_CLASS *)font width:(float)width;

- (CGSize)sizeAttrSpace:(CGFloat)lineSpeace withFont:(FONT_CLASS*)font withWidth:(CGFloat)width;
@end




