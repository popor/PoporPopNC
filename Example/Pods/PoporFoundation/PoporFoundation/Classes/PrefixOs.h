//
//  PrefixSize.h
//  AppStore
//
//  Created by popor on 2017/7/6.
//  Copyright © 2017年 popor. All rights reserved.
//

#ifndef PrefixOs_h
#define PrefixOs_h

// UI系列
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH

#define VIEW_CLASS  UIView
#define VC_CLASS    UIViewController
#define BT_CLASS    UIButton
#define IV_CLASS    UIImageView

#define FONT_CLASS  UIFont
#define COLOR_CLASS UIColor


// NS系列
#elif TARGET_OS_MAC

#define VIEW_CLASS  NSView
#define VC_CLASS    NSViewController
#define BT_CLASS    NSButton
#define IV_CLASS    NSImageView

#define FONT_CLASS  NSFont
#define COLOR_CLASS NSColor

#endif




#endif /* PrefixOs_h */
