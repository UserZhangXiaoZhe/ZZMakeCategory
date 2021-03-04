//          
//  UIImage+ZZXImage.h
//  Created  on 2020/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZZXImage)

+ (UIImage *)imageNameInTabBar:(NSString *)imageName; 
+ (UIImage *)imageNameInHomeIcon:(NSString *)imageName;
+ (UIImage *)imageNameInMeIcon:(NSString *)imageName;
+ (UIImage *)imageNameInOtherIcon:(NSString *)imageName; 
/**将UIColor转图片*/
+(UIImage*)imageWithColor:(UIColor*)color;
/**将十六进制转图片*/
+(UIImage*)imageWithString:(NSString *)colorStr;

/// 按大小将UIColor转图片
+(UIImage*)zzx_imageWithColor:(UIColor*)color size:(CGSize)size;
/// 按大小将十六进制转图片
+(UIImage*)zzx_imageWithColorString:(NSString *)colorStr size:(CGSize)size;
/// 获取一张带圆角的图片
+ (UIImage *)zzx_imageWithName:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;
/// 按大小获取一张带圆角的图片
+ (UIImage *)zzx_imageWithColorString:(NSString *)colorStr size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/// 圆形图片
- (UIImage *)circleImage;
/// 获取带logo的二维码图片
+(UIImage*)createQrCodeImageWithString:(NSString *)url codeSize:(CGFloat)codeSize logoName:(NSString *)logoName  radius: (CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/// 通过字符串 生成一张二维码图片
+(UIImage *)createQRCodeImageWithString:(NSString *)urlStr codeSize:(CGFloat)codeSize;

/**图片缩放 按比例*/
-(UIImage *)zz_scaleImageToScale:(float)scaleSize;
/**图片缩放 按宽高*/
-(UIImage *)zz_scaleImageToWidth:(float)width toHeight:(float)height;
/**图片缩放 按大小 单位:mb*/
-(NSData *)zz_compressImageToKBytes:(CGFloat)kByte;

/// 获取屏幕截屏
+ (NSData *)getImageDataScreenShot;

@end

NS_ASSUME_NONNULL_END
