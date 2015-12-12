//
//  ZoroTopic.m
//  01-练习BS
//
//  Created by grylls on 15/11/21.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopic.h"
#import "ZoroUser.h"
#import "ZoroComment.h"


@implementation ZoroTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;


//在第一次使用ZoroTopic类时调用1次

+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];

}


- (NSString *)created_at
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) {
                // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) {
            // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        } else {
            // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    } else {
        // 不是今年
        return _created_at;
    }
}

- (CGFloat)cellHeight
{
    //如果cell的高度已经计算过就直接返回
    if(_cellHeight) return _cellHeight;
    
    //1.头像=55
    
    _cellHeight = 55;
    
    //2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * ZoroMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    _cellHeight +=textSize.height +ZoroMargin;
    
    //中间的内容
    
    if (self.type != ZoroTopicTypeWord) {
        
        
        // 中间内容的高度 == 中间内容的宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= [UIScreen mainScreen].bounds.size.height) { // 超长图片
            // 将超长图片的高度变为200
            contentH = 200;
            self.bigPicture = YES;
        }
        
        self.contentF = CGRectMake(ZoroMargin, _cellHeight, textMaxW, contentH);
        
        _cellHeight += contentH + ZoroMargin;
        
    }
    // 4.最热评论
    if (self.top_cmt) {//如果有最热评论
        //最热评论-标题
        _cellHeight +=20;
        
        // 最热评论-内容
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + ZoroMargin;

    }
    // 5.底部 - 工具条
    _cellHeight += 35 + ZoroMargin;
    
    return _cellHeight;
}




@end
