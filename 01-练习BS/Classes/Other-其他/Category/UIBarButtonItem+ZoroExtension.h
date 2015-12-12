//
//  UIBarButtonItem+ZoroExtension.h
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZoroExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
