//
//  NSDictionary+ZZNSDictionary.h
//  ZZTools_Example
//
//  Created by 张哲 on 2018/12/18.
//  Copyright © 2018年 UserZhangXiaoZhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const ZZKEY_KEY ;
extern NSString *const ZZKEY_TITLE ;
extern NSString *const ZZKEY_NAME ;
extern NSString *const ZZKEY_URL ;
extern NSString *const ZZKEY_PHONE ;
extern NSString *const ZZKEY_ITEM ;
extern NSString *const ZZKEY_TYPE;
extern NSString *const ZZKEY_TOTAL ;
extern NSString *const ZZKEY_SESSIONID;
extern NSString *const ZZKEY_FLAG;
extern NSString *const ZZKEY_RESULT;
extern NSString *const ZZKEY_MESSAGE;
extern NSString *const ZZKEY_EVENT;
extern NSString *const ZZKEY_DATA;

extern NSString *const ZZKEY_DATEDAY;
extern NSString *const ZZKEY_DATESECOND;

@interface NSDictionary (ZZNSDictionary)

/** 检查字典 */
-(BOOL)zz_checkBlankWithDictionary;

@end

NS_ASSUME_NONNULL_END
