//
//  NSString+ZZString.m

//  Created by  on 2018/10/31.
//  Copyright © 2018年 . All rights reserved.
//

#import "NSString+ZZString.h"
#import <CommonCrypto/CommonDigest.h>//加密需要

#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

#import <objc/runtime.h>

@implementation NSString (ZZString)
//判断是否为空字符串 为空返回YES
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
    if(bflag == true){
        NSLog(@"此字符串含有英文字母");
    } else {
        NSLog(@"此字符串不含有英文字母");
    } 
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
-(BOOL)zz_isOnlyhasNumberAndpoint{
    
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:NUMANDD] invertedSet];
    
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
-(NSString *)zz_localized{
    return NSLocalizedString(self, nil);
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

/** 计算字体大小*/
- (CGSize)zz_sizeWithTextFont:(CGFloat )font maxW:(CGFloat)maxW{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont fontWithName:@"AmericanTypewriter" size:font];
    CGSize maxsize = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

/** 计算字体大小和换行*/
- (CGSize)zz_sizeWithText:(CGFloat )font{
     return [self zz_sizeWithTextFont:font maxW:MAXFLOAT];
}

/** 计算当前文件\文件夹的内容大小 */
- (NSInteger)zz_sizeWithFile{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

//获取指定字符长度字符对应的字符串
- (NSString *)zz_chineseSubStringWithMaxCount:(NSUInteger)maxCount
{
    NSUInteger maxCount1 = 2 * maxCount;
    NSUInteger count = 0;
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (isascii(c)) {
            count++;
        } else {
            count += 2;
        }
        if (count == maxCount1) {
            index = i + 1;
            break;
        } else if (count > maxCount1) {
            index = i;
            break;
        }
    }
    if (index == 0) {
        index = self.length;
    }
    NSString *subString = [self substringToIndex:index];
    return subString;
}


- (NSString *)zz_subStringFrom:(NSString *)startString to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}
/*
 常用的正则表达式
 以下红色字符串是常用的正则表达式（以下正则表达式来自百度百科）
 
 1.验证用户名和密码："^[a-zA-Z]\w{5,15}$"
 
 2.验证电话号码：（"^(\\d{3,4}-)\\d{7,8}$"）
 
 eg：021-68686868  0511-6868686；
 
 3.验证手机号码："^1[3|4|5|7|8][0-9]\\d{8}$"；
 
 4.验证身份证号（15位或18位数字）："\\d{14}[[0-9],0-9xX]"；
 
 5.验证Email地址：("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$")；
 
 6.只能输入由数字和26个英文字母组成的字符串：("^[A-Za-z0-9]+$") ;
 
 7.整数或者小数：^[0-9]+([.]{0,1}[0-9]+){0,1}$
 
 8.只能输入数字："^[0-9]*$"。
 
 9.只能输入n位的数字："^\\d{n}$"。
 
 10.只能输入至少n位的数字："^\\d{n,}$"。
 
 11.只能输入m~n位的数字："^\\d{m,n}$"。
 
 12.只能输入零和非零开头的数字："^(0|[1-9][0-9]*)$"。
 
 13.只能输入有两位小数的正实数："^[0-9]+(.[0-9]{2})?$"。
 
 14.只能输入有1~3位小数的正实数："^[0-9]+(\.[0-9]{1,3})?$"。
 
 15.只能输入非零的正整数："^\+?[1-9][0-9]*$"。
 
 16.只能输入非零的负整数："^\-[1-9][]0-9"*$。
 
 17.只能输入长度为3的字符："^.{3}$"。
 
 18.只能输入由26个英文字母组成的字符串："^[A-Za-z]+$"。
 
 19.只能输入由26个大写英文字母组成的字符串："^[A-Z]+$"。
 
 20.只能输入由26个小写英文字母组成的字符串："^[a-z]+$"。
 
 21.验证是否含有^%&',;=?$\"等字符："[^%&',;=?$\x22]+"。
 
 22.只能输入汉字："^[\u4e00-\u9fa5]{0,}$"。
 
 23.验证URL："^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$"。
 
 24.验证一年的12个月："^(0?[1-9]|1[0-2])$"正确格式为："01"～"09"和"10"～"12"。
 
 25.验证一个月的31天："^((0?[1-9])|((1|2)[0-9])|30|31)$"正确格式为；"01"～"09"、"10"～"29"和“30”~“31”。
 
 26.获取日期正则表达式：\\d{4}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?
 
 评注：可用来匹配大多数年月日信息。
 
 27.匹配双字节字符(包括汉字在内)：[^\x00-\xff]
 
 评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
 
 28.匹配空白行的正则表达式：\n\s*\r
 
 评注：可以用来删除空白行
 
 29.匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</>|<.*? />
 
 评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
 
 30.匹配首尾空白字符的正则表达式：^\s*|\s*$
 
 评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 
 31.匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
 
 评注：网上流传的版本功能很有限，上面这个基本可以满足需求
 
 32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 
 评注：表单验证时很实用
 
 33.匹配腾讯QQ号：[1-9][0-9]\{4,\}
 
 评注：腾讯QQ号从10 000 开始
 
 34.匹配中国邮政编码：[1-9]\\d{5}(?!\d)
 
 评注：中国邮政编码为6位数字
 
 35.匹配ip地址：((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。
 */
