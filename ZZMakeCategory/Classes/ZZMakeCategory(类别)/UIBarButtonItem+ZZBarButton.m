//
//  UIBarButtonItem+ZZBarButton.m

//  Created by UserBaiZi on 2019/11/29.
//  Copyright © 2019 zz. All rights reserved.
//

#import "UIBarButtonItem+ZZBarButton.h"
#import "UIView+ZZView.h"

@implementation UIBarButtonItem (ZZBarButton)

+ (instancetype)zz_barButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName  target:(id)target sel:(SEL)sel;
{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.size = CGSizeMake(24, 24);
    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    // 添加按钮监听事件
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    // 2.2. 将UIButton包装成UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    // 2.3返回item
    return item;
    
}

+(instancetype)zz_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target sel:(SEL)sel{
    
    return [[self alloc] initWithTitle:title style:style target:target action:sel];
}


+(instancetype)zz_barButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName Title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target sel:(SEL)sel{
    
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:10 ];
    }
    
    // 设置按钮的尺寸为背景图片的尺寸+文字大小
    btn.width = [self sizeWithTitle:title Font:btn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    
    btn.height = btn.currentImage.size.height + [self sizeWithTitle:title Font:btn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    
    //设置title在button上的位置（上top，左left，下bottom，右right）
    btn.titleEdgeInsets = UIEdgeInsetsMake(30,-30, 0, 0);
    
    
    // 添加按钮监听事件
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    // 将UIButton包装成UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    // 返回item
    return item;
}


+ (instancetype)zz_barButtonItemLeftAndRightWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName title:(NSString *)title  titleColor:(UIColor *)titleColor target:(id)target sel:(SEL)sel{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    btn.titleLabel.font =[UIFont systemFontOfSize:24];
    // 设置按钮的尺寸为背景图片的尺寸+文字大小
    btn.width = [self sizeWithTitle:title Font:btn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 44;
    btn.height = [self sizeWithTitle:title Font:btn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height + 44;
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //设置title在button上的位置（上top，左left，下bottom，右right）
    
    // 添加按钮监听事件
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    // 将UIButton包装成UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    // 返回item
    return item;
}
#pragma mark 计算字符串大小
+ (CGSize)sizeWithTitle:(NSString *)title Font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}
@end
