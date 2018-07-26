//
//  HBTImageLabelTableCell.m
//  HBTCardTableViewController_Example
//
//  Created by zhoubo on 2018/7/26.
//  Copyright © 2018年 lovebzhou. All rights reserved.
//

#import "HBTImageLabelTableCell.h"

@implementation HBTImageLabelTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 18.f;
}

- (void)setData:(NSDictionary *)data {
    [super setData:data];
    
    _avatarImageView.image = [UIImage imageNamed:data[@"avatar"]];
    _nameLabel.text = data[@"name"];
}

@end
