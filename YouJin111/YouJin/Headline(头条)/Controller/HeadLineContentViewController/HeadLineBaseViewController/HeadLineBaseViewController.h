//
//  HeadLineBaseViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeSubViewController.h"
#import "HeadLineContentDatasource.h"

@protocol HeadLineBaseViewControllerDelegate;

@interface HeadLineBaseViewController : BaseSwipeSubViewController<UITableViewDelegate>

@property (nonatomic, retain) HeadLineContentDatasource *datasource;
@property (nonatomic, assign) id<HeadLineBaseViewControllerDelegate> baseDelegate;

@end


@protocol HeadLineBaseViewControllerDelegate <NSObject>

@optional


@end
