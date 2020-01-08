//
//  NSString+ZZString.h

//  Created by  on 2018/10/31.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define NUMBERS @"0123456789.-"
//数字
#define NUM @"0123456789"
//字母
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//数字和字母
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//数字和点
#define NUMANDD @".0123456789"


@interface NSString (ZZString)

/** 检查字符串 为空返回YES */
+ (BOOL)zz_checkWithString:(NSString *)str;

/**密码是否符合规则*/
- (BOOL)zz_isConformToTheRules;

/**是否为纯数字*/
- (BOOL)zz_checkWithNum;

/**是否为有效手机号*/
- (BOOL)zz_checkWithTelephone;

/**是否为电话的长度*/
- (BOOL)zz_checkWithTelephoneLength;

/**是否为有效邮箱*/
- (BOOL)zz_checkWithEmail;

/**是否为有效身份证*/
- (BOOL)zz_checkWithIdentityCard;

/**是否为Money*/
- (BOOL)zz_checkWithMoney;

/** 判断字符串是否包含数字 */
- (BOOL)zz_isContainNumber;

/** 判断字符串是否只包含特定字符 */
- (BOOL)zz_isOnlyhasNumberAndpoint;

/** 无空格和换行的字符串 */
- (NSString *)zz_getNoWhiteSpaceString;

/** 产生随机字符串 */
+ (NSString *)zz_shuffledAlphabe;

/**MD5加密*/
- (NSString *)zz_md5HexDigest;

-(NSString *)zz_localized;

/** 获取NSString对应的中文长度 */
- (NSInteger)zz_chineseLength;

/**
 计算字体大小 字体大小  最大宽度
 */
- (CGSize)zz_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW;

/** 计算字体大小和换行*/
- (CGSize)zz_sizeWithText:(CGFloat )font;

/** 计算当前文件\文件夹的内容大小 */
- (NSInteger)zz_sizeWithFile;

/* 域名转换IP */
- (NSString *)zz_queryIpWithDomain:(NSString *)domain;

/** 利用ip的正则表达式，获取字符串中的ip */
-(NSString *)zz_getIPWithString;

/** 利用域名的正则表达式，获取字符串中的域名 */
-(NSString *)zz_getDomainWithString;

/** 获取指定字符中文长度对应的字符串  */
- (NSString *)zz_chineseSubStringWithMaxCount:(NSUInteger)maxCount;

/**
 截取指定字符之间的字符串
 @param startString 开始字符
 @param endString 结束字符
 @return 字符串
 */
-(NSString *)zz_subStringFrom:(NSString *)startString to:(NSString *)endString;

/**
 截取Handle码
 1.先判断域名/ip，
 2.再判断是否有“.”，没有返回nil
 3.再第一个“.”向前截取数字，没有返回nil，碰到不是数字记住下标点，
 4.再第一个“.”向后截取到有“/”处，没有返回nil，中间只能是数字或“.”
 5.截取下标点到结束作为整个Handle码
 
 @return Handle码
 */
-(NSString *)zz_subHandleWithRegular;

@end

NS_ASSUME_NONNULL_END
