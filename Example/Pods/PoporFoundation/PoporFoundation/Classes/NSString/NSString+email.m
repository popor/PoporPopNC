//
//  NSString+email.m
//  WanziTG
//
//  Created by popor on 2017/1/9.
//  Copyright © 2017年 popor. All rights reserved.
//

#import "NSString+email.h"

// ---- 原因https://blog.csdn.net/wxs0124/article/details/50148873
//自定义的打印日志宏 如：
//＃define TWLOGPRINT(xx, …) NSLog(@”%s(%d): ” xx, PRETTY_FUNCTION, LINE, ##VA_ARGS)
//这个宏定义放在了 A.h 中 在B.m文件中使用的时候没有＃import “A.h”
//
//解决办法：
//＃import ”宏定义所在的文件“
#import "NSString+Tool.h"

@implementation NSString (email)

#pragma mark - 判断邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email
{
    if (email.length == 0) {
        return YES;
    }else{
        email = [NSString replaceString:email withREG:EmailRegStr withNewString:@""];
        if ([email isEqualToString:@""]) {
            return YES;
        }else{
            return NO;
        }
    }
}

@end
