//
//  HBTViewController.m
//  HBTCardTableViewController
//
//  Created by lovebzhou on 07/26/2018.
//  Copyright (c) 2018 lovebzhou. All rights reserved.
//

#import "HBTViewController.h"
#import "HBTableCollectionCell.h"

@interface HBOfficeCenterNotificationCell : HBTCardItemwCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@interface HBTViewController ()

@end

@implementation HBTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - HBTCardItemCellDelegate

- (void)itemCell:(HBTCardItemwCell *)itemCell buttonDidClick:(UIButton *)sender {
    if ([itemCell isKindOfClass:[HBOfficeCenterNotificationCell class]]) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }
}

- (void)containerCellWillInitialize:(HBTCardGridCell *)gridCell {
    if ([gridCell isKindOfClass:[HBTCardGridCell class]]) {
        [gridCell.collectionView registerNib:[UINib nibWithNibName:@"HBTableCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
}

- (void)containerCell:(HBTCardGridCell *)gridCell itemDidClickAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = gridCell.items[indexPath.row];
    NSLog(@"%@", item);
}

- (UICollectionViewCell *)containerCell:(HBTCardGridCell *)gridCell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = gridCell.items[indexPath.row];
    
    HBTableCollectionCell *cell = [gridCell.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.iconLabel.text = [HBUtil iconCodeByString:[item valueForKeyPath:@"icon.id"]];
//    id colorKey = [item valueForKeyPath:@"icon.color"];
//    cell.iconLabel.backgroundColor = [UIColor hb_colorWithKey:colorKey];
//
//    cell.nameLabel.text = item[@"name"];
    
    return cell;
}

@end

@implementation HBOfficeCenterNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconLabel.text = @"\ue9c3";
}

- (void)setData:(NSDictionary *)data {
    [super setData:data];
    
    self.backgroundImageType = HBTCardItemwCellBackgroundImageTop;
    
    _contentLabel.text = data[@"content"];
}

- (IBAction)moreDidClick:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if ([self.cellDelegate respondsToSelector:@selector(itemCell:buttonDidClick:)]) {
        [self.cellDelegate itemCell:self buttonDidClick:sender];
    }
}

@end

