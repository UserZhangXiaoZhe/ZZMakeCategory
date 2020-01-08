//
//  UIView+ZZView.m

//  Created by  on 2019/11/29.
//  Copyright © 2019 zz. All rights reserved.
//

#import "UIView+ZZView.h"
#import <objc/runtime.h>

const char *blockKey = "blockKey";
const char *haveParameterBlockKey = "haveParameterBlockKey";

@implementation UIView (ZZView)

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


- (void)setTapBlock:(TapBlock)tapBlock {
    objc_setAssociatedObject(self, &blockKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TapBlock)tapBlock {
    return objc_getAssociatedObject(self, &blockKey);
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

- (void)setHaveParameterTapBlock:(HaveParameterTapBlock)haveParameterTapBlock {
    objc_setAssociatedObject(self, &haveParameterBlockKey, haveParameterTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (HaveParameterTapBlock)haveParameterTapBlock {
    return objc_getAssociatedObject(self, &haveParameterBlockKey);
}

- (void)addSingleClickTapGesHaveParameter:(HaveParameterTapBlock)block {
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

@end
