//
//  HBTImageLabelHeaderView.m
//  iOSDemos
//
//  Created by zhoubo on 2018/7/18.
//  Copyright © 2018年 zhoubo. All rights reserved.
//

#import "HBTImageLabelHeaderView.h"

@implementation HBTImageLabelHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    _hbImageView.layer.masksToBounds = YES;
    _hbImageView.layer.cornerRadius = 13;
}

@end
