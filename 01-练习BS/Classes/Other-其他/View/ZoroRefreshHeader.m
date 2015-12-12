//
//  ZoroRefreshHeader.m
//  01-练习BS
//
//  Created by grylls on 15/11/21.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroRefreshHeader.h"

@interface ZoroRefreshHeader ()

@property (nonatomic,weak) UIImageView *logo;

@end

@implementation ZoroRefreshHeader

- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
    [self addSubview:[[UISwitch alloc] init]];
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"bd_logo1"];
    [self addSubview:logo];
    self.logo = logo;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.zoro_width = self.zoro_width;
    self.logo.zoro_height = 50;
    self.logo.zoro_x = 0;
    self.logo.zoro_y = - 50;
}


@end
