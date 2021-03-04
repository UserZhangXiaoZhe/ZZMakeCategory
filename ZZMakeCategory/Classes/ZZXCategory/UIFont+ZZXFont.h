//          
//  UIFont+ZZXFont.h
//  Created  on 2020/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZZXFont)

+(UIFont *)zzxFontFifteen;
+(UIFont *)zzxFontSixteen;
+(UIFont *)zzxFontSeventeen;
+(UIFont *)zzxFontEighteen;
+(UIFont *)zzxFontNineteen;
+(UIFont *)zzxFontTwenty;

/// tabbar默认字体
+(UIFont *)zzxFontTabbarNor;
/// tabbar选中字体
+(UIFont *)zzxFontTabbarSel;

/// 苹方-简 细体
+(UIFont *)zzxFontPingFangLight:(CGFloat)font;
/// 苹方-简 中黑体
+(UIFont *)zzxFontPingFangMedium:(CGFloat)font;
/// 苹方-常规体
+(UIFont *)zzxFontPingFangRegular:(CGFloat)font;
/// 苹方-简 中粗体
+(UIFont *)zzxFontPingFangSemibold:(CGFloat)font;
/// 苹方-简 纤细体
+(UIFont *)zzxFontPingFangThin:(CGFloat)font;
/// 苹方-简 极细体
+(UIFont *)zzxFontPingFangUltralight:(CGFloat)font;

/// DINPro字体 常规
+(UIFont *)zzxFontDINProRegular:(CGFloat)font;
/// DINPro字体 中粗体
+(UIFont *)zzxFontDINProMedium:(CGFloat)font;
/// DINPro字体 粗体
+(UIFont *)zzxFontDINProBold:(CGFloat)font;

/// Barlow字体 常规
+(UIFont *)zzxFontBarlowRegular:(CGFloat)font;
/// Barlow字体 中粗体
+(UIFont *)zzxFontBarlowMedium:(CGFloat)font;
/// Barlow字体 粗体
+(UIFont *)zzxFontBarlowBold:(CGFloat)font;

/// Manrope字体 常规
+(UIFont *)zzxFontManropeRegular:(CGFloat)font;
/// Manrope字体 中粗体
+(UIFont *)zzxFontManropeMedium:(CGFloat)font;
/// Manrope字体 粗体
+(UIFont *)zzxFontManropeBold:(CGFloat)font;


///获取字体名称
+(NSString *)getFontNameWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

/*
 NSString *name = [UIFont getFontNameWithName:@"DINPro-Medium.ttf"];
 */
