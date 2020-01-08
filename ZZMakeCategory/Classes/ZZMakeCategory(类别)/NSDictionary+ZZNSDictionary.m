//
//  NSDictionary+ZZNSDictionary.m
//  ZZTools_Example
//
//  Created by 张哲 on 2018/12/18.
//  Copyright © 2018年 UserZhangXiaoZhe. All rights reserved.
//

#import "NSDictionary+ZZNSDictionary.h"

NSString *const ZZKEY_KEY = @"key";
NSString *const ZZKEY_TITLE = @"title";
NSString *const ZZKEY_NAME = @"name";
NSString *const ZZKEY_URL = @"url";
NSString *const ZZKEY_PHONE = @"phone";
NSString *const ZZKEY_ITEM = @"item";
NSString *const ZZKEY_TYPE = @"type";
NSString *const ZZKEY_TOTAL = @"total";
NSString *const ZZKEY_SESSIONID = @"sessionId";
NSString *const ZZKEY_FLAG = @"flag";
NSString *const ZZKEY_RESULT = @"result";
NSString *const ZZKEY_MESSAGE = @"message";
NSString *const ZZKEY_EVENT = @"event";
NSString *const ZZKEY_DATA = @"data";

NSString *const ZZKEY_DATEDAY = @"yyyy-MM-dd";
NSString *const ZZKEY_DATESECOND = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDictionary (ZZNSDictionary)

- (BOOL)zz_checkBlankWithDictionary{
    
    if (!self) return YES;
    
    if ([self isKindOfClass:[NSNull class]]) return YES;
    
    if (self == nil) return YES;
    
    if (self == NULL) return YES;
    
    if (![self isKindOfClass:[NSDictionary class]]) return YES;
    
    if (self.count == 0) return YES;
    return NO;
}

- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM.copy;
}
@end
