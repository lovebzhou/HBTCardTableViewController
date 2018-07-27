//
//  HBTCardTableViewController.m
//  iOSDemos
//
//  Created by zhoubo on 2018/7/18.
//  Copyright © 2018年 zhoubo. All rights reserved.
//

#import "HBTCardTableViewController.h"
#import "UIView+HBAnimation.h"
#import "HBTEmptyHeaderView.h"

@interface HBTCardTableViewController ()

@property (nonatomic) BOOL isCurrentDeviceLandscape;

@end

@implementation HBTCardTableViewController

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)initialize {
    _defaultCellHeight = 45.f;
    _defaultHeaderHeight = 1.f;
    _defaultFooterHeight = 10.f;
    _customCellHeights = [@{@"blank":@(10.f)} mutableCopy];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isCurrentDeviceLandscape = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
    
    [_tableView registerClass:[HBTEmptyHeaderView class] forHeaderFooterViewReuseIdentifier:@"empty"];
    [_tableView registerNib:[UINib nibWithNibName:@"HBTCardBlankFolderCell" bundle:[NSBundle bundleForClass: [HBTCardBlankFolderCell class]]] forCellReuseIdentifier:@"blank"];
    [_tableView registerNib:[UINib nibWithNibName:@"HBTCardFolderCell" bundle:[NSBundle bundleForClass: [HBTCardFolderCell class]]] forCellReuseIdentifier:@"folder"];
    [_tableView registerNib:[UINib nibWithNibName:@"HBTCardGroupCell" bundle:[NSBundle bundleForClass: [HBTCardGroupCell class]]] forCellReuseIdentifier:@"group"];
    [_tableView registerNib:[UINib nibWithNibName:@"HBTCardGridCell" bundle:[NSBundle bundleForClass: [HBTCardGridCell class]]] forCellReuseIdentifier:@"grid"];
    [_tableView registerNib:[UINib nibWithNibName:@"HBTCardFooterView" bundle:[NSBundle bundleForClass: [HBTCardFooterView class]]] forHeaderFooterViewReuseIdentifier:@"footer"];
}

#pragma mark - UITableDelegate

- (void)folderDidSelect:(NSDictionary *)rowData indexPath:(NSIndexPath *)indexPath changeDatas:(NSMutableArray *)changeDatas changeIndexPathes:(NSMutableArray *)indexPathes {
    NSArray<NSDictionary *> *items = rowData[@"items"];
    [items enumerateObjectsUsingBlock:^(NSDictionary * item, NSUInteger idx, BOOL * _Nonnull stop) {
        [changeDatas addObject:item];
        [indexPathes addObject:[NSIndexPath indexPathForRow:indexPath.row+changeDatas.count inSection:indexPath.section]];

        if ([self isFoldableCellWithData:item] && [item[@"unfold"] boolValue]) {
            [self folderDidSelect:item indexPath:indexPath changeDatas:changeDatas changeIndexPathes:indexPathes];
        }
    }];
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rowDatas = [self rowDatasAtSection:indexPath.section];
    NSMutableDictionary *rowData = rowDatas[indexPath.row];
    
    if (![self isFoldableCellWithData:rowData]) return;
    
    HBTCardFolderCell *folderCell = [_tableView cellForRowAtIndexPath:indexPath];

    rowData[@"unfold"] = @(![rowData[@"unfold"] boolValue]);

    NSMutableArray *changeDatas = [@[] mutableCopy];
    NSMutableArray<NSIndexPath *> *changeIndexPathes = [@[] mutableCopy];
    [self folderDidSelect:rowData indexPath:indexPath changeDatas:changeDatas changeIndexPathes:changeIndexPathes];

    folderCell.isLastDataOfSection = ![rowData[@"unfold"] boolValue] && (rowDatas.count == (indexPath.row + 1 + changeIndexPathes.count));
    [UIView animateWithDuration:0.2 animations:^{
        [folderCell layoutIfNeeded];
    }];

    if ([rowData[@"unfold"] boolValue]) {
        [rowDatas insertObjects:changeDatas atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1, changeDatas.count)]];
        [_tableView insertRowsAtIndexPaths:changeIndexPathes withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [rowDatas removeObjectsInArray:changeDatas];
        [_tableView deleteRowsAtIndexPaths:changeIndexPathes withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [folderCell.iconLabel hb_playRotateForKey:@"fold.status.change" duration:0.25 rotations:[rowData[@"unfold"] boolValue] ? 0.5 : -0.5 repeat:NO completion:^{
        [folderCell.iconLabel hb_stopAnimationWithKey:@"fold.status.change"];
        folderCell.unfold = [rowData[@"unfold"] boolValue];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.f;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *rowData = [self rowDataAtIndexPath:indexPath];
    
    NSNumber *height = rowData[@"height"]?:_customCellHeights[rowData[@"ri"]];

    if (height) return [height floatValue];

    return  _defaultCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _defaultFooterHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = self.tableView.backgroundColor;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HBTEmptyHeaderView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"empty"];
    header.contentView.backgroundColor = self.tableView.backgroundColor;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataSections.count > 0 && (_isCurrentDeviceLandscape != UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))) {
        _isCurrentDeviceLandscape = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
        for (NSMutableDictionary *dataSection in _dataSections) {
            [self refreshCellHeightsWithDatas:dataSection[@"rowDatas"]];
        }
    }

    return _dataSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self rowDatasAtSection:section].count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rowDatas = [self rowDatasAtSection:indexPath.section];
    NSDictionary *rowData = rowDatas[indexPath.row];
    
    HBTCardItemwCell *cell = [_tableView dequeueReusableCellWithIdentifier:rowData[@"ri"]];
    
    cell.cellDelegate = self;
    cell.data = rowData;
    cell.isLastDataOfSection = (rowData == rowDatas.lastObject);
    
    return cell;
}

#pragma mark - Overrides

- (BOOL)isFoldableCellWithData:(NSDictionary *)data {
    if (@{@"folder":@1,@"group":@1}[data[@"ri"]] != nil) {
        NSAssert(data[@"items"] != nil, @"foldable data should be with *items*");
        return YES;
    }
    return NO;
}

- (void)refreshCellHeightsWithDatas:(NSArray *)datas {
    for (NSMutableDictionary *data in datas) {
        if ([self isFoldableCellWithData:data]) {
            [self refreshCellHeightsWithDatas:data[@"items"]];
        } else {
            NSNumber *height = [self calculateCellHeightWithData:data];
            if (height) data[@"height"] = height;
        }
    }
}

- (NSNumber *)calculateCellHeightWithData:(NSDictionary *)data {
    NSNumber *height = nil;
    if ([data[@"ri"] isEqualToString:@"grid"]) {
        NSArray *items = data[@"items"];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGFloat mw = ceil((MIN(size.height, size.width) - 40 * 2 - 20) / 3);
        
        if (@available(iOS 11.0, *)) {
            size.width -= [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.left;
            size.width -= [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.right;
        }
        NSInteger countPerRow = (size.width - 40*2 + 5) / (mw+5);
        NSInteger rowCount = ceil((double)items.count / countPerRow);
        height = @(rowCount * 91 + 8);
    }

    return height;
}

#pragma mark - Public Operations

- (NSMutableDictionary *)headerAtSection:(NSInteger)section {
    return _dataSections[section][@"header"];
}

- (NSMutableArray *)rowDatasAtSection:(NSInteger)section {
    NSDictionary *ds = _dataSections[section];
    return ds[@"rowDatas"];
}

- (NSMutableDictionary *)rowDataAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowDatasAtSection:indexPath.section][indexPath.row];
}

@end
