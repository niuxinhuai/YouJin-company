//
//  HotTopicBannerCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

@interface HotTopicBannerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *BannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotTopicLabel;



@property (nonatomic, retain) NSArray *models;




- (void)updateModels:(NSArray *)models;



@end
