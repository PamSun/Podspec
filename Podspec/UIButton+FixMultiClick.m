//
//  UIButton+FixMultiClick.m
//  MoreTimeAction
//
//  Created by 孙鹏 on 17/4/12.
//  Copyright © 2017年 51job. All rights reserved.
//

#import "UIButton+FixMultiClick.h"
#import <objc/runtime.h>

@implementation UIButton (FixMultiClick)

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

// 通过runtime的关联对象的方式, 为UIButton添加个属性
- (NSTimeInterval)acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(new_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime < 1) {
        return;
    }
    self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    
    [self new_sendAction:action to:target forEvent:event];
}
@end
