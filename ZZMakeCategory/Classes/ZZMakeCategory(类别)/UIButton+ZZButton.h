//
//  UIButton+ZZButton.h
//
//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ CountDoneBlock)(UIButton * responseObj);

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

typedef NS_ENUM(NSInteger, ZZButtonImageTitleStyle ) {
    ZZButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ZZButtonImageTitleStyleLeft  = 1,         //图片在左，文字在右，整体居中。
    ZZButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ZZButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ZZButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ZZButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上，距离按钮顶部。
    ZZButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下，距离按钮底部。
    ZZButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ZZButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ZZButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ZZButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};


@interface UIButton (ZZButton)

/**
 * 设置普通状态与高亮状态的背景图片
 */
-(void)zz_setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;


/**
 *  UIButton文字图片垂直显示
 *
 *  @param image    图片
 *  @param title    文字
 *  @param target   self
 *  @param selector 点击时间
 *
 *  @return 返回button
 */
+ (UIButton*)zz_createButtonWithImage:(NSString *)image Title:(NSString *)title Target:(id)target Selector:(SEL)selector;


/**
 *  图片按钮
 *
 *  @param frame        尺寸
 *  @param target       self
 *  @param selector     点击事件
 *  @param image        前景颜色
 *  @param imagePressed 高亮颜色
 *
 *  @return 返回button
 */
+ (UIButton*)zz_createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed;

/**
 *  文字按钮

 *  @param title    标题
 *  @param target   self
 *  @param selector 点击事件
 *
 *  @return 返回button
 */
+ (UIButton *)zz_createButtonWithTitle:(NSString *)title Target:(id)target Selector:(SEL)selector;


/**
 常规文字图片按钮

 @param title title
 @param image image
 @param backgroundColor backgroundColor
 @param titleFont titleFont
 @param target target
 @param selector selector
 @return 一个常规按钮
 */
+(UIButton *)zz_createButtonWithTitle:(NSString *)title Image:(NSString *)image BackgroundColor:(UIColor *)backgroundColor TitleFont:(float)titleFont Target:(id)target Selector:(SEL)selector;

/**
 创建一个自定义按钮

 @param title title
 @param image image
 @param backgroundColor backgroundColor
 @param titleFont titleFont
 @param style title和image的布局
 @param space title和image的间隔
 @param target target
 @param selector selector
 @return 一个自定义按钮
 */
+(UIButton *)zz_createButtonWithTitle:(NSString *)title Image:(NSString *)image BackgroundColor:(UIColor *)backgroundColor TitleFont:(float)titleFont Style:(ZZButtonImageTitleStyle)style Space:(CGFloat)space Target:(id)target Selector:(SEL)selector;

/**
 调整按钮的文本和image的布局，title和image同时存在才会调整。
 @param style 类型
 @param padding 整个按钮和图文的间隔
 */
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;


/**
 设置按钮的title和image的布局，title和image同时存在才会调整，每次title修改需重新调用一次
 @param style title和image的布局类型
 @param space title和image的间隔
 */
-(void)zz_setupButtonWithStyle:(ZZButtonImageTitleStyle)style Space:(CGFloat)space;

/**
 创建一个倒计时的按钮

 @param timeLine 倒计时
 @param title title
 @param subTitle 描述
 @param countDoneBlock 倒计时f回调
 @param isInteraction 是否交互
 */
- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(CountDoneBlock)countDoneBlock isInteraction:(BOOL)isInteraction;
@end

NS_ASSUME_NONNULL_END
