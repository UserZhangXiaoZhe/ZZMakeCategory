//
//  NSURL+ZZURL.m

//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "NSURL+ZZURL.h"
#import <objc/runtime.h>

@implementation NSURL (ZZURL)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = [self class];
        SEL originalSelector = @selector(URLWithString:);
        SEL swizzledSelector = @selector(zz_checkURL:);
        swizzleMethod(targetClass, originalSelector, swizzledSelector);
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    //class_getInstanceMethod 获取成员方法
    //class_getClassMethod    获取类方法
    
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+(instancetype)zz_checkURL:(NSString *)urlStr{
    
    if (urlStr == nil || [urlStr isEqualToString:@""] || urlStr == NULL || [urlStr isKindOfClass:[NSNull class]] || [[urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [urlStr isEqual:[NSNull null]] ) {
        NSLog(@"URL为空");
    }
    
    NSString *tempStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //已经替换过，走的是系统方法，不是递归
    NSURL *url = [self zz_checkURL:tempStr];
    if (url == nil) {
        NSLog(@"URL转换失败");
    }
    return url;
}

@end
