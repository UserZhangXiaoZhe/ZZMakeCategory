//          
//  UIButton+ZZXButton.m
//  Created  on 2020/7/17.
//

#import "UIButton+ZZXButton.h"

@implementation UIButton (ZZXButton)

-(void)zz_setTitleN_C:(UIColor *)nc H_C:(UIColor *)hc{
    
    [self setTitleColor:nc forState:(UIControlStateNormal)];
    [self setTitleColor:hc forState:(UIControlStateSelected)];
    [self setTitleColor:hc forState:(UIControlStateHighlighted)];
    [self setTitleColor:hc forState:(UIControlStateDisabled)];
}
-(void)zz_setImage_N:(NSString *)nbg Image_H:(NSString *)hbg{
    
    [self setImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:hbg] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:hbg] forState:UIControlStateDisabled];
}
-(void)zz_setBgImage_N:(NSString *)nbg BgImage_H:(NSString *)hbg{
    
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateDisabled];
}

- (void)layoutButtonWithEdgeInsetsStyle:(ZZXButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
    // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值

    switch (style) {
        case ZZXButtonEdgeInsetsStyleTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case ZZXButtonEdgeInsetsStyleLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ZZXButtonEdgeInsetsStyleBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ZZXButtonEdgeInsetsStyleRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end
