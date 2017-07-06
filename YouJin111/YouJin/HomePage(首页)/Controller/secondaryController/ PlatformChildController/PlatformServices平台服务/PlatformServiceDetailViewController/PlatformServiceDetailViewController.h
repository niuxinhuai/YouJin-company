//
//  PlatformServiceDetailViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "PlatformServiceDetailModel.h"

@class PlatformServiceDetailHeadView;
@class PlateformServiceDetailSectionHeadView;

@interface PlatformServiceDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *topBlueContainer;
@property (weak, nonatomic) IBOutlet UIView *topClearContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (nonatomic, strong) UIView *writeCommentContainer;
@property (nonatomic, strong) PlatformServiceDetailHeadView *platformHeadView;
@property (nonatomic, strong) PlateformServiceDetailSectionHeadView *sectionHeadView;
@property (nonatomic, strong) UIView *sectionFootView;
@property (nonatomic, strong) UIView *noCommentFootView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) PlatformServiceDetailModel *seviceDetail;
@property (nonatomic, strong) NSNumber *svid;
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, assign) CGFloat preContentOffsetY;
@property (nonatomic, strong) NSNumber *commentCount;

+ (instancetype)createWithSvid:(NSNumber *)svid;



@end
