//
//  ZoroTabBarViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/5.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroTabBarViewController.h"
#import "ZoroTabBar.h"

#import "ZoroEssenceViewController.h"
#import "ZoroFollowViewController.h"
#import "ZoroMeViewController.h"
#import "ZoroNewViewController.h"
#import "ZoroNavigationController.h"

@interface ZoroTabBarViewController ()



@end

@implementation ZoroTabBarViewController




#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpChildViewControllers];
    [self setupItemTitleTextAttribute];
    [self setUpTabBar];
    

    
}
//设置文字属性
- (void)setupItemTitleTextAttribute
{
    //设置所有文字属性
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    /**** 文字属性 ****/
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
}
- (void)setUpChildViewControllers
{
    
    /**** 添加子控制器 ****/

      [self setUpOneChildViewController:[[ZoroNavigationController alloc] initWithRootViewController:[[ZoroMeViewController alloc] init]]  title:@"我" image:@"tabBar_me_icon"selectedImage:@"tabBar_me_click_icon"];
  
    [self setUpOneChildViewController:[[ZoroNavigationController alloc] initWithRootViewController:[[ZoroFollowViewController alloc] init]]  title:@"关注" image:@"tabBar_friendTrends_icon"selectedImage:@"tabBar_friendTrends_click_icon"];
    
    
    [self setUpOneChildViewController:[[ZoroNavigationController alloc] initWithRootViewController:[[ZoroEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon"selectedImage:@"tabBar_essence_click_icon"];
    [self setUpOneChildViewController: [[ZoroNavigationController alloc] initWithRootViewController:[[ZoroNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon"selectedImage:@"tabBar_new_click_icon"];
    
    
}


/**
 *  初始化一个子控制器
 *  @param vc            子控制器  @param title         标题
 *  @param image         图标     @param selectedImage 选中的图标
 */

- (void) setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = ZoroRandomColor;
    vc.tabBarItem.title = title;
    if (image.length) {
        
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
   
    [self addChildViewController:vc];
    
}

-(void)setUpTabBar
{
    //更换tabbar
    [self setValue:[[ZoroTabBar alloc] init] forKey:@"tabBar"];

}
@end
