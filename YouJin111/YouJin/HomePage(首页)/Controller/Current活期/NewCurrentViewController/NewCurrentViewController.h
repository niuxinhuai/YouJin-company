//
//  NewCurrentViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController.h"

@interface NewCurrentViewController : BaseSwipeViewController


@property (nonatomic, retain) NSArray *barTitles;
@property (nonatomic, retain) NSArray *bannerDatas;
@property (weak, nonatomic) IBOutlet UIButton *redPacketButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redPacketCenterXToSuperRight;


@end
