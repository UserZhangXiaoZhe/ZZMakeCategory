//          
//  UIColor+ZZXColor.m
//  Created  on 2020/6/8.
//

#import "UIColor+ZZXColor.h"

@implementation UIColor (ZZXColor)

+(UIColor *)zzxMianColor{
    return [self zz_colorWithHexString:@"#FF5461"];
}
+(UIColor *)zzxMianBgColor{
    return [self zz_colorWithHexString:@"#F7F8F9"];
}
+(UIColor *)zzxMianBlackColor{
    return [self zz_colorWithHexString:@"#222327"];
}
+(UIColor *)zzxMianGrayColor{
    return [self zz_colorWithHexString:@"#7D7E86"];
}
+(UIColor *)zzxMianGreenColor{
    return [self zz_colorWithHexString:@"#22B879"];
}

+(UIColor *)zzxTabbarNorColor{
    return [self zz_colorWithHexString:@"#7D7E86"];
}
+(UIColor *)zzxTabbarSelColor{
    return [self zz_colorWithHexString:@"#FF5461"];
}

/** 十六进制转换成颜色,如果是8位十六进制，最后2位是透明度
<!--透明度百分比 : 8位颜色值后两位-->
    <!--100% : FF-->
    <!--95% : F2-->
    <!--90% : E6-->
    <!--85% : D9-->
    <!--80% : CC-->
    <!--75% : BF-->
    <!--70% : B3-->
    <!--65% : A6-->
    <!--60% : 99-->
    <!--55% : 8C-->
    <!--50% : 80-->
    <!--45% : 73-->
    <!--40% : 66-->
    <!--35% : 59-->
    <!--30% : 4D-->
    <!--25% : 40-->
    <!--20% : 33-->
    <!--15% : 26-->
    <!--10% : 1A-->
    <!--5% : 0D-->
    <!--0% : 00-->
*/
+ (UIColor *)zz_colorWithHexString:(NSString *)hexString {
    if (!hexString)
        return nil;
    
    NSString* hex = [NSString stringWithString:hexString];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];
    
    if (hex.length == 6)
        hex = [hex stringByAppendingString:@"FF"];
    else if (hex.length != 8)
        return nil;
    
    uint32_t rgba;
    NSScanner* scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&rgba];
    return [UIColor rgba:rgba];
}

+ (instancetype)rgba:(NSUInteger)rgba {
    return [self r:(rgba >> 24)&0xFF g:(rgba >> 16)&0xFF b:(rgba >> 8)&0xFF a:rgba&0xFF];
}
+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a {
    return [self colorWithRed:r / 255. green:g / 255. blue:b / 255. alpha:a / 255.];
}


@end
