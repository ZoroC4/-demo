//
//  ZoroExtensionConfig.m
//  01-练习BS
//
//  Created by grylls on 15/11/29.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroExtensionConfig.h"
#import <MJExtension.h>
#import "ZoroTopic.h"
#import "ZoroComment.h"

@implementation ZoroExtensionConfig
+ (void)load
{
    [ZoroTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [ZoroComment class]};
    }];
    
    [ZoroTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
}


@end
