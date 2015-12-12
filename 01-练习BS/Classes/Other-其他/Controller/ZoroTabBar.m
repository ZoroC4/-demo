//
//  ZoroTabBar.m
//  01-练习BS
//
//  Created by grylls on 15/11/6.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTabBar.h"


@interface ZoroTabBar ()

@property (nonatomic,weak) UIButton *publishButton;


@end
@implementation ZoroTabBar

#pragma mark -- 懒加载
- (UIButton *)publishButton
{
    if (!_publishButton) {
        
        UIButton *publishButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        publishButton.backgroundColor = ZoroRandomColor;
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

      
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        _publishButton = publishButton;
        [self addSubview:publishButton];
        
        
    }
    return _publishButton;
}

#pragma mark -- 初始化
//布局子控件

- (void)layoutSubviews
{
    [super layoutSubviews];

    /**设置UITabBarButton的frame**/
    

    CGFloat buttonW = self.frame.size.width/5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    //按钮索引
    
    int buttonIndex = 0;
    
  
    for (UIView *subview in self.subviews) {
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
       
        CGFloat buttonX = buttonIndex *buttonW;
        if (buttonIndex>=2) {
            buttonX +=buttonW;
            
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        buttonIndex++;
    }
    /***设置中间按钮的frame****/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
}

//监听一个按钮

- (void)publishClick
{
    ZoroLogFunc

}



@end
