//          
//  CALayer+ZZXLayer.m
//  Created  on 2020/8/6.
//

#import "CALayer+ZZXLayer.h"
#import "UIView+ZZXView.h"

@implementation CALayer (ZZXLayer)

/// 周边加阴影，并且同时圆角
+ (UIView *)addShadowToView:(UIView *)view
                shadowColor:(UIColor *)shadowColor
                withOpacity:(float)shadowOpacity
               shadowRadius:(CGFloat)shadowRadius
            andCornerRadius:(CGFloat)cornerRadius{
    
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    UIView *shadowView = [[UIView alloc] init];
    shadowView.frame = view.frame;
    shadowView.layer.shadowColor = shadowColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    shadowView.layer.shadowOpacity = shadowOpacity;
    shadowView.layer.shadowRadius = shadowRadius;
    shadowView.layer.cornerRadius = cornerRadius;
    shadowView.clipsToBounds = NO;
    
    view.frame = CGRectMake(0, 0, shadowView.width, shadowView.height);
    [shadowView addSubview:view];
    return shadowView;
}

+(CAGradientLayer*)rectGradientLayerWithBounds:(CGRect)rect
                                        colors:(NSArray *)colors
                                    startPoint:(CGPoint)startPoint
                                      endPoint:(CGPoint)endPoint{
    //颜色渐变层
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    //  设置颜色变化点，取值范围 0.0~1.0
    //  gradientLayer.locations = @[@0,@1];
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    return gradientLayer;
}

@end
