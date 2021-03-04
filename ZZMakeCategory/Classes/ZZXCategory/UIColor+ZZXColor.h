//          
//  UIColor+ZZXColor.h
//  Created  on 2020/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZZXColor)

/// 主色调
+(UIColor *)zzxMianColor;
/// 主背景色调
+(UIColor *)zzxMianBgColor;
/// 主黑色
+(UIColor *)zzxMianBlackColor;
/// 主灰色 
+(UIColor *)zzxMianGrayColor;
/// 主绿色
+(UIColor *)zzxMianGreenColor;
/// tabbar默认颜色
+(UIColor *)zzxTabbarNorColor;
/// tabbar选中颜色
+(UIColor *)zzxTabbarSelColor;
/// 十六进制颜色
+ (UIColor *)zz_colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
