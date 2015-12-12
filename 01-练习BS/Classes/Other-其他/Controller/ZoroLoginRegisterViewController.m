//
//  ZoroLoginRegisterViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/8.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroLoginRegisterViewController.h"
#import "ZoroLoginRegisterTextField.h"

@interface ZoroLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;



@end

@implementation ZoroLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle{

return UIStatusBarStyleLightContent;
}

//关闭界面
- (IBAction)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//显示当前页面

- (IBAction)showLoginOrRegister:(UIButton *)button
{   //退出键盘
    [self.view endEditing:YES];
    //设置约束
    if (self.leftMargin.constant) {
        //目前选择的是注册界面，点击后切换
        self.leftMargin.constant=0;
        button.selected = NO;
    }else{
    //目前显示的是登入界面，切换后显示注册界面
        self.leftMargin.constant = - self.view.zoro_width;
        button.selected = YES;
        
    }
    //动画
    [UIView animateWithDuration:0.25 animations:^{
    
        [self.view layoutIfNeeded];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
}

@end
