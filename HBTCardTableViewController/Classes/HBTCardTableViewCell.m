//
//  HBTCardTableViewCell.m
//  iOSDemos
//
//  Created by zhoubo on 2018/7/18.
//  Copyright © 2018年 zhoubo. All rights reserved.
//

#import "HBTCardTableViewCell.h"
//#import "HBTableCollectionCell.h"

#import "UIView+HBLayoutConstraint.h"

@interface HBTCardItemwCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageViewBottomConstraint;

- (void)initBackgroundImageView;

@end

@implementation HBTCardItemwCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self initBackgroundImageView];
}

- (void)setBackgroundImageType:(HBTCardItemwCellBackgroundImageType)backgroundImageType {
    if (_backgroundImageType != backgroundImageType) {
        _backgroundImageType = backgroundImageType;

        if (backgroundImageType == HBTCardItemwCellBackgroundImageNone) {
            [self.bgImageView removeFromSuperview];
            return;
        }

        if (_bgImageView == nil) {
            UIImageView *imageView = [UIImageView new];
            [self.contentView addSubview:imageView];
            _bgImageView = imageView;
            [self.contentView sendSubviewToBack:imageView];
            [imageView hblc_top:0.f toView:self.contentView];
            [imageView hblc_left:5.f toView:self.contentView];
            [imageView hblc_right:5.f toView:self.contentView];
            _bgImageViewBottomConstraint = [imageView hblc_bottom:_isLastDataOfSection ? 6.f : 0.f toView:self.contentView];
        }

        switch (_backgroundImageType) {
            case HBTCardItemwCellBackgroundImageTop:
                self.bgImageView.image = [[UIImage imageNamed:@"bgRoundShadowTop"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 11, 0, 11)];
                break;
            case HBTCardItemwCellBackgroundImageMiddle:
                self.bgImageView.image = [[UIImage imageNamed:@"bgRoundShadowMiddle"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 11, 0, 11)];
                break;
            default:
                break;
        }
    }
}

- (void)setIsLastDataOfSection:(BOOL)isLastDataOfSection {
    _isLastDataOfSection = isLastDataOfSection;

    self.bgImageViewBottomConstraint.constant = isLastDataOfSection ? 6.f : 0.f;
}

- (void)initBackgroundImageView {
    self.backgroundImageType = HBTCardItemwCellBackgroundImageMiddle;
}

@end

@implementation HBTCardContainerCell

- (void)setData:(NSDictionary *)data {
    if ([self.cellDelegate respondsToSelector:@selector(containerCellWillInitialize:)]) {
        [self.cellDelegate containerCellWillInitialize:self];
    }
    
    [super setData:data];
    self.items = data[@"items"];
}

@end

@implementation HBTCardBlankFolderCell

- (void)initBackgroundImageView {
    self.backgroundImageType = HBTCardItemwCellBackgroundImageTop;
}

@end

@implementation HBTCardFolderCell

- (void)initBackgroundImageView {
    self.backgroundImageType = HBTCardItemwCellBackgroundImageTop;
}

- (void)setData:(NSDictionary *)data {
    [super setData:data];
    
    _titleLabel.text = data[@"title"];
    self.unfold = [data[@"unfold"] boolValue];
}

- (void)setUnfold:(BOOL)unfold {
    self.iconLabel.text = unfold ? @"\ue621" : @"\ue60a";
}

@end

@implementation HBTCardGroupCell

- (void)initBackgroundImageView {
//    self.backgroundImageType = HBTCardItemwCellBackgroundImageMiddle;
}

- (void)setData:(NSDictionary *)data {
    [super setData:data];

    if (data[@"first_without_folder"]) {
        self.backgroundImageType = HBTCardItemwCellBackgroundImageTop;
        self.topSeparator.hidden = YES;
    } else {
        self.backgroundImageType = HBTCardItemwCellBackgroundImageMiddle;
        self.topSeparator.hidden = NO;
    }
}

@end

@interface HBTCardGridCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation HBTCardGridCell

- (void)initialize {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger mw = (MIN(size.height, size.width) - 40 * 2 - 20) / 3;
    layout.itemSize = CGSizeMake(mw, 81);
}

- (void)setData:(NSDictionary *)data {
    [super setData:data];

    [_collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.cellDelegate respondsToSelector:@selector(containerCell:itemDidClickAtIndexPath:)]) {
        [self.cellDelegate containerCell:self itemDidClickAtIndexPath:indexPath];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([self.cellDelegate respondsToSelector:@selector(containerCell:cellForItemAtIndexPath:)]) {
        return [self.cellDelegate containerCell:self cellForItemAtIndexPath:indexPath];
    }

    return nil;
}

@end
