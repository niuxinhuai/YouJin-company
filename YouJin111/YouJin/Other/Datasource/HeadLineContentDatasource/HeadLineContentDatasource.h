//
//  HeadLineContentDatasource.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeadLineTextCell.h"
#import "HeadLineMediaCell.h"
#import "HeadLineOneImageCell.h"
#import "HeadLineThreeImageCell.h"

typedef void(^BaseHeadLineCellConfiguration)(BaseHeadLineCell *cell, NSIndexPath *indexPath);
typedef void(^HeadLineMediaCellConfiguration)(HeadLineMediaCell *cell, NSIndexPath *indexPath);


@interface HeadLineContentDatasource : NSObject<UITableViewDataSource>


@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, retain) NSMutableArray *advertisements;
@property (nonatomic, retain) NSMutableArray *mixtureDatas;

@property (nonatomic, retain) NSArray *templates;
@property (nonatomic, assign) NSInteger adMaxCount;

@property (nonatomic, copy) HeadLineMediaCellConfiguration headLineMediaCellConfiguration;
@property (nonatomic, copy) BaseHeadLineCellConfiguration baseHeadLineCellConfiguration;




- (void)updateMixtureDatas;




@end
