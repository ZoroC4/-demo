//
//  ZoroMeSquareButton.m
//  01-练习BS
//
//  Created by grylls on 15/11/18.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroMeSquareButton.h"
#import "ZoroMeSquare.h"
#import <UIButton+WebCache.h>

@implementation ZoroMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.zoro_y =  self.zoro_height *0.15;
    self.imageView.zoro_height = self.zoro_height *0.5;
    self.imageView.zoro_width = self.imageView.zoro_height;
    self.imageView.zoro_centerX = self.zoro_width*0.5;
    
    
    self.titleLabel.zoro_x = 0 ;
    self.titleLabel.zoro_y = self.imageView.zoro_bottom;
    self.titleLabel.zoro_width = self.zoro_width;
    self.titleLabel.zoro_height = self.zoro_height - self.titleLabel.zoro_y;
}

-(void)setSquare:(ZoroMeSquare *)square
{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];


}

@end
