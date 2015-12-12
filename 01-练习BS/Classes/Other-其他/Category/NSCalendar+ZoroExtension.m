//
//  NSCalendar+ZoroExtension.m
//  01-练习BS
//
//  Created by grylls on 15/11/24.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "NSCalendar+ZoroExtension.h"

@implementation NSCalendar (ZoroExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}
@end
