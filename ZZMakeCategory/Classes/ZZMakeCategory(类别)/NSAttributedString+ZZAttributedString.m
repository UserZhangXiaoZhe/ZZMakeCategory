//
//  NSAttributedString+ZZAttributedString.m

//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "NSAttributedString+ZZAttributedString.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (ZZAttributedString)

- (CGFloat)zz_getAttributedStringHeightBasedWidth:(CGFloat)width{
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self zz_boundingHeightForWidth:width];
}

- (CGFloat)zz_boundingHeightForWidth:(CGFloat)inWidth{
    
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self boundingRectWithSize:CGSizeMake(inWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 3;
}

- (CGFloat)zz_boundingWidthForHeight:(CGFloat)inHeight{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) self);
    CGSize suggestedSize         = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(CGFLOAT_MAX, inHeight), NULL);
    CFRelease(framesetter);
    return suggestedSize.width;
}

@end
