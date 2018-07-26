//
//  HBTImageLabelCollectionCell.m
//  Huoban
//
//  Created by zhoubo on 2018/3/15.
//  Copyright © 2018年 huoban. All rights reserved.
//

#import "HBTImageLabelCollectionCell.h"

@implementation HBTImageLabelCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 6.f;
}

@end
