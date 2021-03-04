//          
//  NSMutableAttributedString+ZZXAttributed.h
//  Created  on 2020/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZZXAttributed)

/// 图+文混排
+ (NSMutableAttributedString *)zzx_getAttributedString:(NSString *)text
                                              textFont:(UIFont *)textFont
                                                 image:(UIImage *)image
                                                  left:(BOOL)left;
    

@end

NS_ASSUME_NONNULL_END
