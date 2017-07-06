//
//  SystemSafetyCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "SystemSafetyCell.h"
#import "Masonry.h"
#import "SystemSafetyModel.h"
#import "BOLabelHeight.h"
@interface SystemSafetyCell()

/**头像icon*/
@property (nonatomic, weak) UIImageView *iconImageV;
/**公司名称*/
@property (nonatomic, weak) UILabel *nameLabel;
/**评分数*/
@property (nonatomic, weak) UILabel *numberLable;
/**地址*/
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIView *divisionView;
/**公司标签*/
@property (nonatomic, weak) UILabel *marketLabel;
/**公司客户*/
@property (nonatomic, weak) UILabel *Label;
@property (nonatomic, strong) NSMutableArray *imageVArray;
@property (nonatomic, weak) UILabel *maketLabel;

/**主打产品的label*/
@property (nonatomic, weak) UILabel *mainLabel;
@end
@implementation SystemSafetyCell
- (NSMutableArray *)imageVArray {
    if (_imageVArray == nil) {
        _imageVArray = [NSMutableArray array];
    }
    return _imageVArray;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建头像icon
        CGFloat iocnX = 10 * BOWidthRate;
        CGFloat iconY = 12 * BOHeightRate;
        CGFloat iconWH = 60 * BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iocnX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.layer.cornerRadius = 10 * BOWidthRate;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        
        // 创建名称Label
        CGFloat nameX = CGRectGetMaxX(iconImageV.frame) + 15 * BOWidthRate;
        CGFloat nameY = 16 * BOHeightRate;
        CGFloat nameW = 180 * BOWidthRate;
        CGFloat nameH = 16 * BOHeightRate;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        self.nameLabel = nameLabel;
        [self setupLabel:nameLabel font:[UIFont systemFontOfSize:17] textColor:[UIColor colorWithHexString:@"#333333" alpha:1] textAligenment:NSTextAlignmentLeft];
        [self.contentView addSubview:nameLabel];
        
        // 添加第一个星星frame
        CGFloat firstX = nameX;
        CGFloat firstY = CGRectGetMaxY(nameLabel.frame) + 11 * BOScreenH / BOPictureH;
        CGFloat firstWH = 12 * BOScreenW / BOPictureW;
        UIImageView *firstImageV = [[UIImageView alloc] initWithFrame:CGRectMake(firstX, firstY, firstWH, firstWH)];
        [self.imageVArray addObject:firstImageV];
        [self setupImageView:firstImageV];
        [self.contentView addSubview:firstImageV];
        
        // 添加第二个星星frame
        CGFloat secondX = CGRectGetMaxX(firstImageV.frame) + 5 * BOScreenW / BOPictureW;
        CGFloat secondY = firstY;
        CGFloat secondWH = firstWH;
        UIImageView *secondImageV = [[UIImageView alloc] initWithFrame:CGRectMake(secondX, secondY, secondWH, secondWH)];
        [self.imageVArray addObject:secondImageV];
        [self setupImageView:secondImageV];
        [self.contentView addSubview:secondImageV];
        
        // 添加第三个星星的frame
        CGFloat thirdX = CGRectGetMaxX(secondImageV.frame) + 5 * BOScreenW / BOPictureW;
        CGFloat thirdY = firstY;
        CGFloat thirdWH = firstWH;
        UIImageView *thirdImageV = [[UIImageView alloc] initWithFrame:CGRectMake(thirdX, thirdY, thirdWH, thirdWH)];
        [self.imageVArray addObject:thirdImageV];
        [self setupImageView:thirdImageV];
        [self.contentView addSubview:thirdImageV];
        // 添加第四个星星的frame
        CGFloat fourthX = CGRectGetMaxX(thirdImageV.frame) + 5 * BOScreenW / BOPictureW;
        CGFloat fourthY = firstY;
        CGFloat fourthWH = firstWH;
        UIImageView *fourthImageV = [[UIImageView alloc] initWithFrame:CGRectMake(fourthX, fourthY, fourthWH, fourthWH)];
        [self.imageVArray addObject:fourthImageV];
        [self setupImageView:fourthImageV];
        [self.contentView addSubview:fourthImageV];
        
        // 添加第五个星星的frame
        CGFloat fiveX = CGRectGetMaxX(fourthImageV.frame) + 5 * BOScreenW / BOPictureW;
        CGFloat fiveY = firstY;
        CGFloat fiveWH = firstWH;
        UIImageView *fiveImageV = [[UIImageView alloc] initWithFrame:CGRectMake(fiveX, fiveY, fiveWH, fiveWH)];
        [self.imageVArray addObject:fiveImageV];
        [self setupImageView:fiveImageV];
        [self.contentView addSubview:fiveImageV];
        
        // 添加评分的label
        CGFloat numberX = CGRectGetMaxX(fiveImageV.frame) + 5 * BOScreenW / BOPictureW;
        CGFloat numberY = fiveY;
        CGFloat numberW = 30 * BOWidthRate;
        CGFloat numberH = 12 * BOHeightRate;
        UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
        self.numberLable = numberLable;
        numberLable.text = @"0.0";
        numberLable.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
        [numberLable setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:numberLable];
        
        // 创建主打产品的label
        CGFloat mainX = firstX;
        CGFloat mainY = 62 * BOHeightRate;
        CGFloat mainW = 140 * BOWidthRate;
        CGFloat mainH = 13 * BOHeightRate;
        UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainX, mainY, mainW, mainH)];
        self.mainLabel = mainLabel;
        mainLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [mainLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:mainLabel];
        // 创建地点的label
        UILabel *locationLabel = [[UILabel alloc] init];
        [self setupLabel:locationLabel font:[UIFont systemFontOfSize:11] textColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] textAligenment:NSTextAlignmentRight];
        [self.contentView addSubview:locationLabel];
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(20 * BOHeightRate);
            make.right.equalTo(self.contentView.mas_right).offset(-10 * BOWidthRate);
            make.height.equalTo(@(12 * BOHeightRate));
            make.width.equalTo(@(100 * BOWidthRate));
        }];
        self.locationLabel = locationLabel;
        
        // 创建新三板上市的label
        UILabel *maketLabel = [[UILabel alloc] initWithFrame:CGRectMake(305 * BOWidthRate, 46 * BOHeightRate, 60 * BOHeightRate, 13 * BOHeightRate)];
        maketLabel.backgroundColor = [UIColor colorWithHexString:@"#5EC7C6" alpha:1];
        self.maketLabel = maketLabel;
        maketLabel.text = @"新三板上市";
        [self setupLabel:maketLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor whiteColor] textAligenment:NSTextAlignmentCenter];
        [self.contentView addSubview:maketLabel];
        // 创建分割线
        UIView *divisionView = [[UIView alloc] init];
        divisionView.backgroundColor = [UIColor colorWithHexString:@"#E9EDF0" alpha:1];
        [self.contentView addSubview:divisionView];
        [divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(83 * BOHeightRate);
            make.right.equalTo(self.contentView.mas_right).offset(-10 * BOWidthRate);
            make.left.equalTo(self.contentView.mas_left).offset(85 * BOWidthRate);
            make.height.equalTo(@(1));
        }];
        self.divisionView = divisionView;
        // 创建新lable
        UILabel *Label = [[UILabel alloc] init];
        [self.contentView addSubview:Label];
        [Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(85 * BOWidthRate);
            make.right.equalTo(self.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(divisionView.mas_bottom).offset(10 * BOHeightRate);
            make.height.equalTo(@(13 * BOHeightRate));
        }];
        [self setupLabel:Label font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"#737373" alpha:1] textAligenment:NSTextAlignmentLeft];
        self.Label = Label;
        
        // 添加底部的分割View
        UIView *cutView = [[UIView alloc] initWithFrame:CGRectMake(0, 116 * BOHeightRate, BOScreenW, 8 * BOHeightRate)];
        cutView.backgroundColor = BOColor(238, 239, 239);
        [self.contentView addSubview:cutView];
        // 设置选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
