//
//  ZoroWordViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/21.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroWordViewController.h"

@interface ZoroWordViewController ()

@end

@implementation ZoroWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.view addSubview:[[UISwitch alloc] init]];
    
    
}

- (ZoroTopicType)type
{
    return ZoroTopicTypeWord;

}



@end
