//
//  ZoroFollowViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroFollowViewController.h"
#import "ZoroRecommendFollowViewController.h"
#import "ZoroLoginRegisterViewController.h"

@interface ZoroFollowViewController ()
/**文本框**/

@property(nonatomic,weak) UITextField *textField;

@end

@implementation ZoroFollowViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =ZoroCommonBgColor;
    //标题
    self.navigationItem.title = @"我的关注";
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
}

- (IBAction)loginRegister{
    ZoroLoginRegisterViewController *loginRegister = [[ZoroLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];

}

- (void)followClick
{
    ZoroLogFunc
    
    ZoroRecommendFollowViewController *follow = [[ZoroRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:follow animated:YES];
}


@end
