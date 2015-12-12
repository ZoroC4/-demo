//
//  ZoroSettingViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroSettingViewController.h"
#import "ZoroTestViewController.h"
#import <SDImageCache.h>
#import "ZoroClearCacheCell.h"
#import "ZoroOtherCell.h"

@interface ZoroSettingViewController ()

@end
@implementation ZoroSettingViewController

static NSString * const ZoroClearCacheCellId = @"ZoroClearCacheCell";
static NSString * const ZoroSettingCellId = @"ZoroSettingCell";
static NSString * const ZoroOtherCellId = @"ZoroOtherCell";


- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =ZoroCommonBgColor;
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[ZoroClearCacheCell class] forCellReuseIdentifier:ZoroClearCacheCellId];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZoroSettingCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZoroOtherCell class]) bundle:nil] forCellReuseIdentifier:ZoroOtherCellId];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZoroTestViewController *test =[[ZoroTestViewController alloc] init];
    
    
    [self.navigationController pushViewController:test animated:YES];
}


#pragma mark --数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    if (section == 1) return 5;
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    //清楚缓存cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return [tableView dequeueReusableCellWithIdentifier:ZoroClearCacheCellId];
        
    } else if (indexPath.row == 2) {
        
        return [tableView dequeueReusableCellWithIdentifier:ZoroOtherCellId];


    }
    
    // 其他cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZoroSettingCellId];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    
    return cell;
}


@end
