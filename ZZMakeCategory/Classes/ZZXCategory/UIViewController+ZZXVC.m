//
//  UIViewController+ZZXVC.m
//  Created  on 2020/5/31.
//

#import "UIViewController+ZZXVC.h"
#import <objc/runtime.h>
@implementation UIViewController (ZZXVC)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //交换跳转模式
//        SEL sel = @selector(modalPresentationStyle);
//        SEL swizzSel = @selector(swiz_modalPresentationStyle);
//        Method method = class_getInstanceMethod([self class], sel);
//        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
//        BOOL isAdd = class_addMethod(self, sel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
//        if (isAdd) {
//            class_replaceMethod(self, swizzSel, method_getImplementation(method), method_getTypeEncoding(method));
//        }else{
//            method_exchangeImplementations(method, swizzMethod);
//        }
        
        //埋点 ViewDidLoad
        SEL selViewDidLoad = @selector(viewDidLoad);
        SEL swizzSelViewDidLoad = @selector(swiz_ViewDidLoad);
        Method methodViewDidLoad = class_getInstanceMethod([self class], selViewDidLoad);
        Method swizzMethodViewDidLoad = class_getInstanceMethod([self class], swizzSelViewDidLoad);
        BOOL isAddViewDidLoad = class_addMethod(self, selViewDidLoad, method_getImplementation(swizzMethodViewDidLoad), method_getTypeEncoding(swizzMethodViewDidLoad));
        if (isAddViewDidLoad) {
            class_replaceMethod(self, swizzSelViewDidLoad, method_getImplementation(methodViewDidLoad), method_getTypeEncoding(methodViewDidLoad));
        }else{
            method_exchangeImplementations(methodViewDidLoad, swizzMethodViewDidLoad);
        }
    });
}

//
- (UIModalPresentationStyle)swiz_modalPresentationStyle {
    return UIModalPresentationOverFullScreen;
}


-(void)swiz_ViewDidLoad{
#ifdef DEBUG
    NSLog(@"【 %@ ViewDidLoad 】",self);
#endif
    
    [self swiz_ViewDidLoad];
}
@end
