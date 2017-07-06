//
//  CollectionCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


#pragma mark - publicMethod

- (void)updateContent:(TopContentModel *)content {
    self.content = content;
    self.contentLabel.text = content.title;
    self.nameLabel.text = content.uname;
    self.timeLabel.text = content.time_h;
    
    if (content.cover && content.cover.count > 0) {
        NSDictionary *dic = content.cover[0];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"cover"]] placeholderImage:[UIImage placeholderImage] options:SDWebImageCacheMemoryOnly];
    }
}


@end
