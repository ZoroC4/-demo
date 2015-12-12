//
//  ZoroTopicPictureView.m
//  01-练习BS
//
//  Created by grylls on 15/11/25.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "ZoroTopic.h"
#import "ZoroSeeBigViewController.h"
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>


@interface ZoroTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end

@implementation ZoroTopicPictureView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigButton)]];
}

- (void)seeBig
{
    ZoroSeeBigViewController *seeBig = [[ZoroSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
    
}



-(void)setTopic:(ZoroTopic *)topic
{
    _topic = topic;
    
    
    // 由于是模拟器
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    if (topic.isBigPicture) { // 超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
