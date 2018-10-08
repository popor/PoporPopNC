//
//  NSString+Tool.h
//  Wanzi
//
//  Created by popor on 2016/12/28.
//  Copyright © 2016年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrefixOs.h"

@interface NSString (Tool)

#pragma mark - 判断空字符串
+ (BOOL)isNullToString:(NSString*)string;

#pragma mark - 正则部分
+ (NSString *)replaceString:(NSString *)theOriginString withREG:(NSString *)theRegString withNewString:(NSString *)theNewString;
+ (NSString *)cleanString:(NSString *)theOriginString withREG:(NSString *)theRegString;
+ (NSString *)stringWithReg:(NSString *)theOriginString withREG:(NSString *)theRegString;

- (NSString *)replaceWithREG:(NSString *)reg newString:(NSString *)theNewString;
- (NSString *)cleanWithREG:(NSString *)reg;
- (NSString *)stringWithREG:(NSString *)reg;

#pragma mark - 10-16转换
+ (NSString *)stringToHexWithInt:(int)theNumber;
+ (NSString *)stringToDecimalWithString:(NSString *)theNumber;

- (NSDictionary *)toDic;

#pragma mark [获取 一个GUID]
+ (NSString *)getUUID;

#pragma mark 空格URL
- (NSString *)toUrlEncode;

- (NSString *)toUtf8Encode;

- (NSString *)toHumanizePhoneString;
- (BOOL)isPhoneNum;

- (NSData *)toData;

- (NSInteger)countOccurencesOfString:(NSString*)searchString;

- (COLOR_CLASS *)toColor;

@end
