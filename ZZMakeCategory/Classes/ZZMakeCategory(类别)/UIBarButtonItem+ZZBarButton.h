//
//  UIBarButtonItem+ZZBarButton.h

//  Created by UserBaiZi on 2019/11/29.
//  Copyright © 2019 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (ZZBarButton)
/**  快速创建自定义 图片 UIBarButtonItem */
+ (instancetype)zz_barButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName  target:(id)target sel:(SEL)sel;

/** 快速创建自定义 文字 UIBarButtonItem */
+ (instancetype)zz_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style  target:(id)target sel:(SEL)sel;

/** 快速创建自定义 文字+图片 (上下) */
+ (instancetype)zz_barButtonItemWithImageName:(NSString *)imageName  highlightedImageName:(NSString *)highlightedImageName Title:(NSString *)title  titleColor:(UIColor *)titleColor target:(id)target sel:(SEL)sel;

/** 快速创建自定义 文字+图片 (左右) */
+ (instancetype)zz_barButtonItemLeftAndRightWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName title:(NSString *)title  titleColor:(UIColor *)titleColor target:(id)target sel:(SEL)sel;
@end

NS_ASSUME_NONNULL_END
