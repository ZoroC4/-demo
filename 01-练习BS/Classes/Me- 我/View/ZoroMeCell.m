//
//  ZoroMeCell.m
//  01-练习BS
//
//  Created by grylls on 15/11/17.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroMeCell.h"

@implementation ZoroMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    //imageView
    
    self.imageView.zoro_y = ZoroSmallMargin;
    self.imageView.zoro_height = self.contentView.zoro_height - 2 * ZoroSmallMargin;
    self.imageView.zoro_width = self.imageView.zoro_height;
    
    //label
    self.textLabel.zoro_x = self.imageView.zoro_right + ZoroMargin;
    
}

@end
