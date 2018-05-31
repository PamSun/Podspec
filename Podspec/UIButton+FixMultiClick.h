//
//  UIButton+FixMultiClick.h
//  MoreTimeAction
//
//  Created by 孙鹏 on 17/4/12.
//  添加针对点击事件的时间间隔相关的处理代码, 则能够做到在1s中防止重复点击
//  Copyright © 2017年 51job. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FixMultiClick)
@property (nonatomic, assign) NSTimeInterval acceptEventTime;
@end
