//
//  ZoroComment.h
//  01-练习BS
//
//  Created by grylls on 15/11/24.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZoroUser;

@interface ZoroComment : NSObject


/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) ZoroUser *user;

@end
