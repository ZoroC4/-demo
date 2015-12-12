//
//  ZoroTopicVideoView.m
//  01-练习BS
//
//  Created by grylls on 15/11/25.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopicVideoView.h"
#import "ZoroTopic.h"
#import <UIImageView+WebCache.h>

@interface ZoroTopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end


@implementation ZoroTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;

}

- (void)setTopic:(ZoroTopic *)topic
{
    _topic = topic;
    NSLog(@"%@", self.imageView);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];


}



@end
