//
//  CPItemListViewController.m
//  CPItemList
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CPItemListViewController.h"
#import "CPItemListDataSource.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface CPItemListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) CPItemListDataSource *dataSource;

@end

@implementation CPItemListViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTappedAddButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.view addSubview:self.tableview];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableview fill];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *itemInfo = [self.dataSource itemInfoAtIndexPath:indexPath];
    cell.textLabel.text = itemInfo[@"title"];
    cell.detailTextLabel.text = itemInfo[@"content"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *itemInfo = [self.dataSource itemInfoAtIndexPath:indexPath];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:itemInfo[@"title"] message:itemInfo[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:closeAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - event response
- (void)didTappedAddButton:(UIBarButtonItem *)addButton
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Item" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"content";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        NSString *title = [alertController.textFields firstObject].text;
        NSString *content = [alertController.textFields lastObject].text;
        [self.dataSource addItemTitle:title content:content groupID:self.groupId];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - getters and setters
- (CPItemListDataSource *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[CPItemListDataSource alloc] init];
        _dataSource.groupId = self.groupId;
    }
    return _dataSource;
}

- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self.dataSource;
        [_tableview registerClass:self.dataSource.cellClass forCellReuseIdentifier:self.dataSource.cellIdentifier];
    }
    return _tableview;
}

- (NSString *)title
{
    return self.groupName;
}

@end
