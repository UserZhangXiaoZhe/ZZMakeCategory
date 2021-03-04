//          
//  UIControl+ZZXControl.m
//  Created  on 2020/6/11.
//

#import "UIControl+ZZXControl.h"
#import <objc/runtime.h>

static const char * UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

@implementation UIControl (ZZXControl)

// 时间间隔
-(void)setAcceptEventInterval:(double)acceptEventInterval {
    //关联属性对象
    objc_setAssociatedObject(self, UIControl_acceptEventInterval,@(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

// 接收消息时间
- (NSTimeInterval)acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//所有类即将加入内存的时候都会走load方法，所以我们在这个里面交换方法
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //分别获取
        SEL beforeSelector = @selector(sendAction:to:forEvent:);
        SEL afterSelector = @selector(swizzing_sendAction:to:forEvent:);
        
        Method beforeMethod = class_getInstanceMethod(class, beforeSelector);
        Method afterMethod = class_getInstanceMethod(class, afterSelector);
        //先尝试给原来的方法添加实现，如果原来的方法不存在就可以添加成功。返回为YES，否则
        //返回为NO。
        //UIButton 真的没有sendAction方法的实现，这是继承了UIControl的而已，UIControl才真正的实现了。
        BOOL didAddMethod =
        class_addMethod(class,beforeSelector,method_getImplementation(afterMethod),
                        method_getTypeEncoding(afterMethod));
        if (didAddMethod) {
            // 如果之前不存在，但是添加成功了，此时添加成功的是cs_sendAction方法的实现
            // 这里只需要方法替换
            class_replaceMethod(class,afterSelector,method_getImplementation(beforeMethod),
                                method_getTypeEncoding(beforeMethod));
        } else {
            //本来如果存在就进行交换
            method_exchangeImplementations(afterMethod, beforeMethod);
        }
    });
    
}

-(void)swizzing_sendAction:(SEL)action to:(id)tagert forEvent:(UIEvent*)event{

    //CGFloat timeSpace = [NSDate date].timeIntervalSince1970 - self.acceptEventTime;
    
    //MyLog(@"按钮点击：%f -- %f",timeSpace,self.acceptEventInterval);
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime < self.acceptEventInterval) {
        return;
    }

    if (self.acceptEventInterval > 0) {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    //当前按钮调用该方法
    [self swizzing_sendAction:action to:tagert forEvent:event];
}

@end
