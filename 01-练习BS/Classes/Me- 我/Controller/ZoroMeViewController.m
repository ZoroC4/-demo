//
//  ZoroMeViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroMeViewController.h"
#import "ZoroSettingViewController.h"

#import "ZoroMeCell.h"
#import "ZoroMeFooterView.h"


@interface ZoroMeViewController ()

@end

@implementation ZoroMeViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTable];
    [self setupNav];
    
    
}

- (void)setupTable
{
    self.tableView.backgroundColor =ZoroCommonBgColor;
    self.tableView.sectionHeaderHeight = 0 ;
    self.tableView.sectionFooterHeight = ZoroMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(ZoroMargin - 35, 0, 0, 0);
    
    //设置footer
    self.tableView.tableFooterView = [[ZoroMeFooterView alloc] init];
    

}

- (void)setupNav
{

    //标题
    self.navigationItem.title = @"我";
    
    //右边 -设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    //右边 - 月亮
    // 右边-月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    

}
- (void)settingClick
{
    ZoroLogFunc
    
    ZoroSettingViewController *setting = [[ZoroSettingViewController alloc] init];
    setting.view.backgroundColor = ZoroRandomColor;
//    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)moonClick
{
    ZoroLogFunc;
}


#pragma mark -- 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //1.确定重用标识
    
    static NSString *ID = @"me";
    
    //2.从缓存池取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    //4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登入/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
        
    }else{
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    
    return cell;
}



@end
