//
//  ZoroTopicCell.m
//  01-练习BS
//
//  Created by grylls on 15/11/22.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopicCell.h"
#import "ZoroTopic.h"
#import <UIImageView+WebCache.h>
#import "ZoroUser.h"
#import "ZoroComment.h"
#import "ZoroTopicPictureView.h"
#import "ZoroTopicVideoView.h"
#import "ZoroTopicVoiceView.h"



@interface ZoroTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;


//评论整体
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) ZoroTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) ZoroTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) ZoroTopicVideoView *videoView;


@end



@implementation ZoroTopicCell

#pragma mark --懒加载


- (ZoroTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ZoroTopicPictureView *pictureView = [ZoroTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ZoroTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ZoroTopicVoiceView *voiceView = [ZoroTopicVoiceView viewFromXib];
        
        [self.contentView addSubview:voiceView];
        
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (ZoroTopicVideoView *)videoView
{
    if (!_videoView) {
        ZoroTopicVideoView *voideView = [ZoroTopicVideoView viewFromXib];
        [self.contentView addSubview:voideView];
        _videoView = voideView;
    }
    return _videoView;
}


- (void)awakeFromNib
{
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(ZoroTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text= topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
    //最热评论内容
    
    // 最热评论
    if (topic.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.user.username; // 用户名
        NSString *content = topic.top_cmt.content; // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    // 中间内容
#pragma mark - 根据XMGTopic模型数据的情况来决定中间添加什么控件(内容)
    if (topic.type == ZoroTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        self.pictureView.hidden = YES;
        
    } else if (topic.type == ZoroTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        
    } else if (topic.type == ZoroTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    } else if (topic.type == ZoroTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}



- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= ZoroMargin;
    frame.origin.y += ZoroMargin;
    
    
    [super setFrame:frame];
}



- (IBAction)more {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    
    
}


@end
