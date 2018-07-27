//
//  HBTCardTableViewController.h
//  iOSDemos
//
//  Created by zhoubo on 2018/7/18.
//  Copyright © 2018年 zhoubo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HBTCardTableViewCell.h"
#import "HBTCardFooterView.h"

/**
 * @class HBTCardTableViewController
 *
 * @brief A foldable card style UITableView controller.
 */
@interface HBTCardTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, HBTCardItemCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 * [{"header":{"ri":"reusable identifier"},
 *   "rowDatas":
 *     [{"ri":"folder", ...},  // @see HBTCardFolderCell
 *      {"ri":"blank", ...},   // @see HBTCardBlankFolderCell
 *      {"ri":"group", ...},   // @see HBTCardGroupCell
 *      {"ri":"grid", ...},    // @see HBTCardGridCell
 *      },...]
 *   }, ...]
 */
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataSections;

@property (nonatomic) CGFloat defaultCellHeight;    // 45
@property (nonatomic) CGFloat defaultHeaderHeight;  // 1
@property (nonatomic) CGFloat defaultFooterHeight;  // 10
@property (nonatomic, strong) NSMutableDictionary *customCellHeights; // {"blank":10}

#pragma mark - Overrides

// data = {"items":[]}
- (BOOL)isFoldableCellWithData:(NSDictionary *)data;

- (void)refreshCellHeightsWithDatas:(NSArray *)datas;
- (NSNumber *)calculateCellHeightWithData:(NSDictionary *)data;

#pragma mark - Operations

//- (NSMutableDictionary *)createFolderWithTitle:(NSString *)title unfold:(BOOL)unfold;
//- (NSMutableDictionary *)createGroupWithTitle:(NSString *)title unfold:(BOOL)unfold;

- (NSMutableDictionary *)headerAtSection:(NSInteger)section;
- (NSMutableArray *)rowDatasAtSection:(NSInteger)section;
- (NSMutableDictionary *)rowDataAtIndexPath:(NSIndexPath *)indexPath;

@end
