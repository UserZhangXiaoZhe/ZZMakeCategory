//          
//  UIButton+ZZXButton.h
//  Created  on 2020/7/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZZXButtonEdgeInsetsStyle) {
    ZZXButtonEdgeInsetsStyleTop, // image在上，label在下
    ZZXButtonEdgeInsetsStyleLeft, // image在左，label在右
    ZZXButtonEdgeInsetsStyleBottom, // image在下，label在上
    ZZXButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (ZZXButton)

/// 设置普通状态与高亮状态 标题颜色
-(void)zz_setTitleN_C:(UIColor *)nc H_C:(UIColor *)hc;
/// 设置普通状态与高亮状态 图片
-(void)zz_setImage_N:(NSString *)nbg Image_H:(NSString *)hbg;
/// 设置普通状态与高亮状态 背景图片
-(void)zz_setBgImage_N:(NSString *)nbg BgImage_H:(NSString *)hbg;

- (void)layoutButtonWithEdgeInsetsStyle:(ZZXButtonEdgeInsetsStyle)style
imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
