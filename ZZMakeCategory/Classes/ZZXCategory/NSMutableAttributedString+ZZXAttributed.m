//          
//  NSMutableAttributedString+ZZXAttributed.m
//  Created  on 2020/8/6.
//

#import "NSMutableAttributedString+ZZXAttributed.h"

@implementation NSMutableAttributedString (ZZXAttributed)

/// 图+文混排
+ (NSMutableAttributedString *)zzx_getAttributedString:(NSString *)text
                                              textFont:(UIFont *)textFont
                                                 image:(UIImage *)image
                                                  left:(BOOL)left{
    NSMutableAttributedString *contentAtt = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : textFont}];
    NSTextAttachment *imageMent = [[NSTextAttachment alloc] init];
    imageMent.image = image;
    CGFloat paddingTop = (textFont.lineHeight - textFont.pointSize)/2;
    imageMent.bounds = CGRectMake(0, -paddingTop, image.size.width, image.size.height);
    NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:imageMent];
    if (left) {
        [contentAtt insertAttributedString:imageAtt atIndex:0];//插入到第几个下标
    }else{
        [contentAtt appendAttributedString:imageAtt];//添加到尾部
    }
    return contentAtt;
    
}


@end
