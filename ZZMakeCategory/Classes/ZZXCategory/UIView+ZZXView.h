//
//  UIView+ZZXView.h
//  Created  on 2020/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TapBlock)(void);
typedef void (^TapBlockWithParameter)(UITapGestureRecognizer * _Nonnull tap);

@interface UIView (ZZXView)

/** 自定义x坐标*/
@property (assign, nonatomic) CGFloat x;
/** 自定义y坐标*/
@property (assign, nonatomic) CGFloat y;

@property (nonatomic,assign) CGFloat top;

@property (nonatomic,assign) CGFloat left;
/** 控件底部*/
@property (nonatomic, assign) CGFloat bottom;
/** 控件右边*/
@property (nonatomic, assign) CGFloat right;

/** 自定义宽度*/
@property (assign, nonatomic) CGFloat width;
/** 自定义高度*/
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGPoint origin;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

@property (nonatomic, copy) TapBlock tapBlock;
@property (nonatomic, copy) TapBlockWithParameter haveParameterTapBlock;

- (void)addSingleClickTapGes:(TapBlock)block;
- (void)addSingleClickTapGesWithParameter:(TapBlockWithParameter)block;

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

#pragma mark -  view转成image
- (UIImage*)zzx_changeIntoImage;
@end

NS_ASSUME_NONNULL_END
