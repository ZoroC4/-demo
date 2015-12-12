//
//  ZoroQuickLoginButton.m
//  01-练习BS
//
//  Created by grylls on 15/11/8.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroQuickLoginButton.h"

@implementation ZoroQuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.zoro_y = 0;
    self.imageView.zoro_centerX =self.zoro_width*0.5;
    
    self.titleLabel.zoro_x = 0;
    self.titleLabel.zoro_y = self.imageView.zoro_bottom;
    self.titleLabel.zoro_height =self.zoro_height-self.titleLabel.zoro_y;
    self.titleLabel.zoro_width = self.zoro_width;
    

}

@end
