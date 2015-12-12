                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        //
//  ZoroTitleButton.m
//  01-练习BS
//
//  Created by grylls on 15/11/20.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTitleButton.h"

@implementation ZoroTitleButton


- (instancetype) initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        //设置按钮颜色
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    
    return self;

}

- (void)setHighlighted:(BOOL)highlighted
{

}


@end
