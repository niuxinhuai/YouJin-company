//
//  HeadLineDetailCommentDatasource.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopCommentCell.h"

typedef void(^TopCommentCellConfiguration)(TopCommentCell *cell, NSIndexPath *indexPath);

@interface HeadLineDetailCommentDatasource : NSObject<UITableViewDataSource>


@property (nonatomic, retain) NSMutableArray<HuifuModel *> *comments;
@property (nonatomic, copy) TopCommentCellConfiguration topCommentCellConfiguration;


@end