//ip的正则表达式
-(NSString *)zz_getIPWithString{
    //^((http://)|(https://))? 看情况加
    //((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)
    NSString *regular = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular    options:NSRegularExpressionCaseInsensitive error:&error];
    //第一个的结果
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    //所有的结果
    NSArray * matches = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult * test in matches) {
        NSString *tagValuestr = [self substringWithRange:test.range];
        NSLog(@"ip匹配：%@", tagValuestr);
    }
    
    if (result) {
        return [self substringWithRange:result.range];
    }else{
        return nil;
    }
}

// 域名转换IP
- (NSString *)zz_queryIpWithDomain:(NSString *)domain{
    struct hostent *hs;
    struct sockaddr_in server;
    if ((hs = gethostbyname([domain UTF8String])) != NULL) {
        server.sin_addr = *((struct in_addr*)hs->h_addr_list[0]);
        return [NSString stringWithUTF8String:inet_ntoa(server.sin_addr)];
    }
    return nil;
}
    
-(NSString *)zz_getDomainWithString{
    
    //域名的正则表达式
    //iOS中书写正则表达式，碰到转义字符，多加一个“\”,例如：
    //全数字字符：@"^\\d+$"
    
    //^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$
    //^((http://)|(https://))?([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}(/)
    
    //^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$
    
    NSString *regular = @"^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$";
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    //第一个的结果
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    //所有的结果
    NSArray * matches = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult * test in matches) {
        NSString *tagValuestr = [self substringWithRange:test.range];
        NSLog(@"域名匹配：%@", tagValuestr);
    }
    
    if (result) {
        return [self substringWithRange:result.range];
    }else{
        return nil;
    }
}


-(NSString *)zz_subHandleWithString:(NSString *)string{
    
    NSUInteger startLoc = 0;//起始下标
    NSUInteger endLoc = string.length;//结束下标
    NSUInteger pointLoc = 0;//初始化，起始下标向后第一个"."的下标
    NSUInteger numLoc = 0;//初始化，"."向前不是数字的下标
    NSUInteger slashLoc = 0;//初始化，"."向后第一个"/"的下标
    
    //判断有无"."，没有则不是handle码返回nil
    if(![string containsString:@"."]) return nil;
    
    //一个一个判断是否是"."，记住第一个"."的下标
    for (NSUInteger i = 0; i < endLoc - startLoc; i ++) {
        
        NSRange pointRange = NSMakeRange( startLoc + i, 1);
        NSString *pointStr=[string substringWithRange:pointRange];
        //MyLog(@"起始下标开始截取:%@",pointStr);
        
        //记住第一个"."的下标
        if ([pointStr isEqualToString:@"."]) {
            pointLoc = startLoc + i;
            
            //在第一个“.”处向前截取，碰到不是数字记住下标点
            for (NSUInteger i = pointLoc; i >= startLoc; i--) {
                if (i == 0) break;
                NSRange numRange = NSMakeRange( i - 1, 1);
                NSString *numStr=[string substringWithRange:numRange];
                //MyLog(@"pointLoc向前截取数字:%@",numStr);
                
                if (![numStr zz_checkWithNum]) {
                    numLoc =  i;
                    //如果 pointLoc-numLoc < 1 ,不是handle码返回nil
                    if (pointLoc - numLoc < 1 ) return nil;
                    NSRange beforRange = NSMakeRange(numLoc, pointLoc - numLoc);
                    NSString *beforStr=[string substringWithRange:beforRange];
                    NSLog(@"pointLoc向前截取数字:%@",beforStr);
                    break;
                }
            }
            
            //判断从“.”处到最后，有无"/"，没有则不是handle码返回nil
            NSString *waitStr1=[string substringFromIndex:pointLoc];
            if(![waitStr1 containsString:@"/"]) return nil;
            
            //在第一个“.”处向后截取，碰到第一个“/”记住下标点
            for (NSUInteger i = 1; i < endLoc - pointLoc; i ++) {
                NSRange slashRange = NSMakeRange( pointLoc + i, 1);
                NSString *slashStr=[string substringWithRange:slashRange];
                //MyLog(@"pointLoc向后截取:%@",slashStr);
                
                //记住第一个"/"的下标
                if ([slashStr isEqualToString:@"/"]) {
                    slashLoc = pointLoc + i;
                    
                    //判断"."到"/"之间是否只是"."和数字
                    NSRange lastRange = NSMakeRange( pointLoc, slashLoc - pointLoc + 1);
                    NSString *lastStr=[string substringWithRange:lastRange];
                    NSLog(@".到/之间:%@",lastStr);
                    
                    NSRange depRange = NSMakeRange( pointLoc, slashLoc - pointLoc);
                    NSString *depStr=[string substringWithRange:depRange];
                    
                    if ([depStr zz_isOnlyhasNumberAndpoint] && ![lastStr containsString:@".."] && ![lastStr containsString:@"./"] && ![lastStr containsString:@"//"]) {
                        return [string substringFromIndex:numLoc];
                    }
                    break;
                }
            }
            break;
        }
    }
    return nil;
}

