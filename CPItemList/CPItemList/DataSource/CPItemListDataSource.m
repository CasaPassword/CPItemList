//
//  CPItemListDataSource.m
//  CPItemList
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CPItemListDataSource.h"
#import <CPDataCenter/CPDataCenter.h>

@interface CPItemListDataSource ()

@property (nonatomic, strong) CPDataCenter *dataCenter;
@property (nonatomic, weak) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *itemList;

@end

@implementation CPItemListDataSource

#pragma mark - public methods
- (NSDictionary *)itemInfoAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemList[indexPath.row];
}

- (void)addItemTitle:(NSString *)title content:(NSString *)content groupID:(NSInteger)groupID
{
    NSDictionary *newItem = [self.dataCenter addItemWithTitle:title content:content groupID:groupID];
    [self.itemList addObject:newItem];
    [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.itemList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableview = tableView;
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableview = tableView;
    return [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *itemInfo = self.itemList[indexPath.row];
        [self.dataCenter deleteItemWithItemID:[itemInfo[@"primaryKey"] integerValue]];
        
        [self.itemList removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    return YES;
}

#pragma mark - getters and setters
- (CPDataCenter *)dataCenter
{
    if (_dataCenter == nil) {
        _dataCenter = [[CPDataCenter alloc] init];
    }
    return _dataCenter;
}

- (NSMutableArray *)itemList
{
    if (_itemList == nil) {
        _itemList = [[self.dataCenter itemListWithGroupID:self.groupId] mutableCopy];
    }
    return _itemList;
}

- (NSString *)cellIdentifier
{
    return @"cell";
}

- (Class)cellClass
{
    return [UITableViewCell class];
}


@end
