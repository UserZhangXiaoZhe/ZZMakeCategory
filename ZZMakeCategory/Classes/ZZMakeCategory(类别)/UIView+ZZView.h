//
//  UIView+ZZView.h

//  Created by  on 2019/11/29.
//  Copyright © 2019 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TapBlock)(void);
typedef void (^HaveParameterTapBlock)(UITapGestureRecognizer * _Nonnull tap);

@interface UIView (ZZView)

/** 自定义x坐标*/
@property (assign, nonatomic) CGFloat x;
/** 自定义y坐标*/
@property (assign, nonatomic) CGFloat y;

/** 控件左侧 最小x值*/
@property (nonatomic,assign) CGFloat left;
/** 控件右边 最大x值*/
@property (nonatomic, assign) CGFloat right;
/** 控件顶部 最小y值*/
@property (nonatomic,assign) CGFloat top;
/** 控件底部 最大y值*/
@property (nonatomic, assign) CGFloat bottom;

/** 控件中心 x值*/
@property (nonatomic,assign) CGFloat centerX;
/** 控件中心 y值*/
@property (nonatomic,assign) CGFloat centerY;

/** 宽度*/
@property (assign, nonatomic) CGFloat width;
/** 高度*/
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGPoint origin;

/*
 CGRectGetHeight返回label本身的高度
 CGRectGetMinY返回label顶部的坐标
 CGRectGetMaxY 返回label底部的坐标
 CGRectGetMinX 返回label左边缘的坐标
 CGRectGetMaxX 返回label右边缘的坐标
 CGRectGetMidX表示得到一个frame中心点的X坐标
 CGRectGetMidY表示得到一个frame中心点的Y坐标
 */

@property (nonatomic, copy) TapBlock tapBlock;
@property (nonatomic, copy) HaveParameterTapBlock haveParameterTapBlock;
- (void)addSingleClickTapGes:(TapBlock)block;
- (void)addSingleClickTapGesHaveParameter:(HaveParameterTapBlock)block;

@end

NS_ASSUME_NONNULL_END
