//
//  ZoroSeeBigViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/30.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroSeeBigViewController.h"
#import "ZoroTopic.h"
#import <UIImageView+WebCache.h>

#import  <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ZoroSeeBigViewController ()<UIScrollViewDelegate>
//图片控件
@property (nonatomic,weak)UIImageView *imageView;


@end

@implementation ZoroSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate  = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    
    imageView.zoro_width = scrollView.zoro_width;
    imageView.zoro_height = self.topic.height * imageView.zoro_width / self.topic.width;
    imageView.zoro_x = 0 ;
    
    if (imageView.zoro_height >= scrollView.zoro_height) {//图片高度超过整个屏幕
        imageView.zoro_y =  0;
        //滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.zoro_height);
        
    }else{//居中显示
        imageView.zoro_centerY = scrollView.zoro_height*0.5;
        
    }
    self.imageView = imageView;
    //缩放比例
    CGFloat scale = self.topic.width / imageView.zoro_width;
    if (scale>1.0) {
        scrollView.maximumZoomScale = scale;
    }
}



- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
}

#pragma mark -- <UIScrollViewDelegate>

//返回一个子控件进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;

}

@end
