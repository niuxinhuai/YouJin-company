//
//  PlatformServiceDetailViewController+Delegate.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController.h"
#import "PlatformServiceDetailHeadView.h"
#import "UserCommentCell.h"
#import "PlatformServiceDetailHeadView.h"

@interface PlatformServiceDetailViewController (Delegate)<UITableViewDelegate, UITableViewDataSource,UserCommentCellDelegate,PlatformServiceDetailHeadViewDelegate>

@end
