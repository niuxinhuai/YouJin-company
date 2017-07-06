//
//  PlatformActivityCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

//
//  PlatformActivityCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformActivityCell.h"
#import "PlatformActivityModel.h"
@interface PlatformActivityCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UIView *platfromActView;
@property (weak, nonatomic) IBOutlet UILabel *actLabel;

@end
@implementation PlatformActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _platfromActView.layer.borderWidth = 1;
    _platfromActView.layer.borderColor = BOColor(235, 236, 237).CGColor;
    _platfromActView.layer.cornerRadius = 8;
    _platfromActView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setItem:(PlatformActivityModel *)item {
    _item = item;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.img_url] placeholderImage:perchImage];
    self.actLabel.text = item.desc;
}

@end
