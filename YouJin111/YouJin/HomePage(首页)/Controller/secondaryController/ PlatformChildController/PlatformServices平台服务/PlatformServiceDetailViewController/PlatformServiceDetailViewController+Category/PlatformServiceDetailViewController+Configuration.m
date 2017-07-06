//
//  PlatformServiceDetailViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController+Configuration.h"
#import "UserCommentsOnViewController.h"
#import "WriteCommentsOnViewController.h"

@implementation PlatformServiceDetailViewController (Configuration)


- (void)configureViews {
    [self configureHeadView];
    [self configureFootView];
    [self configureSectionHeadView];
    [self configureTableView];
    [self configureWriteCommentContainer];
}

- (void)configureHeadView {
    self.platformHeadView = [PlatformServiceDetailHeadView create];
    self.platformHeadView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 744);
    self.platformHeadView.delegate = self;
    self.tableView.tableHeaderView = self.platformHeadView;
}

- (void)configureFootView {
    self.sectionFootView = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看更多评论" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithIntRed:153 green:153 blue:153 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.frame = CGRectMake(0, 0, [UIScreen screenWidth], 40);
        [button addTarget:self action:@selector(moreCommentAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    
    self.noCommentFootView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 100)];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentsButton setTitle:@" 上传第1条点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_dianping_dark"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [commentsButton makeCornerBorderWithWidth:1 cornerRadius:4 borderColor:[UIColor colorWithIntRed:51 green:51 blue:51 alpha:1]];
    [commentsButton addTarget:self action:@selector(moreCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.noCommentFootView addSubview:commentsButton];
    
    [commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.noCommentFootView);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(@140);
    }];
    
}

- (void)configureSectionHeadView {
    self.sectionHeadView = ({
        PlateformServiceDetailSectionHeadView *view = [[PlateformServiceDetailSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 45)];
        view;
    });
}

- (void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserCommentCell class])];
}


- (void)configureWriteCommentContainer {
    self.writeCommentContainer = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen screenHeight] - 49, [UIScreen screenWidth], 49)];
        [self.view addSubview:view];
        view;
    });
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    effectView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 49);
    effectView.alpha = 0.97;
    [self.writeCommentContainer addSubview:effectView];
    
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake(0, 0, [UIScreen screenWidth], 49);
    [commentsButton setTitle:@"写点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_xdp"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#2380f4" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [commentsButton addTarget:self action:@selector(writeCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.writeCommentContainer addSubview:commentsButton];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 1)];
    lineView.backgroundColor = [UIColor colorWithIntRed:223 green:227 blue:230 alpha:1];
    [self.writeCommentContainer addSubview:lineView];
}


- (void)moreCommentAction:(UIButton *)sender {
    if ([self.commentCount integerValue] == 0) {
        [self writeCommentAction:nil];
        return;
    }
    UserCommentsOnViewController *userVc = [[UserCommentsOnViewController alloc]init];
    userVc.hidesBottomBarWhenPushed = YES;
    userVc.ptidString = self.seviceDetail.svid;
    userVc.numberString = [self.commentCount stringValue];
    userVc.namestring = self.seviceDetail.pname;
    [self.navigationController pushViewController:userVc animated:YES];
}

- (void)writeCommentAction:(UIButton *)sender {
    if (USERUID) {
        [self pushToWriteCommentsOnViewController];
    } else {
        [self pushToLoginViewController];
    }
}

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)pasteText:(NSString *)text {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:text];
    if (pab == nil) {
        [self toast:@"复制失败" complete:nil];
    }else {
        [self toast:@"已复制" complete:nil];
    }
}


- (void)pushToWriteCommentsOnViewController {
    WriteCommentsOnViewController *wriVc = [[WriteCommentsOnViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    wriVc.callBackBlock = ^(NSString *text){
        [self toast:text complete:nil];
        [weakSelf requireForPlatSeviceDetailWithSvid:self.svid];
        [weakSelf requireForPlatSeviceDetailCommentList];
    };
    wriVc.nameString = self.seviceDetail.pname;
    wriVc.ptidStr = self.seviceDetail.svid;
    wriVc.type = @9;
    [self.navigationController pushViewController:wriVc animated:YES];
}



@end
