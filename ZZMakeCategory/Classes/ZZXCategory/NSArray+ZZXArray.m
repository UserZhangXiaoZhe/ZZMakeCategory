//          
//  NSArray+ZZXArray.m
//  Created  on 2020/8/5.
//

#import "NSArray+ZZXArray.h"
#import <objc/runtime.h>
@implementation NSArray (ZZXArray)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Method originalMethod1 = class_getInstanceMethod(__NSArrayI, @selector(objectAtIndexedSubscript:));
        Method swizzledMethod1 = class_getInstanceMethod(__NSArrayI, @selector(my_objectAtIndexedSubscript:));
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
    });
}

- (id)my_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < 0 || idx >= self.count) {
#ifdef DEBUG
        NSLog(@"数组越界了~~~~~");
#endif
        return self[0];
    }
    return [self my_objectAtIndexedSubscript:idx];
}

@end
