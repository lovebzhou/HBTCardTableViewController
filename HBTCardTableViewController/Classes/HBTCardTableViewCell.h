//
//  HBTCardTableViewCell.h
//  iOSDemos
//
//  Created by zhoubo on 2018/7/18.
//  Copyright © 2018年 zhoubo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HBTCardItemwCell, HBTCardContainerCell;

///
@protocol HBTCardItemCellDelegate <NSObject>

@optional

- (void)itemCell:(HBTCardItemwCell *)itemCell buttonDidClick:(UIButton *)sender;

#pragma mark - For containers

- (void)containerCellWillInitialize:(HBTCardContainerCell *)containerCell;

- (void)containerCell:(__kindof HBTCardContainerCell *)containerCell itemDidClickAtIndexPath:(NSIndexPath *)indexPath;

- (__kindof UIView *)containerCell:(__kindof HBTCardContainerCell *)containerCell cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger, HBTCardItemwCellBackgroundImageType) {
    HBTCardItemwCellBackgroundImageNone,
    HBTCardItemwCellBackgroundImageTop,
    HBTCardItemwCellBackgroundImageMiddle
};

/// item: data = {"ri":"reusable identifier",...}
@interface HBTCardItemwCell : UITableViewCell

@property (nonatomic, weak) id<HBTCardItemCellDelegate> cellDelegate;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic) HBTCardItemwCellBackgroundImageType backgroundImageType;

@property (nonatomic) BOOL isLastDataOfSection;

@end

/// container: data <<= {"items":[{...},...]}
@interface HBTCardContainerCell : HBTCardItemwCell

@property (nonatomic, strong) NSArray<NSDictionary *> *items;

@end

/// blank foler: data << {"ri":"blank"}
@interface HBTCardBlankFolderCell : HBTCardItemwCell

@end

/// folder: data <<= {"ri":folder","title":"","unfold":YES|NO,"items":[{...},...]}
@interface HBTCardFolderCell : HBTCardItemwCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

@property (nonatomic) BOOL unfold;

@end

/// group in folder: data <<= {"ri":"group","first_without_folder":YES|NO}
@interface HBTCardGroupCell : HBTCardFolderCell

@property (weak, nonatomic) IBOutlet UIView *topSeparator;

@end

/// grid style of container: {"ri":"grid"}
@interface HBTCardGridCell : HBTCardContainerCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
