//
//  Target_CPItemList.m
//  CPItemList
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "Target_CPItemList.h"
#import <CPCategories/NSObject+Navigation.h>
#import "CPItemListViewController.h"

@implementation Target_CPItemList

- (void)Action_presentItemList:(NSDictionary *)params
{
    NSInteger groupId = [params[@"groupID"] integerValue];
    CPItemListViewController *viewController = [[CPItemListViewController alloc] init];
    viewController.groupId = groupId;
    viewController.groupName = params[@"groupName"];
    [self cp_pushViewController:viewController animated:YES];
}

@end
