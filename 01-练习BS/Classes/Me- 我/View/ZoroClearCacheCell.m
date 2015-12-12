//
//  ZoroClearCacheCell.m
//  01-练习BS
//
//  Created by grylls on 15/11/19.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define ZoroCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@implementation ZoroClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    //设置cell右边指示器
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
    //设置cell右边文字
        
        self.textLabel.text = @"清除缓存(正在计算缓存大小...)";
        
        //禁止点击
          self.userInteractionEnabled = NO;
        
        //计算子线程大小
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            //获得缓存文件夹路径
            unsigned long long size = ZoroCustomCacheFile.fileSize;
            
            size += [SDImageCache sharedImageCache].getSize;
            
            NSString *sizeText = nil;
            
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            //生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                self.textLabel.text = text;
                // 清空右边的指示器
                self.accessoryView = nil;
                // 显示右边的箭头
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                // 添加手势监听器
                [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
                
                // 恢复点击事件
                self.userInteractionEnabled = YES;
            });
            
        });
    
    }
    return self;

}



//清楚缓存

- (void)clearCache
{
    // 弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType:SVProgressHUDMaskTypeBlack];
    
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:ZoroCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:ZoroCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
            
#warning 睡眠
            
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                
                // 设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}


@end
