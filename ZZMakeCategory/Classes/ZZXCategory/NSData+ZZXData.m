//          
//  NSData+ZZXData.m
//  Created  on 2020/6/8.
//

#import "NSData+ZZXData.h"

@implementation NSData (ZZXData)

+ (NSData *)zzx_dataWithBundleNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (id)zzx_dataWithJsonName:(NSString *)jsonName{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //NSLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}
@end
