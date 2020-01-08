//
//  NSAttributedString+ZZAttributedString.h

//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (ZZAttributedString)

/** 根据约束的宽度来求NSAttributedString的高度 */
- (CGFloat)zz_getAttributedStringHeightBasedWidth:(CGFloat)width;

- (CGFloat)zz_boundingWidthForHeight:(CGFloat)inHeight;
@end

NS_ASSUME_NONNULL_END