//       {***} . {***} / {******}
-(NSString *)zz_subHandleWithRegular{
    
    if ([self rangeOfString:@"http" options:NSCaseInsensitiveSearch].location == NSNotFound && [self rangeOfString:@"https" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        //不含http或https
        NSString *ipAddress = [self zz_getIPWithString];
        NSString *domin = [self zz_getDomainWithString];
        
        if (domin) {
            //包含域名
            NSRange startRange = [self rangeOfString:domin];
            //截取从起始下标到最后
            NSUInteger startLoc = startRange.location + startRange.length;//起始下标
            NSRange lastRange = NSMakeRange( startLoc, self.length - startLoc);
            NSString *lastStr=[self substringWithRange:lastRange];
            
            return [self zz_subHandleWithString:lastStr];
            
        }else if (ipAddress){
            //包含IP
            NSRange startRange = [self rangeOfString:ipAddress];
            
            //从ip开始到最后截取
            NSUInteger startLoc1 = startRange.location;//起始下标
            NSRange lastRange1 = NSMakeRange( startLoc1, self.length - startLoc1);
            NSString *lastStr1 = [self substringWithRange:lastRange1];
            NSString *handleStr1 = [self zz_subHandleWithString:lastStr1];
            
            //从IP末尾到最后截取
            NSUInteger startLoc = startRange.location + startRange.length;//起始下标
            NSRange lastRange = NSMakeRange( startLoc, self.length - startLoc);
            NSString *lastStr=[self substringWithRange:lastRange];
            NSString *handleStr = [self zz_subHandleWithString:lastStr];
            
            if (handleStr1) {
                return handleStr1;
            }else if (handleStr) {
                return handleStr;
            }else{
                return nil;
            }
            
        }else{
            //不含域名或ip，直接检验是否是handle码
            return [self zz_subHandleWithString:self];
        }
        
    }else{
        NSString *ipAddress = [self zz_getIPWithString];
        NSString *domin = [self zz_getDomainWithString];
        
        if (domin) {
            //包含域名
            NSRange startRange = [self rangeOfString:domin];
            //截取从起始下标到最后
            NSUInteger startLoc = startRange.location + startRange.length;//起始下标
            NSRange lastRange = NSMakeRange( startLoc, self.length - startLoc);
            NSString *lastStr=[self substringWithRange:lastRange];
            
            return [self zz_subHandleWithString:lastStr];
            
        }else if (ipAddress){
            //包含IP
            NSRange startRange = [self rangeOfString:ipAddress];
            //从IP末尾到最后截取
            NSUInteger startLoc = startRange.location + startRange.length;//起始下标
            NSRange lastRange = NSMakeRange( startLoc, self.length - startLoc);
            NSString *lastStr=[self substringWithRange:lastRange];
            NSString *handleStr = [self zz_subHandleWithString:lastStr];
            
            //从ip开始到最后截取
            NSUInteger startLoc1 = startRange.location;//起始下标
            NSRange lastRange1 = NSMakeRange( startLoc1, self.length - startLoc1);
            NSString *lastStr1 = [self substringWithRange:lastRange1];
            NSString *handleStr1 = [self zz_subHandleWithString:lastStr1];
            if (handleStr) {
                return handleStr;
            }else if (handleStr1){
                return handleStr1;
            }else{
                return nil;
            }
            
        }else{
            //不含域名或ip，直接检验是否是handle码
            return [self zz_subHandleWithString:self];
        }
    }
    
    
}


@end
