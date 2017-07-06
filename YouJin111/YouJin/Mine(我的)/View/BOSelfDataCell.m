//
//  BOSelfDataCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSelfDataCell.h"
#import <Masonry.h>

@implementation BOSelfDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加titleLabel
        CGFloat titleX = 15;
        CGFloat titleY = 15;
        CGFloat titleW = 150;
        CGFloat titleH = 15;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        [self.contentView addSubview:titleLabel];
        
        // 添加subtitleView
        CGFloat subTitleX = BOScreenW - 135;
        CGFloat subTitleY = titleY;
        CGFloat subTitleW = 105;
        CGFloat subTitleH = titleH;
        UILabel *subTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLable;
        [subTitleLable setFont:[UIFont systemFontOfSize:12]];
        subTitleLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        subTitleLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:subTitleLable];
        
        [self configureCell];
    }
    return self;
}

#pragma mark - configureViews

- (void)configureCell {
    [self addImgView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)addImgView {
    self.imgView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        imageView;
    });
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(self.imgView.mas_height);
        make.right.equalTo(self).offset(-30);
        make.width.equalTo(@29);
    }];
    
    [self.imgView makeCornerWithCornerRadius:29/2.0];
    self.imgView.clipsToBounds = YES;
}

#pragma mark - publicMethod
- (void)imageViewHidden:(BOOL)hidden {
    self.imgView.hidden = hidden;
    self.subTitleLabel.hidden = !hidden;
}


- (void)updateMineItem:(SelfDataItem *)item indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.item = item;
    [self imageViewHidden:YES];
    switch (indexPath.row) {
        case 0:
            [self updateMessageWhenFirstRowWithItem:item];
            break;
        case 1:
            [self updateMessageWhenSecondRowWithItem:item];
            break;
        case 2:
            [self updateMessageWhenThirdRowWithItem:item];
            break;
        case 3:
            [self updateMessageWhenFourthRowWithItem:item];
            break;
        case 4:
            [self updateMessageWhenFifthRowWithItem:item];
            break;
        default:
            break;
    }
}

#pragma mark - helpMethod

- (void)updateMessageWhenFirstRowWithItem:(SelfDataItem *)item {
    self.titleLabel.text = @"头像";
    [self imageViewHidden:NO];
    if (item.headImage) {
        self.imgView.image = item.headImage;
    }else {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.head_image]];
    }
}

- (void)updateMessageWhenSecondRowWithItem:(SelfDataItem *)item {
    self.titleLabel.text = @"昵称";
    self.subTitleLabel.text = item.uname;
}


- (void)updateMessageWhenThirdRowWithItem:(SelfDataItem *)item {
    self.titleLabel.text = @"性别";
    self.subTitleLabel.text = [item.sex intValue] == 0 ? @"男" : @"女";
    
}

- (void)updateMessageWhenFourthRowWithItem:(SelfDataItem *)item {
    self.titleLabel.text = @"投资类型";
    self.subTitleLabel.text = item.type.length > 0 ? item.type : @"去评估";
}

- (void)updateMessageWhenFifthRowWithItem:(SelfDataItem *)item {
    self.titleLabel.text = @"收货地址";
    self.subTitleLabel.text = item.address;
}


@end
