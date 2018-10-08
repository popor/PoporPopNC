//
//  NSString+MD5.h
//  linRunShengPi
//
//  Created by popor on 2017/12/26.
//  Copyright © 2017年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>

// 代码来源: http://blog.csdn.net/u011349387/article/details/47318679

@interface NSString (MD5)

//计算NSData 的MD5值
+(NSString*)getMD5WithData:(NSData*)data;

//计算字符串的MD5值，
+(NSString*)getMD5WithString:(NSString*)string;

//计算大文件的MD5值
+(NSString*)getFileMD5WithPath:(NSString*)path;

- (NSString *)sha1;

// 下面两个的区别没有比较过.
- (NSString *)md5;
+ (NSString *)encryptByMd5:(NSString *)str;

@end
