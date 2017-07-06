//
//  HotPlatfromCellTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "HotPlatfromCellTableViewCell.h"
#import "Masonry.h"
#import "BOLabelHeight.h"
#import "PeerHonePageModel.h"
#import "BackgroundModel.h"
@interface HotPlatfromCellTableViewCell ()
@property (nonatomic, weak) UIImageView *iconImageV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLable;
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

@end
@implementation HotPlatfromCellTableViewCell

- (NSMutableArray *)imageVArray {
    if (_imageVArray == nil) {
        _imageVArray = [NSMutableArray array];
    }
    return _imageVArray;
}
- (NSArray *)businessArray {
    if (_businessArray == nil) {
        _businessArray = [NSArray arrayWithObjects:@"",@"车贷",@"消费分期",@"供应链",@"房贷",@"企业贷",@"优选理财",@"票据抵押",@"融资租赁",@"藏品质押",@"个人信用贷", nil];
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
        CGFloat numberW = 50 * BOWidthRate;
        CGFloat numberH = 12 * BOHeightRate;
        _numberLable = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
//        self.numberLable = numberLable;
//        numberLable.text = @"0.0";
        _numberLable.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
        [_numberLable setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_numberLable];
        
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
        [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
            make.width.equalTo(@(30 * BOWidthRate));
            make.height.equalTo(@(17.5 * BOHeightRate));
        }];
        
        // 创建中间的label
        UILabel *secondLabel = [[UILabel alloc] init];
        secondLabel.layer.cornerRadius = 2;
        secondLabel.layer.masksToBounds = YES;
        secondLabel.layer.borderWidth = 1;
        secondLabel.layer.borderColor = [UIColor colorWithHexString:@"#3BB5F4" alpha:1].CGColor;
        [self.contentView addSubview:secondLabel];
        [self setupLabel:secondLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor colorWithHexString:@"#3BB5F4" alpha:1] textAligenment:NSTextAlignmentCenter];
        self.secondLabel = secondLabel;
        [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.firstLabel.mas_left);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
            make.height.equalTo(@(17.5 * BOHeightRate));
            make.width.equalTo(@(50 * BOWidthRate));
            
        }];
        // 创建最左边的lable
        UILabel *thirdLabel= [[UILabel alloc] init];
        thirdLabel.layer.cornerRadius = 2;
        thirdLabel.layer.masksToBounds = YES;
        thirdLabel.layer.borderWidth = 1;
        thirdLabel.layer.borderColor = [UIColor colorWithHexString:@"#3BB5F4" alpha:1].CGColor;
        [self.contentView addSubview:thirdLabel];
        self.thirdLabel =thirdLabel;
        [self setupLabel:thirdLabel font:[UIFont systemFontOfSize:10] textColor:[UIColor colorWithHexString:@"#3BB5F4" alpha:1] textAligenment:NSTextAlignmentCenter];
        [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.secondLabel.mas_left).offset(-5 * BOWidthRate);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
            make.height.equalTo(@(17.5 * BOHeightRate));
            make.width.equalTo(@(50 * BOWidthRate));
        }];
        
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
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 189*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineview.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [self.contentView addSubview:lineview];
        
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
    self.numberLable.text = [NSString stringWithFormat:@"%@分",item.score];
    // 根据评分给设置星星高亮
    for (NSInteger i = 0; i < (int)([item.score floatValue] + 0.5) / 1; i++) {
        UIImageView *imageV = self.imageVArray[i];
        imageV.highlighted = YES;
    }
    self.earnNumberLabel.text = [NSString stringWithFormat:@"%@~%@%%",item.apr_min,item.apr_max];
    if ([item.cgid intValue]) {
        __weak __typeof(self) weakSelf = self;
        [self.firstLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
            make.width.equalTo(@(35 * BOWidthRate));
            make.height.equalTo(@(17.5 * BOHeightRate));
        }];
        [self.contentView layoutIfNeeded];
        self.firstLabel.text = @"存管";
        if (item.bg_array.count != 0) {
            BackgroundModel *backItem = item.bg_array[0];
            // 动态算出label的宽度
            CGFloat backwidth = [BOLabelHeight LabelWidth:backItem.name dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            __weak __typeof(self) weakSelf = self;
            [self.secondLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.firstLabel.mas_left);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                make.height.equalTo(@(17.5 * BOHeightRate));
                make.width.equalTo(@(backwidth + 10 * BOWidthRate));
                
            }];
            [self.contentView layoutIfNeeded];
            self.secondLabel.text = backItem.name;
            int flag = [item.bus_model intValue];
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            [self.thirdLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.secondLabel.mas_left).offset(-5 * BOWidthRate);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                make.height.equalTo(@(17.5 * BOHeightRate));
                make.width.equalTo(@(modelWidth + 10 * BOWidthRate));
            }];
            [self.contentView layoutIfNeeded];
            self.thirdLabel.text = self.businessArray[flag];
        }else {
            __weak __typeof(self) weakSelf = self;
            [self.secondLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.firstLabel.mas_left);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                make.height.equalTo(@(17.5 * BOHeightRate));
                make.width.equalTo(@(0));
                
            }];
            [self.contentView layoutIfNeeded];
            int flag = [item.bus_model intValue];
            if (flag != 0) {
                CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
                __weak __typeof(self) weakSelf = self;
                [self.thirdLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(weakSelf.firstLabel.mas_left).offset(-5 * BOWidthRate);
                    make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                    make.height.equalTo(@(17.5 * BOHeightRate));
                    make.width.equalTo(@(modelWidth + 10 * BOWidthRate));
                }];
                [self.contentView layoutIfNeeded];
                self.thirdLabel.text = self.businessArray[flag];
                
            }
            
        }
        
    }else if(item.bg_array.count != 0){
        __weak __typeof(self) weakSelf = self;
        
        BackgroundModel *backItem = item.bg_array[0];
        // 动态算出label的宽度
        CGFloat backwidth = [BOLabelHeight LabelWidth:backItem.name dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
        [self.secondLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10 * BOWidthRate);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
            make.height.equalTo(@(17.5 * BOHeightRate));
            make.width.equalTo(@(backwidth + 10 * BOWidthRate));
            
        }];
        [self.contentView layoutIfNeeded];
        self.secondLabel.text = backItem.name;
        int flag = [item.bus_model intValue];
        if (flag != 0) {
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            __weak __typeof(self) weakSelf = self;
            [self.thirdLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.secondLabel.mas_left).offset(-5 * BOWidthRate);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                make.height.equalTo(@(17.5 * BOHeightRate));
                make.width.equalTo(@(modelWidth + 10 * BOWidthRate));
            }];
            [self.contentView layoutIfNeeded];
            self.thirdLabel.text = self.businessArray[flag];
        }
    }else if(item.bg_array.count == 0) {
        __weak __typeof(self) weakSelf = self;
        int flag = [item.bus_model intValue];
        if (flag != 0) {
            CGFloat modelWidth = [BOLabelHeight LabelWidth:self.businessArray[flag] dict:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil]];
            [self.thirdLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-5 * BOWidthRate);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(19 * BOHeightRate);
                make.height.equalTo(@(17.5 * BOHeightRate));
                make.width.equalTo(@(modelWidth + 10 * BOWidthRate));
            }];
            [self.contentView layoutIfNeeded];
            self.thirdLabel.text = self.businessArray[flag];
            
        }
    }
    self.locationLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng,item.shi];
    self.divisionView.hidden = YES;
}

@end
