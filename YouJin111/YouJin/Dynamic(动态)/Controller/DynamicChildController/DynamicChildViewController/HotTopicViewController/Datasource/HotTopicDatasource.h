//
//  HotTopicDatasource.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotTopicBannerCell.h"
#import "HotCommentModle.h"
#import "HotCommentCell.h"

typedef void(^ConfigureHotTopicBannerCell)(HotTopicBannerCell *cell, NSIndexPath *indexPath);
typedef void(^ConfigureHotCommentCell)(HotCommentCell *cell, NSIndexPath *indexPath);


@interface HotTopicDatasource : NSObject<UITableViewDataSource>


@property (nonatomic, retain) NSArray *bannerModels;
@property (nonatomic, retain) NSArray *commentModles;
@property (nonatomic, retain) NSArray *dynamicModels;

@property (nonatomic, copy) ConfigureHotTopicBannerCell configureHotTopicBannerCell;
@property (nonatomic, copy) ConfigureHotCommentCell configureHotCommentCell;




@end
