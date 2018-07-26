//
//  HBTableCollectionCell.m
//  Huoban
//
//  Created by zhoubo on 2018/3/15.
//  Copyright © 2018年 huoban. All rights reserved.
//

#import "HBTableCollectionCell.h"

@implementation HBTableCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconLabel.layer.masksToBounds = YES;
    _iconLabel.layer.cornerRadius = 6.f;
}

@end
