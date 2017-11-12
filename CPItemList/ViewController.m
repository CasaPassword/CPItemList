//
//  ViewController.m
//  CPItemList
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "ViewController.h"
#import "CPItemListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CPItemListViewController *viewController = [[CPItemListViewController alloc] init];
    viewController.groupId = 0;
    [self.navigationController pushViewController:viewController animated:animated];
}


@end
