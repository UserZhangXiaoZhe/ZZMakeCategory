//
//  UIView+ZZXView.m
//  Created  on 2020/5/31.
//

#import "UIView+ZZXView.h"
#import <objc/runtime.h>

const char *tapBlockKey = "tapBlockKey";
const char *tapBlockKeyWithParameter = "tapBlockKeyWithParameter";


@implementation UIView (ZZXView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

-(void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
-(CGFloat)top{
    return self.frame.origin.y;
}

-(void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
-(CGFloat)left{
    return self.frame.origin.x;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

-(void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
-(CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

#pragma mark - 单击事件
- (void)setTapBlock:(TapBlock)tapBlock {
    objc_setAssociatedObject(self, &tapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TapBlock)tapBlock {
    return objc_getAssociatedObject(self, &tapBlockKey);
}

- (void)addSingleClickTapGes:(TapBlock)block {
    self.tapBlock = block; // 把block赋值给self.tapBlock, 可以在当前函数之外执行该回调
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    [self addGestureRecognizer:tap];
}

- (void)tapGes {
    if (self.tapBlock) {
        self.tapBlock(); // 执行回调
    }
}

- (void)setHaveParameterTapBlock:(TapBlockWithParameter)haveParameterTapBlock {
    objc_setAssociatedObject(self, &tapBlockKeyWithParameter, haveParameterTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TapBlockWithParameter)haveParameterTapBlock {
    return objc_getAssociatedObject(self, &tapBlockKeyWithParameter);
}

- (void)addSingleClickTapGesWithParameter:(TapBlockWithParameter)block {
    self.haveParameterTapBlock = block; // 把block赋值给self.tapBlock, 可以在当前函数之外执行该回调
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(haveParameterTapBlockTapGes:)];
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    [self addGestureRecognizer:tap];
}

- (void)haveParameterTapBlockTapGes:(UITapGestureRecognizer *)tap {
    if (self.haveParameterTapBlock) {
        self.haveParameterTapBlock(tap); // 执行回调
    }
}

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/// view转成image
- (UIImage*)zzx_changeIntoImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

@end
