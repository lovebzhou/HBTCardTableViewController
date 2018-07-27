//
//  HBTViewController.m
//  HBTCardTableViewController
//
//  Created by lovebzhou on 07/26/2018.
//  Copyright (c) 2018 lovebzhou. All rights reserved.
//

#import "HBTViewController.h"

#import "HBTImageLabelHeaderView.h"
#import "HBTImageLabelTableCell.h"
#import "HBTImageLabelCollectionCell.h"

@interface HBOfficeCenterNotificationCell : HBTCardItemwCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@interface HBTViewController ()

@end

@implementation HBTViewController

- (void)initData {
    NSMutableArray *headers = [@[] mutableCopy];
    NSMutableArray *users = [@[] mutableCopy];
    for (int i = 1; i <= 5; ++i) {
        [headers addObject:@{@"logo":[NSString stringWithFormat:@"hua%d.jpg", i], @"title":[NSString stringWithFormat:@"Section Header Title %d", i]}];
        [users addObject:@{@"ri":@"user",@"avatar":[NSString stringWithFormat:@"%d.jpg", i], @"name":[NSString stringWithFormat:@"User Name %d", i]}];
    }
    
    self.dataSections = [@[] mutableCopy];
    
    // blank header card
    NSMutableArray *rowDatas = [@[] mutableCopy];
    NSMutableDictionary *section = [@{@"header":headers.firstObject,
                                      @"rowDatas":rowDatas} mutableCopy];
    
    [self.dataSections addObject:section];
    NSMutableDictionary *folder = [@{@"ri":@"blank"} mutableCopy];
    [rowDatas addObject:folder];
    NSMutableDictionary *grid = [@{@"ri":@"grid",@"items":users} mutableCopy];
    grid[@"height"] = [self calculateCellHeightWithData:grid];
    [rowDatas addObject:grid];
    
    rowDatas = [@[] mutableCopy];
    section = [@{@"header":headers.lastObject,
                 @"rowDatas":rowDatas} mutableCopy];
    
    [self.dataSections addObject:section];
    
    // card without group
    NSMutableArray *folderItems = [@[] mutableCopy];
    folder = [@{@"ri":@"folder", @"title":@"Folder Title", @"items":folderItems} mutableCopy];
    [rowDatas addObject:folder];
    
    folder[@"unfold"] = @(YES);
    
    grid = [@{@"ri":@"grid",@"items":users} mutableCopy];
    grid[@"height"] = [self calculateCellHeightWithData:grid];
    [folderItems addObject:grid];
    if ([folder[@"unfold"] boolValue]) {
        [rowDatas addObject:grid];
    }
    
    //
    for (NSInteger i = 1; i < 4; ++i) {
        NSDictionary *header = headers[i];
        
        rowDatas = [@[] mutableCopy];
        section = [@{@"header":header,
                     @"rowDatas":rowDatas} mutableCopy];
        
        [self.dataSections addObject:section];
        
        // = folders
        NSMutableArray *folderItems = [@[] mutableCopy];
        NSMutableDictionary *folder = [@{@"ri":@"folder", @"title":@"Folder Title", @"items":folderItems} mutableCopy];
        [rowDatas addObject:folder];
        
        folder[@"unfold"] = @(NO);
        
        // = groups
        
        // grid group demo
        NSMutableArray *groupItems = [@[] mutableCopy];
        NSMutableDictionary *group = [@{@"ri":@"group",  @"title":@"Grid Group Title 1", @"unfold":folder[@"unfold"],@"items":groupItems} mutableCopy];
        [folderItems addObject:group];
        
        if ([folder[@"unfold"] boolValue]) {
            [rowDatas addObject:group];
        }
        NSMutableDictionary *grid = [@{@"ri":@"grid",@"items":users} mutableCopy];
        grid[@"height"] = [self calculateCellHeightWithData:grid];
        [groupItems addObject:grid];
        if ([group[@"unfold"] boolValue]) {
            [rowDatas addObject:grid];
        }
        
        // normal group demo
        group = [@{@"ri":@"group",
                   @"title":@"Normal Group Title 1",
                   @"unfold":folder[@"unfold"],
                   @"items":users} mutableCopy];
        [folderItems addObject:group];
        
        if ([folder[@"unfold"] boolValue]) {
            [rowDatas addObject:group];
        }
        
        if ([group[@"unfold"] boolValue]) {
            [rowDatas addObjectsFromArray:users];
        }
    }
}

- (void)initView {
    [self.tableView registerNib:[UINib nibWithNibName:@"HBTImageLabelTableCell" bundle:nil] forCellReuseIdentifier:@"user"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBTImageLabelHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    self.customCellHeights[@"user"] = @(60);
    self.title = @"HBTCardTableViewController Demo";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initView];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *header = [self headerAtSection:section];
    HBTImageLabelHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.hbImageView.image = [UIImage imageNamed:header[@"logo"]];
    headerView.hbLabel.text = header[@"title"];
    return headerView;
}

#pragma mark - HBTCardItemCellDelegate

- (void)itemCell:(HBTCardItemwCell *)itemCell buttonDidClick:(UIButton *)sender {
    if ([itemCell isKindOfClass:[HBOfficeCenterNotificationCell class]]) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }
}

- (void)containerCellWillInitialize:(HBTCardGridCell *)gridCell {
    if ([gridCell isKindOfClass:[HBTCardGridCell class]]) {
        [gridCell.collectionView registerNib:[UINib nibWithNibName:@"HBTImageLabelCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
}

- (void)containerCell:(HBTCardGridCell *)gridCell itemDidClickAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = gridCell.items[indexPath.row];
    NSLog(@"%@", item);
}

- (UICollectionViewCell *)containerCell:(HBTCardGridCell *)gridCell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = gridCell.items[indexPath.row];
    
    HBTImageLabelCollectionCell *cell = [gridCell.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.avatarImageView.image = [UIImage imageNamed:item[@"avatar"]];
    cell.nameLabel.text = item[@"name"];
    
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

