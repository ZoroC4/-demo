//
//  NSDate+ZoroExtension.h
//  01-练习BS
//
//  Created by grylls on 15/11/24.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZoroExtension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
