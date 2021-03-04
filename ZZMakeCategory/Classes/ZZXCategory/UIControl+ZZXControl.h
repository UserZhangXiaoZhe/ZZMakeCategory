//          
//  UIControl+ZZXControl.h
//  Created  on 2020/6/11.
//

/**
 说明：防止快速点击 button
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (ZZXControl)

// 间隔多少秒才能响应事件
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

@property (nonatomic, assign) NSTimeInterval acceptEventTime;

@end

NS_ASSUME_NONNULL_END
