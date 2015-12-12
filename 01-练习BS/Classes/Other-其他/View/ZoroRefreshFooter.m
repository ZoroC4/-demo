//
//  ZoroRefreshFooter.m
//  01-练习BS
//
//  Created by grylls on 15/11/21.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroRefreshFooter.h"

@implementation ZoroRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
    //    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    //    self.automaticallyRefresh = NO;
}

@end
