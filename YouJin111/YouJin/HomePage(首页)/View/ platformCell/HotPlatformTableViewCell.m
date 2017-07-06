//
//  HotPlatformTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/17.
//  Copyright © 2017年 youjin. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "HotPlatformTableViewCell.h"
#import "Masonry.h"
#import "BOLabelHeight.h"
#import "PeerHonePageModel.h"
#import "BackgroundModel.h"
#import "PlatformHuodongItem.h"
//#import "BackgroundModel.h"
@interface HotPlatformTableViewCell()
@property (nonatomic, weak) UIImageView *iconImageV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *numberLable;
@property (nonatomic, weak) UILabel *earnNumberLabel;
@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) UILabel *secondLabel;
@property (nonatomic, weak) UILabel *thirdLabel;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIView *divisionView;
@property (nonatomic, weak) UILabel *activityLabel;

/**最新的按钮*/
@property (nonatomic, weak) UILabel *bestLabel;
@property (nonatomic, strong) NSMutableArray *imageVArray;

/**业务类型的数组*/
@property (nonatomic, strong) NSArray *businessArray;

/**背景的数组*/
@property (nonatomic, strong) NSArray *backArray;

@property (nonatomic, strong) UIView *grayView;

/**记录当前的X值*/
@property (nonatomic, assign) CGFloat flagX;

/**记录当前的Y值*/
@property (nonatomic, assign) CGFloat flagY;
@end
@implementation HotPlatformTableViewCell
#pragma mark - 懒加载底部的grayView
- (UIView *)grayView {
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = BOColor(244, 245, 247);
    }
    return _grayView;
}
- (NSMutableArray *)imageVArray {
    if (_imageVArray == nil) {
        _imageVArray = [NSMutableArray array];
    }
    return _imageVArray;
}
- (NSArray *)businessArray {
    if (_businessArray == nil) {
        _businessArray = [NSArray arrayWithObjects:@"",@"车贷",@"消费分期",@"供应链金融",@"房贷",@"企业贷",@"优选理财",@"票据抵押",@"融资租赁",@"藏品质押",@"个人信用贷", nil];
    }
    return _businessArray;
}
- (NSArray *)backArray {
    if (_backArray == nil) {
        _backArray = [NSArray arrayWithObjects:@"银行",@"上市",@"国资",@"风投",@"民营", nil];
    }
    return _backArray;
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
        CGFloat nameW = 120 * BOWidthRate;
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
        CGFloat numberW = 60 * BOWidthRate;
        CGFloat numberH = 12 * BOHeightRate;
        UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
        self.numberLable = numberLable;
        numberLable.text = @"0.0";
        numberLable.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
        [numberLable setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:numberLable];
        
        // 创建年化收益的label
        CGFloat earningsX = nameX;
        CGFloat earningsY = CGRectGetMaxY(firstImageV.frame) + 14 * BOHeightRate;
        CGFloat earningsW = 55 * BOWidthRate;
        CGFloat earningsH = 15 * BOHeightRate;
        UILabel *earningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(earningsX, earningsY, earningsW, earningsH)];
        earningsLabel.text = @"年化收益";
        [self setupLabel:earningsLabel font:[UIFont systemFontOfSize:13] textColor:[UIColor colorWithHexString:@"#737373" alpha:1] textAligenment:NSTextAlignmentLeft];
        [self.contentView addSubview:earningsLabel];
        
        // 创建显示收益的label
        CGFloat earnNumX = CGRectGetMaxX(earningsLabel.frame) + 6 * BOWidthRate;
        CGFloat earnNumY = earningsY;
        CGFloat earnNumW = 100 * BOWidthRate;
        CGFloat earnNumH = 15 * BOHeightRate;
        UILabel *earnNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(earnNumX, earnNumY, earnNumW, earnNumH)];
        self.earnNumberLabel = earnNumberLabel;
        [self setupLabel:earnNumberLabel font:[UIFont fontWithName:@"Helvetica-Bold" size:13] textColor:[UIColor colorWithHexString:@"#FF5A00" alpha:1] textAligenment:NSTextAlignmentLeft];
        [self.contentView addSubview:earnNumberLabel];
        __weak __typeof(self) weakSelf = self;
        // 创建最右边的label
        UILabel *firstLabel = [[UILabel alloc] init];
        firstLabel.backgroundColor = [UIColor colorWithHexString:@"#3BB5F4" alpha:1];
        firstLabel.layer.cornerRadius = 2;
        firstLabel.layer.masksToBounds = YES;
        [self setupLabel:firstLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor whiteColor] textAligenment:NSTextAlignmentCenter];
        [self.contentView addSubview:firstLabel];
        self.firstLabel = firstLabel;
        
        // 创建中间的label
        UILabel *secondLabel = [[UILabel alloc] init];
        secondLabel.layer.cornerRadius = 2;
        secondLabel.layer.masksToBounds = YES;
        secondLabel.layer.borderWidth = 1;
        secondLabel.layer.borderColor = [UIColor colorWithHexString:@"#3BB5F4" alpha:1].CGColor;
        [self.contentView addSubview:secondLabel];
        [self setupLabel:secondLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor colorWithHexString:@"#3BB5F4" alpha:1] textAligenment:NSTextAlignmentCenter];
        self.secondLabel = secondLabel;
        // 创建最左边的lable
        UILabel *thirdLabel= [[UILabel alloc] init];
        thirdLabel.layer.cornerRadius = 2;
        thirdLabel.layer.masksToBounds = YES;
        thirdLabel.layer.borderWidth = 1;
        thirdLabel.layer.borderColor = [UIColor colorWithHexString:@"#3BB5F4" alpha:1].CGColor;
        [self.contentView addSubview:thirdLabel];
        self.thirdLabel =thirdLabel;
        [self setupLabel:thirdLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor colorWithHexString:@"#3BB5F4" alpha:1] textAligenment:NSTextAlignmentCenter];
        
        // 创建地点的label
        UILabel *locationLabel = [[UILabel alloc] init];
        [self setupLabel:locationLabel font:[UIFont systemFontOfSize:11] textColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] textAligenment:NSTextAlignmentRight];
        
        [self.contentView addSubview:locationLabel];
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(46 * BOHeightRate);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10 * BOWidthRate);
            make.height.equalTo(@(12 * BOHeightRate));
            make.width.equalTo(@(100 * BOWidthRate));
        }];
        self.locationLabel = locationLabel;
        
        // 创建分割线
        UIView *divisionView = [[UIView alloc] init];
        divisionView.backgroundColor = [UIColor colorWithHexString:@"#E9EDF0" alpha:1];
        [self.contentView addSubview:divisionView];
        [divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(95 * BOHeightRate);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10 * BOWidthRate);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(85 * BOWidthRate);
            make.height.equalTo(@(1));
        }];
        self.divisionView = divisionView;
        // 创建新label
        UILabel *bestLabel = [[UILabel alloc] init];
        [self.contentView addSubview:bestLabel];
        [bestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(85 * BOWidthRate);
            make.right.equalTo(self.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(divisionView.mas_bottom).offset(10 * BOHeightRate);
            make.height.equalTo(@(13 * BOHeightRate));
        }];
        self.bestLabel = bestLabel;
        // 创建活动label
        UILabel *activityLabel = [[UILabel alloc] init];
        [self.contentView addSubview:activityLabel];
        [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(85 * BOWidthRate);
            make.right.equalTo(self.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(bestLabel.mas_bottom).offset(5);
            make.height.equalTo(@(13 * BOHeightRate));
        }];
        self.activityLabel = activityLabel;
        
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

