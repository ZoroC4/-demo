//
//  ZoroLoginRegisterTextField.m
//  01-练习BS
//
//  Created by grylls on 15/11/11.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroLoginRegisterTextField.h"

static NSString * const ZoroPlaceholderColorKey = @"placeholderLabel.textColor";
@interface ZoroLoginRegisterTextField ()

@end



@implementation ZoroLoginRegisterTextField



- (void)awakeFromNib
{
    //设置光标
    self.tintColor = [UIColor whiteColor];
    //设置默认的占位颜色
    [self setValue:[UIColor grayColor] forKeyPath:ZoroPlaceholderColorKey];
    

}

//调用时成为第一响应者

- (BOOL)becomeFirstResponder
{

    [self setValue:[UIColor grayColor] forKeyPath:ZoroPlaceholderColorKey];
    return [super resignFirstResponder];


}



@end
