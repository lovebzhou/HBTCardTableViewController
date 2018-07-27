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
        [headers addObject:@{@"logo":[NSString stringWithFormat:@"hua%d.jpg", i], @"title":@"外部可展开收起，内部有分组"}];
        [users addObject:@{@"ri":@"user",@"avatar":[NSString stringWithFormat:@"%d.jpg", i], @"name":[NSString stringWithFormat:@"User Name %d", i]}];
    }
    
    self.dataSections = [@[] mutableCopy];
    
    // blank header card
    NSMutableArray *rowDatas = [@[] mutableCopy];
    NSMutableDictionary *section = [@{@"header":@{@"logo":@"hua1.jpg", @"title":@"外部无展开收起，内部无分组"},
                                      @"rowDatas":rowDatas} mutableCopy];
    {
        [self.dataSections addObject:section];
        NSMutableDictionary *folder = [@{@"ri":@"blank"} mutableCopy];
        [rowDatas addObject:folder];
        NSMutableDictionary *grid = [@{@"ri":@"grid",@"items":users} mutableCopy];
        grid[@"height"] = [self calculateCellHeightWithData:grid];
        [rowDatas addObject:grid];
    }
    
    {
        rowDatas = [@[] mutableCopy];
        section = [@{@"header":@{@"logo":@"hua2.jpg", @"title":@"外部可展开收起，内部无分组"},
                     @"rowDatas":rowDatas} mutableCopy];
        
        [self.dataSections addObject:section];
        
        NSArray *items = [users subarrayWithRange:NSMakeRange(0, 3)];
        NSMutableDictionary *folder = [@{@"ri":@"folder",@"unfold":@1, @"title":@"卡片标题", @"items":items} mutableCopy];
        [rowDatas addObject:folder];
        
        if ([folder[@"unfold"] boolValue]) {
            [rowDatas addObjectsFromArray:items];
        }
    }
    
    // ...
    for (NSInteger i = 3; i < 5; ++i) {
        NSDictionary *header = headers[i];
        
        rowDatas = [@[] mutableCopy];
        section = [@{@"header":header,
                     @"rowDatas":rowDatas} mutableCopy];
        
        [self.dataSections addObject:section];
        
        // = folders
        NSMutableArray *folderItems = [@[] mutableCopy];
        NSMutableDictionary *folder = [@{@"ri":@"folder", @"title":@"可展开收起卡片", @"items":folderItems} mutableCopy];
        [rowDatas addObject:folder];
        
        folder[@"unfold"] = @(i == 2);
        
        // = groups
        
        // grid group demo
        NSMutableArray *groupItems = [@[] mutableCopy];
        NSMutableDictionary *group = [@{@"ri":@"group",  @"title":@"内部分组标题", @"unfold":folder[@"unfold"],@"items":groupItems} mutableCopy];
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
        
        NSArray *items = [users subarrayWithRange:NSMakeRange(2, 2)];
        // normal group demo
        group = [@{@"ri":@"group",
                   @"title":@"普通内部分组标题",
                   @"unfold":folder[@"unfold"],
                   @"items":items} mutableCopy];
        [folderItems addObject:group];
        
        if ([folder[@"unfold"] boolValue]) {
            [rowDatas addObject:group];
        }
        
        if ([group[@"unfold"] boolValue]) {
            [rowDatas addObjectsFromArray:items];
        }
    }
}

- (void)initView {
    [self.tableView registerNib:[UINib nibWithNibName:@"HBTImageLabelTableCell" bundle:nil] forCellReuseIdentifier:@"user"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBTImageLabelHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    self.customCellHeights[@"user"] = @(60);
    self.title = @"Card TableView Demo";
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
    if ([self headerAtSection:section]) return 55.f;
    
    return [super tableView:tableView heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *header = [self headerAtSection:section];
    if (header) {
        HBTImageLabelHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.hbImageView.image = [UIImage imageNamed:header[@"logo"]];
        headerView.hbLabel.text = header[@"title"];
        return headerView;
        
    }
    
    return [super tableView:tableView viewForHeaderInSection:section];
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