- (void)setItem:(PeerHonePageModel *)item {
    _item = item;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
    self.nameLabel.text = item.name;
    // 根据评分给设置星星高亮
    for (NSInteger i = 0; i < (int)([item.score floatValue] + 0.5) / 1; i++) {
        UIImageView *imageV = self.imageVArray[i];
        imageV.highlighted = YES;
    }
    self.numberLable.text = [NSString stringWithFormat:@"%@分",item.score];
    self.earnNumberLabel.text = [NSString stringWithFormat:@"%@~%@%%",item.apr_min,item.apr_max];
    // 给flagX赋初值
    self.flagX = 10;

    if ([item.cgid intValue]) {
        self.firstLabel.frame = CGRectMake(BOScreenW - 45 * BOWidthRate, 19 * BOHeightRate, 35 * BOWidthRate, 17.5 * BOHeightRate);
        self.flagX = 45;
        self.firstLabel.text = @"存管";
        [self.contentView layoutIfNeeded];

        if (item.bg_array.count != 0) {
            BackgroundModel *backItem = item.bg_array[0];
            // 动态算出label的宽度
            CGFloat backwidth = [BOLabelHeight LabelWidth:backItem.name dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            self.secondLabel.frame = CGRectMake(BOScreenW - (self.flagX + backwidth + 10) * BOWidthRate, 19 * BOHeightRate, (backwidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
            self.flagX += (backwidth + 10);
            self.secondLabel.text = backItem.name;
            [self.contentView layoutIfNeeded];
            int flag = [item.bus_model intValue];
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            self.thirdLabel.frame = CGRectMake(BOScreenW - (self.flagX + 15 + modelWidth) * BOWidthRate, 19 * BOHeightRate, (modelWidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
            self.thirdLabel.text = self.businessArray[flag];
            [self.contentView layoutIfNeeded];

        }else {
            self.secondLabel.width = 0;
            int flag = [item.bus_model intValue];
            if (flag != 0) {
                CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
              self.thirdLabel.frame = CGRectMake(BOScreenW - (self.flagX + 15 + modelWidth) * BOWidthRate, 19 * BOHeightRate, (modelWidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
            self.thirdLabel.text = self.businessArray[flag];
                [self.contentView layoutIfNeeded];
  
            }
            
        }
        
    }else if(item.bg_array.count != 0){
        self.firstLabel.width = 0;
        BackgroundModel *backItem = item.bg_array[0];
        // 动态算出label的宽度
        CGFloat backwidth = [BOLabelHeight LabelWidth:backItem.name dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
        self.secondLabel.frame = CGRectMake(BOScreenW - (self.flagX + backwidth + 10) * BOWidthRate, 19 * BOHeightRate, (backwidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
        self.flagX += (backwidth + 10);
        self.secondLabel.text = backItem.name;
        [self.contentView layoutIfNeeded];

        int flag = [item.bus_model intValue];
        if (flag != 0) {
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            self.thirdLabel.frame = CGRectMake(BOScreenW - (self.flagX + 15 + modelWidth) * BOWidthRate, 19 * BOHeightRate, (modelWidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
            self.thirdLabel.text = self.businessArray[flag];
            [self.contentView layoutIfNeeded];

        }
    }else if(item.bg_array.count == 0) {
        self.firstLabel.width = 0;
        self.secondLabel.width = 0;
        int flag = [item.bus_model intValue];
        if (flag != 0) {
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            self.thirdLabel.frame = CGRectMake(BOScreenW - (self.flagX  + modelWidth + 10) * BOWidthRate, 19 * BOHeightRate, (modelWidth + 10) * BOWidthRate, 17.5 * BOHeightRate);
            self.thirdLabel.text = self.businessArray[flag];
            [self.contentView layoutIfNeeded];

        }
    }
    self.locationLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng,item.shi];
    // 添加底部的灰色View
    [self.contentView addSubview:self.grayView];
    // 添加底部的新手活动和活动
    NSArray *array1 = [item.reg_url componentsSeparatedByString:@"|"];
    NSArray *array2 = item.huodong;
    NSString *string1 = array1.firstObject;
    PlatformHuodongItem *model;
    if (array2.count > 0) {
        model = array2[0];
    }
    // 给flagY赋初值
    self.flagY = 95 * BOHeightRate;
    NSString *string2 = model.title;
        if (string1.length > 0 && array2.count > 0) {
            self.flagY = 105 * BOHeightRate;
            // 转换成最终的字符串
            string1 = [NSString stringWithFormat:@"新 %@",string1];
            string2 = [NSString stringWithFormat:@"活 %@",string2];
            NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc] initWithString:string1];
            [attribute1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,BOColor(62, 194, 154),NSBackgroundColorAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 1)];
            [attribute1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#737373" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(1, string1.length-1)];
            NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:string2];
            [attribute2 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,BOColor(230, 113, 114),NSBackgroundColorAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 1)];
            [attribute2 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#737373" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(1, string2.length-1)];
        self.bestLabel.frame = CGRectMake(85 * BOWidthRate, self.flagY, (BOScreenW - 95) * BOWidthRate, 13 * BOHeightRate);
        self.bestLabel.attributedText = attribute1;
            [self.contentView layoutIfNeeded];
        self.activityLabel.frame = CGRectMake(85 * BOWidthRate, CGRectGetMaxY(self.bestLabel.frame) + 5 * BOHeightRate, (BOScreenW - 95) * BOWidthRate, 13 * BOHeightRate);
        self.activityLabel.attributedText = attribute2;
        self.grayView.frame = CGRectMake(0, CGRectGetMaxY(self.activityLabel.frame) + 10 * BOHeightRate, BOScreenW, 8 * BOHeightRate);
        self.divisionView.hidden = NO;
            [self.contentView layoutIfNeeded];
    }else if (string1.length > 0 && array2.count == 0) {
        string1 = [NSString stringWithFormat:@"新 %@",string1];
        NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc] initWithString:string1];
        [attribute1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,BOColor(62, 194, 154),NSBackgroundColorAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 1)];
        [attribute1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#737373" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(1, string1.length-1)];
        self.bestLabel.frame = CGRectMake(85 * BOWidthRate, self.flagY, (BOScreenW - 95) * BOWidthRate, 13 * BOHeightRate);
        self.bestLabel.attributedText = attribute1;
        self.grayView.frame = CGRectMake(0, CGRectGetMaxY(self.bestLabel.frame) + 10 * BOHeightRate, BOScreenW, 8 * BOHeightRate);
        self.divisionView.hidden = NO;
        [self.contentView layoutIfNeeded];
    }else if (string1.length == 0 && array2.count > 0) {
        string2 = [NSString stringWithFormat:@"活 %@",string2];
        NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:string2];
        [attribute2 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,BOColor(230, 113, 114),NSBackgroundColorAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 1)];
        [attribute2 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#737373" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(1, string2.length-1)];
        self.activityLabel.frame = CGRectMake(85 * BOWidthRate, self.flagY, (BOScreenW - 95) * BOWidthRate, 13 * BOHeightRate);
        self.activityLabel.attributedText = attribute2;
        self.grayView.frame = CGRectMake(0, CGRectGetMaxY(self.activityLabel.frame) + 10 * BOHeightRate, BOScreenW, 8 * BOHeightRate);
        self.divisionView.hidden = NO;
        [self.contentView layoutIfNeeded];
    }else if(string1.length == 0 && array2.count == 0) {
        self.grayView.frame = CGRectMake(0, self.flagY, BOScreenW, 8 * BOHeightRate);
        self.divisionView.hidden = YES;
        [self.contentView layoutIfNeeded];
    }
}
@end
