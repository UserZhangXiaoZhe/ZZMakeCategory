//          
//  UIImage+ZZXImage.m
//  Created  on 2020/6/17.
//

#import "UIImage+ZZXImage.h"
#import "NSBundle+ZZXBundle.h"
#import "UIColor+ZZXColor.h"

@implementation UIImage (ZZXImage)

+ (UIImage *)imageNameInTabBar:(NSString *)imageName{
    
    NSString *realName = [NSString stringWithFormat:@"%@@2x",imageName];
    NSString *path = [[NSBundle zzxTabBarIconBundle] pathForResource:realName ofType:@"png"];
    UIImage *loadingImage = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return loadingImage;
}
 

+ (UIImage *)imageNameInHomeIcon:(NSString *)imageName{
    NSString *realName = [NSString stringWithFormat:@"%@@2x",imageName];
    NSString *path = [[NSBundle zzxHomeIconBundle] pathForResource:realName ofType:@"png"];
    UIImage *loadingImage = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return loadingImage;
}

+ (UIImage *)imageNameInMeIcon:(NSString *)imageName{
    NSString *realName = [NSString stringWithFormat:@"%@@2x",imageName];
    NSString *path = [[NSBundle zzxMeIconBundle] pathForResource:realName ofType:@"png"];
    UIImage *loadingImage = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return loadingImage;
}
+ (UIImage *)imageNameInOtherIcon:(NSString *)imageName{
    NSString *realName = [NSString stringWithFormat:@"%@@2x",imageName];
    NSString *path = [[NSBundle zzxOtherIconBundle] pathForResource:realName ofType:@"png"];
    UIImage *loadingImage = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return loadingImage;
}

+(UIImage*)imageWithColor:(UIColor*)color{ 
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage*)imageWithString:(NSString *)colorStr{
    
    UIColor *color = [UIColor zz_colorWithHexString:colorStr];
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/// 按大小将UIColor转图片
+(UIImage*)zzx_imageWithColor:(UIColor*)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/// 按大小将十六进制转图片
+(UIImage*)zzx_imageWithColorString:(NSString *)colorStr size:(CGSize)size{
    
    UIColor *color = [UIColor zz_colorWithHexString:colorStr];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/// 获取一张带圆角的图片
+ (UIImage *)zzx_imageWithName:(UIImage *)image cornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContext(image.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/// 按大小获取一张带圆角的图片
+ (UIImage *)zzx_imageWithColorString:(NSString *)colorStr size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    
    UIImage *image = [self zzx_imageWithColorString:colorStr size:size];
    UIImage *newImage = [self zzx_imageWithName:image cornerRadius:cornerRadius];
    return newImage;
}
/// 圆形图片
- (UIImage *)circleImage{
    
    // 开始图形上下文，NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *)creatWatermarkImage{
    
    
    
    return nil;
}

/// 获取带logo的二维码图片
+(UIImage*)createQrCodeImageWithString:(NSString *)urlStr codeSize:(CGFloat)codeSize logoName:(NSString *)logoName  radius: (CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    UIImage *orginQRImage =[self createQRCodeImageWithString:urlStr codeSize:codeSize];
    
    if (!logoName || [logoName isEqualToString:@""]) {
        return  orginQRImage;
    }
    UIImage *finalImage ;
    
    //根据二维码图片设置 获取 水印图片rect
    CGRect waterImageRect = [self getWaterImageRectWithImage:orginQRImage];
    
    UIImage *logoImage =[[UIImage imageNamed:logoName] scaleToSize:waterImageRect.size];
    //生成水印图片 rect 从00 开始
    UIImage *waterImage =[UIImage clipImageRadiousWithImage:logoImage circleRect:CGRectMake(0, 0, waterImageRect.size.width, waterImageRect.size.height) radious:radius borderWith:borderWidth borderColor:borderColor];
    //添加水印图片
    finalImage =[UIImage createWaterImageWithImage:orginQRImage waterImage:waterImage waterImageRect:waterImageRect];
    return finalImage;
}
/// 通过字符串 生成一张二维码图片
+(UIImage *)createQRCodeImageWithString:(NSString *)urlStr codeSize:(CGFloat)codeSize{
    
    if (urlStr ==nil || [urlStr isEqualToString:@""]) return  nil;
    //限制大小
    codeSize = [self limitCodeSize:codeSize];
    CIImage *outputImage = [self createCIImageWithString:urlStr];
    UIImage *finalImage =  [self createImageWithCIImage:outputImage withSize:codeSize];
    return finalImage;
}
//限制大小
+(CGFloat)limitCodeSize:(CGFloat)codeSize{
    codeSize = MAX(160, codeSize);
    codeSize = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 80, codeSize);
    return codeSize;
}

/// 根据urlStr 创建CIImage
+(CIImage *)createCIImageWithString:(NSString *)urlStr{
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 2、设置数据
    NSString *info = urlStr;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

/// 根据CIImage生成指定大小的UIImage
+ (UIImage *)createImageWithCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/// 根据二维码图片设置 获取 水印图片rect
+(CGRect)getWaterImageRectWithImage:(UIImage *)orginQRImage{
    
    CGSize linkSize = CGSizeMake(orginQRImage.size.width / 4, orginQRImage.size.height / 4);
    CGFloat linkX = (orginQRImage.size.width -linkSize.width)/2;
    CGFloat linkY = (orginQRImage.size.height -linkSize.height)/2;
    return CGRectMake(linkX, linkY, linkSize.width, linkSize.height);
}

-(UIImage*)scaleToSize:(CGSize)size{
    size = CGSizeMake(size.width  , size.height );
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width , size.height )];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/// 裁剪带边框的图片 可设置圆角 边框颜色
+(UIImage *)clipImageRadiousWithImage:(UIImage *)image circleRect:(CGRect)rect radious:(CGFloat)radious borderWith:(CGFloat)borderW borderColor:( UIColor *)borderColor{
    
    radious = rect.size.width/2.0;
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置边框
    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious];
    [borderColor setFill];
    [path fill];
    
    //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2) cornerRadius:radious];
    [clipPath addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}

/// 添加水印图片
+ (UIImage *)createWaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.获取图片
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

//图片缩放
- (UIImage *)zz_scaleImageToScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

/**图片缩放 按宽高*/
-(UIImage *)zz_scaleImageToWidth:(float)width toHeight:(float)height{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**图片缩放 按大小 单位:mb*/
-(NSData *)zz_compressImageToKBytes:(CGFloat)kByte{
    
    /*
     8bit(位)=1Byte(字节)
     1024Byte(字节)=1KB
     1024KB=1MB
     1024MB=1GB
     */
    NSData * data = UIImagePNGRepresentation(self);
    
    CGFloat dataKBytes = data.length/1024.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = kByte * 1024;
    while (dataKBytes > lastData && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1024.0;
        if (dataKBytes <lastData) {
            break;
        }
    }
    return data;
}

/// 获取屏幕截屏
+ (NSData *)getImageDataScreenShot{
    CGSize imageSize = CGSizeZero;
    imageSize = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}
@end
