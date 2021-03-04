//          
//  CALayer+ZZXLayer.h
//  Created  on 2020/8/6.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (ZZXLayer)

/*
 self.topBgView.frame = CGRectMake(15, 15, self.width-30, self.height -10 - 30);
 self.topBgView = [CALayer addShadowToView:self.topBgView
                               shadowColor:[UIColor zz_colorWithHexString:@"#06317033"]
                               withOpacity:1
                              shadowRadius:9
                           andCornerRadius:10];
 */
/// 周边加阴影，并且同时圆角
+ (UIView *)addShadowToView:(UIView *)view
                shadowColor:(UIColor *)shadowColor
                withOpacity:(float)shadowOpacity
               shadowRadius:(CGFloat)shadowRadius
            andCornerRadius:(CGFloat)cornerRadius;

/// 渐变色
/*
 CAGradientLayer *shareLayer = [CALayer rectGradientLayerWithBounds:self.shareBtn.bounds
                                                             colors:colors
                                                         startPoint:CGPointMake(0,0)
                                                           endPoint:CGPointMake(1,1)];
 [self.shareBtn.layer insertSublayer:shareLayer atIndex:0];
 */
+(CAGradientLayer*)rectGradientLayerWithBounds:(CGRect)rect
                                        colors:(NSArray *)colors
                                    startPoint:(CGPoint)startPoint
                                      endPoint:(CGPoint)endPoint;
@end

NS_ASSUME_NONNULL_END
