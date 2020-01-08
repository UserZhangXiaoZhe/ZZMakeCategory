//
//  NSArray+ZZNSArray.h
//  ZZTools_Example
//
//  Created by 张哲 on 2018/12/18.
//  Copyright © 2018年 UserZhangXiaoZhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZZNSArray)

/** 检查数组 */
- (BOOL)zz_checkBlankWithArray;

/** 获取系统相薄数组的方法 */
+ (NSArray *)zz_getPhotoFromSystem;

/** 将一个gif图转换为一帧一帧的图片数组*/
+ (NSArray *)zz_imagesWithGif:(NSString *)gifNameInBoundle;

@end

NS_ASSUME_NONNULL_END
