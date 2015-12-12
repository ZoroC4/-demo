//
//  ZoroTopicViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/30.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTopicViewController.h"
#import "ZoroHTTPSessionManager.h"
#import "ZoroTopic.h"
#import <MJExtension.h>
#import "ZoroRefreshFooter.h"
#import "ZoroRefreshHeader.h"
#import "ZoroTopicCell.h"
#import "ZoroNewViewController.h"
#import <UIImageView+WebCache.h>



@interface ZoroTopicViewController ()

//所有帖子数据
@property (nonatomic,strong) NSMutableArray <ZoroTopic *> *topics;
//下拉刷新提示文字
@property (nonatomic,weak) UILabel *label;
//maxtime:加载下一页数据
@property (nonatomic,copy)NSString *maxtime;
//任务管理者
@property (nonatomic,strong) ZoroHTTPSessionManager *manager;

- (NSString *)aParam;


@end

@implementation ZoroTopicViewController

static NSString * const ZoroTopicCellId = @"topic";

#pragma mark -- 消除type警告
- (ZoroTopicType)type
{
    return 0;

}

#pragma mark --懒加载


- (ZoroHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [ZoroHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    ZoroLogFunc
    
    [self setupRefresh];
    
    
}

- (void)setupTable
{
    self.tableView.backgroundColor = ZoroCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZoroTopicCell class]) bundle:nil] forCellReuseIdentifier:ZoroTopicCellId];
    
}

- (void)setupRefresh
{
    
    self.tableView.mj_header =[ZoroRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [ZoroRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    

}


- (NSString *)aParam
{
    if (self.parentViewController.class == [ZoroNewViewController class]) {
        return @"newlist";
        
    }
    return @"list";
}


#pragma mark --加载数据
- (void)loadNewTopics
{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    //发送请求
    [self.manager GET:ZoroCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典 -> 模型
        self.topics = [ZoroTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [responseObject[@"list"] writeToFile:@"/Users/grylls/Desktop/topic.plist" atomically:YES];
        
        
        //刷新表格
        [self.tableView reloadData];
        
        //让刷新控件结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZoroLog(@"请求失败 - %@", error);
        //让刷新控件结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreTopics
{
    //取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
    // 发送请求
    [self.manager GET:ZoroCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<ZoroTopic *> *moreTopics = [ZoroTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZoroLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZoroTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZoroTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark -- 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}


@end
