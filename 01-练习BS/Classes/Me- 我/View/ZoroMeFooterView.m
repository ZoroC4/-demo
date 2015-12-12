//
//  ZoroMeFooterView.m
//  01-练习BS
//
//  Created by grylls on 15/11/17.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroMeFooterView.h"
#import "ZoroMeSquare.h"
#import <MJExtension.h>
#import <AFNetworking.h>

#import "ZoroMeSquareButton.h"
#import <SafariServices/SafariServices.h>
#import "ZoroWebViewController.h"



@implementation ZoroMeFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseObject) {
            // 字典数组 -> 模型数组
            NSArray *squares = [ZoroMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 根据模型数据创建对应的控件
            [self creatSquares:squares];
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ZoroLog(@"请求失败 - %@", error);

        }];
    }
    return self;
}

         //根据模型数据创建对应控件
         
- (void)creatSquares:(NSArray *)squares
{
    //创建方块个数
    NSUInteger count = squares.count;
    
    //设置方块尺寸
    
    int maxColsCount = 4 ;//一行的最大列数
    CGFloat buttonW = self.zoro_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    
    for (NSUInteger i = 0; i < count; i++) {
        //i对应的数据模型
        ZoroMeSquare *square = squares[i];
        
        //创建按钮
        ZoroMeSquareButton *button = [ZoroMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    
        //设置frame
        button.zoro_x = (i % maxColsCount) *buttonW;
        button.zoro_y = (i / maxColsCount) *buttonH;
        button.zoro_width = buttonW;
        button.zoro_height = buttonH;
        
        //设置数据
        button.square = square;
    
    }
    //设置footer的高度
    self.zoro_height = self.subviews.lastObject.zoro_bottom;
     // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];//重新刷新数据 会重新计算contentsize
    
}

- (void)buttonClick:(ZoroMeSquareButton *)button
{
    NSString *url = button.square.url;
    if ([url hasPrefix:@"http"]) {
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVc.selectedViewController;
        
    //显示小码哥webviewController
    ZoroWebViewController *webView = [[ZoroWebViewController alloc] init];
    webView.url = url;
    webView.navigationController.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
   
    }else if([url hasPrefix:@"mod"]){
        //另行处理
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            ZoroLog(@"跳转到[审帖]界面");
        }else if ([url hasSuffix:@"BDJ_To_RecentHot"]) {
            ZoroLog(@"跳转到[每日排行]界面");
        } else {
            ZoroLog(@"跳转到其他界面");
        }
    } else {
        ZoroLog(@"不是http或者mod协议的");
    }
}

@end
             
