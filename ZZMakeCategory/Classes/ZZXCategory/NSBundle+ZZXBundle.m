//          
//  NSBundle+ZZXBundle.m
//  Created  on 2020/6/17.
//

#import "NSBundle+ZZXBundle.h"
#import "ZZXCategory.h"


@implementation NSBundle (ZZXBundle)

+ (NSBundle *)zzxTabBarIconBundle{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url  = [bundle URLForResource:@"TabBarIcon" withExtension:@"bundle"];
    return [self bundleWithURL:url];
}
 
+ (NSBundle *)zzxHomeIconBundle{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url  = [bundle URLForResource:@"HomeIcon" withExtension:@"bundle"];
    return [self bundleWithURL:url];
}
 
+ (NSBundle *)zzxMeIconBundle{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url  = [bundle URLForResource:@"MeIcon" withExtension:@"bundle"];
    return [self bundleWithURL:url];
}
+ (NSBundle *)zzxOtherIconBundle{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url  = [bundle URLForResource:@"OtherIcon" withExtension:@"bundle"];
    return [self bundleWithURL:url];
}
@end
