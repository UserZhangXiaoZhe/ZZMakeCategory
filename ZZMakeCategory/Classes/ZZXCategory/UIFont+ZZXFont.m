//          
//  UIFont+ZZXFont.m
//  Created  on 2020/6/18.
//

#import "UIFont+ZZXFont.h"
#import <CoreText/CoreText.h>

@implementation UIFont (ZZXFont)

+(UIFont *)zzxFontFifteen{
    return [UIFont zzxFontPingFangRegular:15];
}

+(UIFont *)zzxFontSixteen{
    return [UIFont zzxFontPingFangRegular:16];
}

+(UIFont *)zzxFontSeventeen{
    return [UIFont zzxFontPingFangRegular:17];
}

+(UIFont *)zzxFontEighteen{
    return [UIFont zzxFontPingFangRegular:18];
}
+(UIFont *)zzxFontNineteen{
    return [UIFont zzxFontPingFangRegular:19];
}
+(UIFont *)zzxFontTwenty{
    return [UIFont zzxFontPingFangRegular:20];
}

+(UIFont *)zzxFontTabbarNor{
    return [UIFont zzxFontPingFangRegular:10];
}
+(UIFont *)zzxFontTabbarSel{
    return [UIFont zzxFontPingFangRegular:10];
}

/// 苹方-简 细体
+(UIFont *)zzxFontPingFangLight:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Light" size:font];
}
/// 苹方-简 中黑体
+(UIFont *)zzxFontPingFangMedium:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:font];
}
/// 苹方-常规体
+(UIFont *)zzxFontPingFangRegular:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:font];
}
/// 苹方-简 中粗体
+(UIFont *)zzxFontPingFangSemibold:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:font];
}
/// 苹方-简 纤细体
+(UIFont *)zzxFontPingFangThin:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Thin" size:font];
}
/// 苹方-简 极细体
+(UIFont *)zzxFontPingFangUltralight:(CGFloat)font{
    return [UIFont fontWithName:@"PingFangSC-Ultralight" size:font];
}

/// DINPro字体 常规
+(UIFont *)zzxFontDINProRegular:(CGFloat)font{
    return [UIFont fontWithName:@"DINPro" size:font];
}
/// DINPro字体 中粗体
+(UIFont *)zzxFontDINProMedium:(CGFloat)font{
    return [UIFont fontWithName:@"DINPro-Medium" size:font];
}
/// DINPro字体 粗体
+(UIFont *)zzxFontDINProBold:(CGFloat)font{
    return [UIFont fontWithName:@"DINPro-Bold" size:font];
}

/// Barlow字体 常规
+(UIFont *)zzxFontBarlowRegular:(CGFloat)font{
    return [UIFont fontWithName:@"Barlow-Regular" size:font];
}
/// Barlow字体 中粗体
+(UIFont *)zzxFontBarlowMedium:(CGFloat)font{
    return [UIFont fontWithName:@"Barlow-Medium" size:font];
}
/// Barlow字体 粗体
+(UIFont *)zzxFontBarlowBold:(CGFloat)font{
    return [UIFont fontWithName:@"Barlow-Bold" size:font];
}
/// Manrope字体 常规
+(UIFont *)zzxFontManropeRegular:(CGFloat)font{
    return [UIFont fontWithName:@"Manrope-Regular" size:font];
}
/// Manrope字体 中粗体
+(UIFont *)zzxFontManropeMedium:(CGFloat)font{
    return [UIFont fontWithName:@"Manrope-Medium" size:font];
}
/// Manrope字体 粗体
+(UIFont *)zzxFontManropeBold:(CGFloat)font{
    return [UIFont fontWithName:@"Manrope-Bold" size:font];
}

///获取字体名称
+(NSString *)getFontNameWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    
    return fontName;
}

@end
