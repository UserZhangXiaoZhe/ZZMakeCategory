//
//  UIColor+ZZColor.m

//  Created by  on 2018/10/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIColor+ZZColor.h"

@implementation UIColor (ZZColor)
+(UIColor *)zzMianColor{
    return [self zz_colorWithHexString:@"#CD853F"];
}
+(UIColor *)zzViewBgColor{
    return [self zz_colorWithHexString:@"#F7EED6"];
}


+(UIColor *)zzRedColor{
    return [self zz_colorWithHexString:@"#FF0000"];
}
+(UIColor *)zzWhiteSmokeColor{
    return [self zz_colorWithHexString:@"#F5F5F5"];
}
+(UIColor *)zzGainsboroColor{
    return [self zz_colorWithHexString:@"#DCDCDC"];
}

+(UIColor *)zzLightYellowColor{
    return [self zz_colorWithHexString:@"#FFFFE0"];
}
+(UIColor *)zzMistyRoseColor{
    return [self zz_colorWithHexString:@"#FFE4E1"];
}

+(UIColor *)zzLineColor{
    return [self zz_colorWithHexString:@"#D9D8D9"];
}

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
