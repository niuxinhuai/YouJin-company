//
//  HotTopicBannerCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicBannerCell.h"
#import "UIImage+UIColor.h"

@implementation HotTopicBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - configureCell 

- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



#pragma mark - buttonAction

- (IBAction)moreTopicAction:(UIButton *)sender {
    
    
}




#pragma mark - publicMethod

- (void)updateModels:(NSArray *)models {
    if (models != self.models) {
        self.models = models;
        if (models && models.count > 0) {
            BannerModel *model = self.models[0];
            [self.BannerImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F5F5F7" alpha:1] WithAlpha:1]];
        }
        
    }
}



@end
