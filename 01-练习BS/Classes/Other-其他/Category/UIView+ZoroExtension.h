//
//  UIView+ZoroExtension.h
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZoroExtension)
@property (nonatomic, assign) CGFloat zoro_width;
@property (nonatomic, assign) CGFloat zoro_height;
@property (nonatomic, assign) CGFloat zoro_x;
@property (nonatomic, assign) CGFloat zoro_y;
@property (nonatomic, assign) CGFloat zoro_centerX;
@property (nonatomic, assign) CGFloat zoro_centerY;

@property (nonatomic, assign) CGFloat zoro_right;
@property (nonatomic, assign) CGFloat zoro_bottom;

+(instancetype)viewFromXib;

@end
