//
//  UIImage+ZZimage.h

//
//  Created by  on 2018/10/25.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZZimage)
/**将UIColor转图片*/
+(UIImage*)zz_createImageWithColor:(UIColor*)color;

/**图片缩放 按比例*/
-(UIImage *)zz_scaleImageToScale:(float)scaleSize;

/**图片缩放 按宽高*/
-(UIImage *)zz_scaleImageToWidth:(float)width toHeight:(float)height;

/**图片缩放 按大小*/
-(NSData *)zz_compressImageToKBytes:(CGFloat)kByte;

/**
 *返回中心拉伸的图片
 */
+(UIImage *)zz_stretchedImageWithName:(NSString *)name;

/**
 图片合成文字
 @param text            文字
 @param fontSize        字体大小
 @param textColor       字体颜色
 @param textFrame       字体位置
 @param image           原始图片
 @param viewFrame       图片所在View的位置
 @return UIImage *
 */
+ (UIImage *)zz_createImageWithText:(NSString *)text
                  textFont:(NSInteger)fontSize
                 textColor:(UIColor *)textColor
                 textFrame:(CGRect)textFrame
               originImage:(UIImage *)image
    imageLocationViewFrame:(CGRect)viewFrame;

@end

NS_ASSUME_NONNULL_END
