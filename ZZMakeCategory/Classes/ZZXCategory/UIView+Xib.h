//
//  UIView+Xib.h
//  InfrareRc
//
//  Created by 杨朋 on 2019/6/12.
//  Copyright © 2019年 Tensorflow. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Xib)
/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;


-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color;

-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color AndborderWidth:(CGFloat)borderWidth;
@end

NS_ASSUME_NONNULL_END
