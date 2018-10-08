//
//  NSString+IDCard.m
//  linRunShengPi
//
//  Created by popor on 2018/1/5.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "NSString+IDCard.h"

#define IDCardNoCheckOriginArray @[@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2"]
#define IDCardNoCheckResultArray @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"]

@implementation NSString (IDCard)

- (BOOL)isChinaIdCardNoLength {
    if (self.length == 15 || self.length == 18) {
        return YES;
    }else{
        return NO;
    }
}

/*
 身份证第18位（校验码）的计算方法
 　　1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。
 　　2、将这17位数字和系数相乘的结果相加。
 　　3、用加出来和除以11，看余数是多少？
 　　4、余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。其分别对应的最后一位身份证的号码为1－0－X－9－8－7－6－5－4－3－2。
 　　5、通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2。
 　　例如：某男性的身份证号码是34052419800101001X。我们要看看这个身份证是不是合法的身份证。
 　　首先我们得出前17位的乘积和是189，然后用189除以11得出的结果是17+2/11，也就是说其余数是2。最后通过对应规则就可以知道余数2对应的数字是x。所以，可以判定这是一个合格的身份证号码。
 //*/

- (BOOL)isChinaIdCardNo {
    
    if (self.length == 18) {
        NSString * checkString = [NSString getUserCardNoLastCode:self];
        NSLog(@"身份证验证码为: %@", checkString);
        if ([checkString isEqualToString:[[self substringFromIndex:17] uppercaseString]]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

//获取身份证最后一位验证码,超过17未即可.
+ (NSString *)getUserCardNoLastCode:(NSString *)cardNo
{
    if (cardNo.length >= 17) {
        NSMutableArray * cardNumArray = [[NSMutableArray alloc] init];
        [cardNo enumerateSubstringsInRange:NSMakeRange(0, cardNo.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            [cardNumArray addObject:substring];
        }];
        int multiplicationSum = 0;
        for (int i = 0; i< IDCardNoCheckOriginArray.count; i++) {
            int idCardNum = [cardNumArray[i] intValue];
            int checkNum  = [IDCardNoCheckOriginArray[i] intValue];
            multiplicationSum = multiplicationSum + idCardNum * checkNum;
        }
        return IDCardNoCheckResultArray[multiplicationSum%11];
    }else{
        return @"";
    }
}

@end
