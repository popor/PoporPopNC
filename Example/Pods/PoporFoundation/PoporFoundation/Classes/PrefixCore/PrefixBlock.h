//
//  PrefixBlock.h
//  linRunShengPi
//
//  Created by popor on 2018/1/11.
//  Copyright © 2018年 popor. All rights reserved.
//

#ifndef PrefixBlock_h
#define PrefixBlock_h

// 函数中用到的
//(void (^)(void))block
//(void (^ __nullable)(BOOL finished))block

// 定义
// 返回为空
typedef void(^BlockPVoid)             (void);
typedef void(^BlockPInt)              (int number);
typedef void(^BlockPInteger)          (NSInteger number);
typedef void(^BlockPBool)             (BOOL value);
typedef void(^BlockPString)           (NSString * string);
typedef void(^BlockPDic)              (NSDictionary * dic);
typedef void(^BlockPData)             (NSData * data);
typedef void(^BlockPArray)            (NSArray * array);
typedef void(^BlockPMArray)           (NSMutableArray * array);

typedef void(^BlockPID)               (id sender);

#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
#import <UIKit/UIKit.h>
typedef void(^BlockPUIButton)         (UIButton * bt);
typedef void(^BlockPUIView)           (UIView * view);
typedef void(^BlockPUIImageView)      (UIImageView * iv);
typedef void(^BlockPUIViewController) (UIViewController * vc);

#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
typedef void(^BlockPUIButton)         (NSButton * bt);
typedef void(^BlockPUIView)           (NSView * view);
typedef void(^BlockPUIImageView)      (NSImageView * iv);
typedef void(^BlockPUIViewController) (NSViewController * vc);

#endif



// property用到的
//@property (nonatomic, copy  ) NSString *(^someblock)(NSString *name);

#endif /* PrefixBlock_h */

