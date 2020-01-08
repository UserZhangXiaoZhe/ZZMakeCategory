//
//  UIButton+ZZButton.m
//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIButton+ZZButton.h"
#import "UIColor+ZZColor.h"

@implementation UIButton (ZZButton)

-(void)zz_setN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateDisabled];
}

+ (UIButton*) zz_createButtonWithImage:(NSString *)image Title:(NSString *)title Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton new];
    UIImage *newImage = [self scaleImageWithImage:[UIImage imageNamed:image] Size:CGSizeMake(35, 35)];
    [button setImage:newImage forState:UIControlStateNormal];
    [button setImage:newImage forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font =[UIFont systemFontOfSize:14 ];
        
    }
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    //设置内容垂直或水平显示位置
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 20, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

+ (UIButton*) zz_createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *newPressedImage = [UIImage imageNamed: imagePressed];
    [button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)zz_createButtonWithTitle:(NSString *)title Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return button;
}


+(UIButton *)zz_createButtonWithTitle:(NSString *)title Image:(NSString *)image BackgroundColor:(UIColor *)backgroundColor TitleFont:(float)titleFont Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:titleFont]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
    
    [button setImage:[UIImage imageNamed: image] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed: image] forState:(UIControlStateHighlighted)];
    [button setImage:[UIImage imageNamed: image] forState:(UIControlStateSelected)];
    
    [button setBackgroundColor:backgroundColor];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+(UIImage*) scaleImageWithImage:(UIImage *)image Size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding{
    if (self.imageView.image != nil && self.titleLabel.text != nil){
    
    //先还原
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    
    CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat selfWidth = self.frame.size.width;
    
    switch (style) {
        case ButtonImageTitleStyleLeft:
            if (padding != 0) {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, padding/2, 0, -padding/2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2, 0, padding/2);
            }
            break;
        case ButtonImageTitleStyleRight:
        {
            //图片在右，文字在左
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding/2), 0, (imageRect.size.width + padding/2));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width+ padding/2), 0, -(titleRect.size.width+ padding/2));
        }
            break;
        case ButtonImageTitleStyleTop:
        {
            //图片在上，文字在下
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                    -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                    (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                    -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
            
        }
            break;
        case ButtonImageTitleStyleBottom:
        {
            //图片在下，文字在上。
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                    (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                    -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case ButtonImageTitleStyleCenterTop:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    (titleRect.origin.y - padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case ButtonImageTitleStyleCenterBottom:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case ButtonImageTitleStyleCenterUp:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case ButtonImageTitleStyleCenterDown:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case ButtonImageTitleStyleRightLeft:
        {
            //图片在右，文字在左，距离按钮两边边距
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(titleRect.origin.x - padding), 0, (titleRect.origin.x - padding));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - imageRect.origin.x - imageRect.size.width), 0, -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
        }
            
            break;
            
        case ButtonImageTitleStyleLeftRight:
        {
            //图片在左，文字在右，距离按钮两边边距
            self.titleEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                    0, -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.origin.x - padding), 0, (imageRect.origin.x - padding));
        }
            break;
        default:
            break;
    }
}
    else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

+(UIButton *)zz_createButtonWithTitle:(NSString *)title Image:(NSString *)image BackgroundColor:(UIColor *)backgroundColor TitleFont:(float)titleFont Style:(ZZButtonImageTitleStyle)style Space:(CGFloat)space Target:(id)target Selector:(SEL)selector{
    
    UIButton *button = [self zz_createButtonWithTitle:title Image:image BackgroundColor:backgroundColor TitleFont:titleFont Target:target Selector:selector];
    [button zz_setupButtonWithStyle:style Space:space];
    
    return button;
}

-(void)zz_setupButtonWithStyle:(ZZButtonImageTitleStyle)style Space:(CGFloat)space{
    
    //先还原
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    
    // 1. 得到imageView和titleLabel的宽、高
    //    CGFloat imageWith = self.imageView.frame.size.width;
    //    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat imageWith = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    
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
    //正数就是距相应的边的距离增加，负数就是距相应的距离减少
    
    switch (style) {
        case ZZButtonImageTitleStyleTop: {
            //图片在上，title在下
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
        }
            break;
        case ZZButtonImageTitleStyleLeft: {
            //图片在左，title在右
            imageEdgeInsets = UIEdgeInsetsMake(space, space, space, -space);
            labelEdgeInsets = UIEdgeInsetsMake(space, 0, space, 0);
        }
            break;
        case ZZButtonImageTitleStyleBottom: {
            //图片在下，title在上
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
        }
            break;
        case ZZButtonImageTitleStyleRight: {
            //图片在右，title在左              top left bottom right
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageHeight-space, 0, imageWith+space);
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space, 0, -labelWidth-space);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(CountDoneBlock)countDoneBlock isInteraction:(BOOL)isInteraction{
    __block NSInteger timeout = timeLine; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (countDoneBlock) {
                    countDoneBlock(self);
                }
                //设置界面的按钮显示 根据自己需求设置
                self.userInteractionEnabled = YES;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];;
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self setTitle:[NSString stringWithFormat:@"%@s%@",strTime,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor zz_colorWithHexString:@"c1c1c1"] forState:UIControlStateNormal];
                //self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
                
                self.userInteractionEnabled = isInteraction;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

@end
