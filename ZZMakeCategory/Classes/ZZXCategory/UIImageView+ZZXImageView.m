//
//  UIImageView+ZZXImageView.m
//  Created  on 2020/11/13.
//

#import "UIImageView+ZZXImageView.h"

@implementation UIImageView (ZZXImageView)

-(void)addBlurEffectWithAlpha:(CGFloat)alpha{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2);
    effectView.alpha = alpha;
    [self addSubview:effectView];
}

@end
