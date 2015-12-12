//
//  ZoroEssenceViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/7.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroEssenceViewController.h"
#import "ZoroTitleButton.h"
#import "ZoroAllViewController.h"
#import "ZoroVideoViewController.h"
#import "ZoroVoiceViewController.h"
#import "ZoroPictureViewController.h"
#import "ZoroWordViewController.h"




@interface ZoroEssenceViewController ()<UIScrollViewDelegate>

//当前选中的标题按钮
@property (nonatomic,weak) ZoroTitleButton *selectedTitleButton;
//标题按钮底部指示器
@property (nonatomic,weak) UIView *indicatorView;
//UIScrollView
@property (nonatomic,weak) UIScrollView *scrollView;
//标题栏
@property (nonatomic,weak) UIView *titilesView;



@end
@implementation ZoroEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addchildVcView];
    

    

}

- (void)setupChildViewControllers
{
    ZoroAllViewController *all = [[ZoroAllViewController alloc] init];
    [self addChildViewController:all];
    
    ZoroVideoViewController *video = [[ZoroVideoViewController alloc] init];
    [self addChildViewController:video];
    
    ZoroVoiceViewController *voice = [[ZoroVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    ZoroPictureViewController *picture = [[ZoroPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    ZoroWordViewController *word = [[ZoroWordViewController alloc] init];
    [self addChildViewController:word];

}

- (void)setupScrollView
{
    //不允许自动调整scrollView的边距
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = ZoroCommonBgColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES ;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    //添加所有的子控制器到scrollview
    NSUInteger count = self.childViewControllers.count;

    scrollView.contentSize = CGSizeMake(count * scrollView.zoro_width, 0);
    
     [self.view  addSubview:scrollView];
    self.scrollView = scrollView;
}


- (void)setupTitlesView
{
//标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    titlesView.frame = CGRectMake(0, 64, self.view.zoro_width, 35);
    [self.view addSubview:titlesView];
    
    
//添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.zoro_width / count ;
    CGFloat titleButtonH = titlesView.zoro_height;
    
    for (NSUInteger i = 0 ; i < count; i++) {
        
        //创建
        ZoroTitleButton *titleButton = [ZoroTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:titleButton];
        
        //设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        //设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        //
        titleButton.tag = i;
    }
    //按钮选中的颜色
    ZoroTitleButton *firstTitleButton = titlesView.subviews.lastObject;
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.zoro_height = 1;
    indicatorView.zoro_y = titlesView.zoro_height - indicatorView.zoro_height;
    [titlesView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.zoro_width = firstTitleButton.titleLabel.zoro_width;
    indicatorView.zoro_centerX = firstTitleButton.zoro_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;

}

- (void)setupNav
{
    self.view.backgroundColor = ZoroCommonBgColor;
    
    //标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

#pragma mark --监听按钮的点击

- (void)titleClick:(ZoroTitleButton *)titleButton

{   //按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton =titleButton;
    
    //指示器
    [UIView animateWithDuration:0.25 animations:^{
    
    ///
        self.indicatorView.zoro_width = titleButton.titleLabel.zoro_width;
        self.indicatorView.zoro_centerX = titleButton.zoro_centerX;
        
    }];
    
     //让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag *self.scrollView.zoro_width;
    [self.scrollView setContentOffset:offset animated:YES];
}



-(void)tagClick
{
    ZoroLogFunc;
}

#pragma mark - 添加子控制器的View

- (void)addchildVcView
{
    //子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.zoro_width;
    NSLog(@"%f",self.scrollView.contentOffset.x);
    
    //取出子控制器
    
    UIViewController *chidVc =self.childViewControllers[index];
    
    if ([chidVc isViewLoaded]) return;
    
    chidVc.view.frame = self.scrollView.bounds;
    
    [self.scrollView addSubview:chidVc.view];
}


#pragma mark - <UIScrollViewDelegate>

//UIScrollView动画

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addchildVcView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//选中点击的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.zoro_width;
    
    ZoroTitleButton *titlebutton = self.titilesView.subviews[index];
    [self titleClick:titlebutton];
    
    //添加子控制器的View
    
    [self addchildVcView];
}



@end
