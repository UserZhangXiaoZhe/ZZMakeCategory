//
//  UIColor+ZZColor.h

//  Created by  on 2018/10/25.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZZColor)

/** 主色调 */
+(UIColor *)zzMianColor;
/** view背景色 */
+(UIColor *)zzViewBgColor;
/** 红色调 */
+(UIColor *)zzRedColor;
/** 白烟色调 */
+(UIColor *)zzWhiteSmokeColor;
/** 亮灰色色调 */
+(UIColor *)zzGainsboroColor;
/** 浅黄色色调 */
+(UIColor *)zzLightYellowColor;
/** 薄雾玫瑰色调 */
+(UIColor *)zzMistyRoseColor;
/** 分割线颜色 */
+(UIColor *)zzLineColor;

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
+ (UIColor *)zz_colorWithHexString:(NSString *)hexString;
+ (instancetype)rgba:(NSUInteger)rgba;
+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;

@end

NS_ASSUME_NONNULL_END
