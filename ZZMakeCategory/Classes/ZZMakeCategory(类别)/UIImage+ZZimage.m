//
//  UIImage+ZZimage.m
//
//  Created by  on 2018/10/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIImage+ZZimage.h"

@implementation UIImage (ZZimage)

+(UIImage*)zz_createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//图片缩放
- (UIImage *)zz_scaleImageToScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}
-(UIImage *)zz_scaleImageToWidth:(float)width toHeight:(float)height{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**图片缩放 按大小*/
-(NSData *)zz_compressImageToKBytes:(CGFloat)kByte{
    
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1024.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > kByte && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1024.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+(UIImage *)zz_stretchedImageWithName:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

+ (UIImage *)zz_createImageWithText:(NSString *)text
                  textFont:(NSInteger)fontSize
                 textColor:(UIColor *)textColor
                 textFrame:(CGRect)textFrame
               originImage:(UIImage *)originImage
    imageLocationViewFrame:(CGRect)viewFrame {
    
    if (!text)      {  return originImage;   }
    if (!fontSize)  {  fontSize = 17;   }
    if (!textColor) {  textColor = [UIColor blackColor];   }
    if (!originImage)     {  return nil;  }
    if (viewFrame.size.height==0 || viewFrame.size.width==0 || textFrame.size.width==0 || textFrame.size.height==0 ){return nil;}
    NSString *mark = text;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //CGSizeMake(MAXFLOAT,MAXFLOAT) 不限制文字的宽度或高度
    CGRect rect = [mark boundingRectWithSize:CGSizeMake(textFrame.size.width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat height = ceilf(rect.size.height);
    
    
    if ((height + textFrame.origin.y) > viewFrame.size.height) { // 文字高度超出父视图的宽度
        height = viewFrame.size.height - textFrame.origin.y;
    }
    
    UIGraphicsBeginImageContext(viewFrame.size);
    //2.绘制图片
    [originImage drawInRect:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : textColor };
    //位置显示
    [mark drawInRect:CGRectMake(textFrame.origin.x, textFrame.origin.y, textFrame.size.width, height) withAttributes:attr];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
