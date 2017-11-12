//
//  CPItemListDataSource.h
//  CPItemList
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPItemListDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, readonly) NSString *cellIdentifier;
@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, assign) NSInteger groupId;

- (NSDictionary *)itemInfoAtIndexPath:(NSIndexPath *)indexPath;
- (void)addItemTitle:(NSString *)title content:(NSString *)content groupID:(NSInteger)groupID;

@end
