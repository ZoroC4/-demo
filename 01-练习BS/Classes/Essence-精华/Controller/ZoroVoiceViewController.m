//
//  ZoroVoiceViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/21.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroVoiceViewController.h"


@interface ZoroVoiceViewController ()

@end

@implementation ZoroVoiceViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
}

- (ZoroTopicType)type
{
    return ZoroTopicTypeVoice;
}

@end
