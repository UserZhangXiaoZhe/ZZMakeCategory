//
//  UIFont+ZZFont.m
//  Created by  on 2018/10/31.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIFont+ZZFont.h"

/** 极细体 */
static NSString *const MHPingFangSC_Ultralight = @"PingFangSC-Ultralight";
/** 常规体*/
static NSString *const MHPingFangSC_Regular = @"PingFangSC-Regular";
/** 中粗体 */
static NSString *const MHPingFangSC_Semibold = @"PingFangSC-Semibold";
/** 纤细体 */
static NSString *const MHPingFangSC_Thin = @"PingFangSC-Thin";
/** 细体 */
static NSString *const MHPingFangSC_Light = @"PingFangSC-Light";
/** 中黑体 */
static NSString *const MHPingFangSC_Medium = @"PingFangSC-Medium";

@implementation UIFont (ZZFont)
+(UIFont *)zzFontOfFifteen{
    return [UIFont fontWithName:@"AmericanTypewriter" size:15];
}

+(UIFont *)zzFontOfSixteen{
    return [UIFont fontWithName:@"AmericanTypewriter" size:16];
}

+(UIFont *)zzFontOfSeventeen{
    return [UIFont fontWithName:@"AmericanTypewriter" size:17];
}

+(UIFont *)zzFontOfEighteen{
    return [UIFont fontWithName:@"AmericanTypewriter" size:18];
}
+(UIFont *)zzFontOfNineteen{
    return [UIFont fontWithName:@"AmericanTypewriter" size:19];
}
+(UIFont *)zzFontOfTwenty{
    return [UIFont fontWithName:@"AmericanTypewriter" size:20];
}

+(UIFont *)zzCreatFont:(CGFloat)font{
    return [UIFont fontWithName:@"AmericanTypewriter" size:font];
}

@end