#pragma mark - 设置label的字体大小和字体颜色
- (void)setupLabel:(UILabel *)label font:(UIFont *)font textColor:(UIColor *)textColor textAligenment:(NSInteger)textAligenment{
    [label setFont:font];
    label.textColor = textColor;
    label.textAlignment = textAligenment;
}
#pragma mark - 设置imageView的正常和高亮的图片
- (void)setupImageView:(UIImageView *)imageView {
    [imageView setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [imageView setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
}

- (void)setItem:(SystemSafetyModel *)item {
    _item = item;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
    self.nameLabel.text = item.pname;
    for (int i = 0; i < (int)([item.score floatValue] + 0.5); i++) {
        UIImageView *imageView = self.imageVArray[i];
        imageView.highlighted = YES;
    }
    self.numberLable.text = [NSString stringWithFormat:@"%d.0",(int)([item.score floatValue] + 0.5)];
    self.locationLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng, item.shi];
    if (item.tab.length > 0) {
        self.maketLabel.hidden = NO;
        self.maketLabel.width = [BOLabelHeight LabelWidth:item.tab dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil]] * BOWidthRate + 10 * BOWidthRate;
        self.maketLabel.text = item.tab;
        self.maketLabel.x = BOScreenW - self.maketLabel.width - 10 * BOWidthRate;
    }else {
        self.maketLabel.hidden = YES;
        self.maketLabel.width = 0;
    }

    self.Label.text = [NSString stringWithFormat:@"典型客户: %@",item.example];
    
    self.mainLabel.text = [NSString stringWithFormat:@"主打产品:%@",item.pro_name];
}
@end
