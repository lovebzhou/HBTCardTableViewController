//
//  HBTCardFooterView.m
//  Huoban
//
//  Created by zhoubo on 2018/7/20.
//  Copyright © 2018年 huoban. All rights reserved.
//

#import "HBTCardFooterView.h"
#import "UIImage+PDF.h"

@implementation HBTCardFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgImageView.image = [[UIImage originalSizeImageWithPDFNamed:@"bgRoundShadowBottom.pdf"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 11, 0, 11)];
}

@end
