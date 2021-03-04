//          
//  NSString+ZZXString.h
//  Created  on 2020/6/7.
//

#import <Foundation/Foundation.h>

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



@interface NSString (ZZXString)
/** 检查字符串 */
+ (BOOL)zz_checkWithString:(NSString *)str;

/**密码是否符合规则*/
- (BOOL)zz_isConformToTheRules;

/// 判断用户输入的密码是否长度大于8位且同时包含数字和字母
-(BOOL)zz_judgePassWordLegal;

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
- (BOOL)zz_isNumber;

/** 判断字符串是否只包含特定字符 */
- (BOOL)zz_isOnlyhasNumberAndpoint:(NSString *)string;
/// 是否包含
-(BOOL)checkRangeOfString:(NSString *)string;
/** 无空格和换行的字符串 */
- (NSString *)zz_getNoWhiteSpaceString;

/** 产生随机字符串 */
+ (NSString *)zz_shuffledAlphabe;

/**MD5加密*/
- (NSString *)zz_md5HexDigest;

/** 获取NSString对应的中文长度 */
- (NSInteger)zz_chineseLength;

/// 字符串起始位置
- (NSUInteger)indexOf:(NSString*)substring;
/// 截取 from - to 之间的字符串
- (NSString*) substringFromIndex:(NSUInteger)from toIndex: (NSUInteger) to;

/** 计算字体大小*/
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW;
- (CGSize)zzx_sizeWithText:(CGFloat )font;
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font andFontName:(NSString*)fontName;
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW andFontName:(NSString*)fontName;

- (CGSize)zzx_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/// 计算textView的高度
- (float)zzx_sizeWithTextView:(NSString *)value andWidth:(float)width;

/// Constrained 限制
- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
/// 国际化
- (NSString *)zz_Localized;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/// 隐藏手机号中间4位
+ (NSString*)idCardToAsterisk:(NSString *)aIdCardNum;

/** json 转字符串 */
+(NSString *)convertToJsonData:(NSDictionary *)dict;

/// 截取时间前N位
+ (NSString*)substringWithTime:(NSString *)time digit:(NSInteger )digit;
@end

NS_ASSUME_NONNULL_END
