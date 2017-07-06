//
//  BaseTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/5.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(void)prepareForReuse {
    [super prepareForReuse];
    [self hiddenLineView:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureBaseCell];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureBaseCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - configureViews

- (void)configureBaseCell {
    [self addLineView];
}

- (void)addLineView {
    self.lineView = ({
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor placeholderColor];
        [self.contentView addSubview:lineView];
        lineView;
    });
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(@1);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - publicMethod

- (void)hiddenLineView:(BOOL)hidden {
    self.lineView.hidden = hidden;
}



@end
