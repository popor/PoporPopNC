//
//  PrefixColor.h
//  AppStore
//
//  Created by popor on 2017/7/5.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "PrefixOs.h"

#import <CoreGraphics/CoreGraphics.h>

// need:UIKit,CoreGraphics
CG_INLINE COLOR_CLASS * RGBA(float R, float G, float B, float F) {
    return [COLOR_CLASS colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:F];
};

// need:UIKit,CoreGraphics
CG_INLINE COLOR_CLASS * RGB16(unsigned long rgbValue) {
    return [COLOR_CLASS colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
};

CG_INLINE COLOR_CLASS * RGB16A(unsigned long rgbValue, float F) {
    return [COLOR_CLASS colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:F];
};

#ifndef PrefixColor_h
#define PrefixColor_h

//------------------------------------------------------------------------------

#define ColorOrange1   RGB16(0XFD9503)

#define ColorBlue1     RGB16(0X4585F5)// 蓝色: 用于顶部bar底色，底部ab选中状态,用于按钮，突出、选中的文字
#define ColorBlue2     RGB16(0X266ff0)// 蓝色按钮点击按下状态 的颜色
#define ColorBlue3     RGB16(0X74a6fb)// 蓝色按钮禁用状态的颜色

#define ColorCyan1     RGB16(0X29CCB6)// 青色: 用于强调突出的按钮
#define ColorCyan2     RGB16(0X15bca5)// 青色按钮按下后状态的颜色

#define ColorRed1      RGB16(0XE84855)// 红色: 用于提醒、需示文物状态标签

#define ColorRedLight1 RGB16(0XFCEAEC)// 淡红色 -- 红色按钮正常状态背景色
#define ColorRedLight2 RGB16(0XFBDDE0)// 淡红色 -- 红色按钮按下状态背景色

// 间隔线条颜色
#define ColorLine      RGB16(0XE3E3E3)// 分割线
#define ColorBG1       RGB16(0XF7F7F7)// 用于内容区域背底色

// 常用的4个黑色
#define ColorBlackC    RGB16(0XCCCCCC)// 用于辅助，提示性文字和icon
#define ColorBlack3    RGB16(0X333333)
#define ColorBlack6    RGB16(0X666666)
#define ColorBlack9    RGB16(0X999999)

//------------------------------------------------------------------------------
#define ColorNCBar          ColorBlue1
#define ColorTV_DefaultBG   RGBA(240, 240, 240, 1) //RGBA(240, 240, 240, 1), 之前颜色
#define ColorTV_BG          ColorBG1
#define ColorTV_separator   ColorLine

#endif /* PrefixColor_h */
