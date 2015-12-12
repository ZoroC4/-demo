//
//  ZoroTopicVoiceView.m
//  01-练习BS
//
//  Created by grylls on 15/11/25.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopicVoiceView.h"
#import "ZoroTopic.h"
#import <UIImageView+WebCache.h>




@interface ZoroTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation ZoroTopicVoiceView

- (void)awakeFromNib
{

    self.autoresizingMask = UIViewAutoresizingNone;
}


-(void)setTopic:(ZoroTopic *)topic
{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    

}

@end
