//
//  CommentListViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeSubViewController.h"

@interface CommentListViewController : BaseSwipeSubViewController



@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger uid;

+ (instancetype)create;

@end
