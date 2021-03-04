//          
//  NSString+ZZXString.m
//  Created  on 2020/6/7.
//

#import "NSString+ZZXString.h"
#import <CoreText/CoreText.h>

#import <CommonCrypto/CommonDigest.h>//加密需
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

@implementation NSString (ZZXString)

//判断是否为空字符串
+ (BOOL)zz_checkWithString:(NSString *)str{
    if (str == nil || [str isEqualToString:@""] || str == NULL || [str isKindOfClass:[NSNull class]] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [str isEqual:[NSNull null]] ) {
        return NO;
    }
    return YES;
}

-(BOOL)zz_isConformToTheRules{
    //密码必须8-16位且至少包含大写字母、小写字母、数字和特殊字符中至少3种
    NSString *regex = @"^(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\\W_!@#$%^&*`~()-+=]+$)(?![a-z0-9]+$)(?![a-z\\W_!@#$%^&*`~()-+=]+$)(?![0-9\\W_!@#$%^&*`~()-+=]+$)[a-zA-Z0-9\\W_!@#$%^&*`~()-+=]{8,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/// 判断用户输入的密码是否长度大于8位且同时包含数字和字母
-(BOOL)zz_judgePassWordLegal{
    BOOL result = false;
    if ([self length] >= 8){
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;
}
- (BOOL)zz_checkWithMoney
{
    NSString *regex = @"^(?!0+$)(?!0*\\.0*$)\\d{1,8}(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)zz_checkWithNum{
    NSString *regex = @"^[0-9]{0,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//判断是否为有效手机号
-  (BOOL)zz_checkWithTelephone{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(177))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
- (BOOL)zz_checkWithTelephoneLength{
    bool bflag = false;
    NSString *regex = @"^[A-Za-z0-9_－]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self] != YES) return false;
    if ([self rangeOfString:@"_"].location != NSNotFound) return true;
    if ([self rangeOfString:@"_"].location != NSNotFound) return true;
    
    NSInteger length = self.length;
    for(int i = 0 ; i < length ; i++){
        char num = [self characterAtIndex:i];
        if((num>='a'&&num<='z')||(num>='A'&&num<='Z')){
            bflag = true;
            break;
        }
    }
    if(bflag == true)
        NSLog(@"此字符串含有英文字母");
    else
        NSLog(@"此字符串不含有英文字母");
    
    return bflag;
}

- (BOOL)zz_checkWithEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//身份证号
-  (BOOL)zz_checkWithIdentityCard{

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//判断字符串是否只包含特定字符
- (BOOL)zz_isOnlyhasNumberAndpoint:(NSString *)string{
    
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:string] invertedSet];
    
    NSString *filter=[[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filter];
}

//判断字符串是否包含数字
- (BOOL)zz_isContainNumber{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}

//判断字符串是否是整数或小数
- (BOOL)zz_isNumber{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[+-]?[0-9]+(\\.[0-9]+)?" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}



- (NSString *)zz_getNoWhiteSpaceString{
    NSString *newString = self;
    //    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    //    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newString;
}

-(BOOL)checkRangeOfString:(NSString *)string{
    if([self rangeOfString:string].location !=NSNotFound){
        NSLog(@"包含");
        return YES;
    }else{
        NSLog(@"不包含");
        return NO;
    }
}


//产生随机字符串
+ (NSString *)zz_shuffledAlphabe{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

- (NSString *)zz_md5HexDigest{
    if (self) {
        const char *cStr = [self UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result);// This is the md5 call
        return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
        
    }else{
        return 0;
    }
}

- (NSInteger)zz_chineseLength{
    int asciiCount = 0;
    int nonAsciiCount = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (isascii(c)) {
            asciiCount++;
        } else {
            nonAsciiCount++;
        }
    }
    int count = (asciiCount + 1) / 2 + nonAsciiCount;
    return count;
}


- (NSUInteger) indexOf: (NSString*) substring {
    NSRange range = [self rangeOfString:substring options:NSCaseInsensitiveSearch];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSString*) substringFromIndex:(NSUInteger)from toIndex: (NSUInteger) to {
    NSRange range;
    range.location = from;
    range.length = to - from;
    return [self substringWithRange: range];
}

/** 计算字体大小*/
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW{
    return  [self zzx_sizeWithTextFont:font maxW:maxW andFontName:@"AmericanTypewriter"];
}
- (CGSize)zzx_sizeWithText:(CGFloat )font{
     return [self zzx_sizeWithTextFont:font maxW:MAXFLOAT];
}
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font andFontName:(NSString*)fontName{
    return [self zzx_sizeWithTextFont:font maxW:MAXFLOAT andFontName:fontName];
}
- (CGSize)zzx_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW andFontName:(NSString*)fontName{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont fontWithName:fontName size:font];
    CGSize maxsize = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
}

- (CGSize)zzx_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxsize = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
}

/// 计算textView的高度
- (float)zzx_sizeWithTextView:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:dic
                                           context:nil].size;
    return sizeToFit.height + 16.0;
}


- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    return [self sizeWithConstrainedToSize:CGSizeMake(width, CGFLOAT_MAX) fromFont:font1 lineSpace:lineSpace];
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    CGFloat minimumLineHeight = font1.pointSize,maximumLineHeight = minimumLineHeight, linespace = lineSpace;
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)font1.fontName,font1.pointSize,NULL);
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    //Apply paragraph settings
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,(NSString*)kCTFontAttributeName,(__bridge id)style,(NSString*)kCTParagraphStyleAttributeName,nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    //    [self clearEmoji:string start:0 font:font1];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGSize result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [string length]), NULL, size, NULL);
    CFRelease(framesetter);
    CFRelease(font);
    CFRelease(style);
    string = nil;
    attributes = nil;
    return result;
}

-(NSString *)zz_Localized{
    return NSLocalizedString(self, nil);
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    if(err)
    {
//        NSLog(@"json解析失败：%@",jsonString);
        return nil;
    }
    return dic;
}

/// 隐藏手机号中间4位
+ (NSString*)idCardToAsterisk:(NSString *)aIdCardNum{
    if (aIdCardNum.length < 8)  return aIdCardNum;
    
    return [NSString stringWithFormat:@"%@****%@",[aIdCardNum substringToIndex:3],[aIdCardNum substringFromIndex:aIdCardNum.length-4]];
}

/** json 转字符串 */
+(NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

/// 截取时间前10位
+ (NSString*)substringWithTime:(NSString *)time digit:(NSInteger )digit{
    
    if (time.length > digit) {
        return [time substringToIndex:digit];;
    }else{
        return time;
    }
}
@end
