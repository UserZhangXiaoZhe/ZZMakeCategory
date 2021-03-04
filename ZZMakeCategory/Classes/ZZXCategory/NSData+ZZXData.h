//          
//  NSData+ZZXData.h
//  Created  on 2020/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZZXData)

+ (NSData *)zzx_dataWithBundleNamed:(NSString *)name;

/// 解析本地Json数据
+ (id)zzx_dataWithJsonName:(NSString *)jsonName;
@end

NS_ASSUME_NONNULL_END
