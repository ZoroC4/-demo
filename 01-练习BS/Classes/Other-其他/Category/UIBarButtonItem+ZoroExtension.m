//
//  UIBarButtonItem+ZoroExtension.m
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "UIBarButtonItem+ZoroExtension.h"

@implementation UIBarButtonItem (ZoroExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];

}

@end


