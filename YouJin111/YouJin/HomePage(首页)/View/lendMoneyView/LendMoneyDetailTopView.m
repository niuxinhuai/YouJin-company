//
//  LendMoneyDetailTopView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyDetailTopView.h"
#import "LendMoneyDetailModel.h"
#import "LendTypeModel.h"
@interface LendMoneyDetailTopView()

/**头像ImageView*/
@property (nonatomic, weak) UIImageView *iconImageV;

/**名称Label*/
@property (nonatomic, weak) UILabel *nameLabel;

// 中间的细线
@property (nonatomic ,strong)UIView *lineView;

/**贷款类型的Label*/
@property (nonatomic, weak) UILabel *loanLabel;

/**第一个星星*/
@property (nonatomic, weak) UIImageView *firstImageV;

/**第二个星星*/
@property (nonatomic, weak) UIImageView *secondImageV;

/**第三个星星*/
@property (nonatomic, weak) UIImageView *thirdImageV;

/**第四个星星*/
@property (nonatomic, weak) UIImageView *fourthImageV;

/**第五个星星*/
@property (nonatomic, weak) UIImageView *fiveImageV;

/**评分的label*/
@property (nonatomic, weak) UILabel *numberLable;

/**放款人数的Label*/
@property (nonatomic, weak) UILabel *loanNumberLabel;

/**添加分割线的View*/
@property (nonatomic, weak) UIView *divisionView;

/**添加月费率的Label*/
@property (nonatomic, weak) UILabel *monthlyFeeLabel;

/**保存星星的数组*/
@property (nonatomic, strong) NSMutableArray *starArrayM;
@end
@implementation LendMoneyDetailTopView
- (NSMutableArray *)starArrayM {
    if (_starArrayM == nil) {
        _starArrayM = [NSMutableArray array];
    }
    return _starArrayM;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建头像image
        UIImageView *iconImageV = [[UIImageView alloc] init];
        self.iconImageV = iconImageV;
        
        // 创建名称Label
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        
        //中间的细线
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
        [self addSubview:_lineView];
        
        // 创建贷款类型的Label
        UILabel *loanLabel = [[UILabel alloc] init];
        self.loanLabel = loanLabel;
        
        // 添加第一个星星frame
        UIImageView *firstImageV = [[UIImageView alloc] init];
        self.firstImageV = firstImageV;
        [self.starArrayM addObject:firstImageV];
        // 添加第二个星星frame
        UIImageView *secondImageV = [[UIImageView alloc] init];
        self.secondImageV = secondImageV;
        [self.starArrayM addObject:secondImageV];

        // 添加第三个星星的frame
        UIImageView *thirdImageV = [[UIImageView alloc] init];
        self.thirdImageV = thirdImageV;
        [self.starArrayM addObject:thirdImageV];
        // 添加第四个星星的frame
        UIImageView *fourthImageV = [[UIImageView alloc] init];
        self.fourthImageV = fourthImageV;
        [self.starArrayM addObject:fourthImageV];

        // 添加第五个星星的frame
        UIImageView *fiveImageV = [[UIImageView alloc] init];
        self.fiveImageV = fiveImageV;
        [self.starArrayM addObject:fiveImageV];
        
        // 添加评分的label
        UILabel *numberLable = [[UILabel alloc] init];
        self.numberLable = numberLable;
        
        // 放款的人数
        UILabel *loanNumberLabel = [[UILabel alloc] init];
        self.loanNumberLabel = loanNumberLabel;
        
        //添加分割线
        UIView *divisionView = [[UIView alloc] init];
        self.divisionView = divisionView;
        
        // 创建月费率
        UILabel *monthlyFeeLabel = [[UILabel alloc] init];
        self.monthlyFeeLabel = monthlyFeeLabel;
        
        [self addSubview:iconImageV];
        [self addSubview:nameLabel];
        [self addSubview:loanLabel];
        [self addSubview:firstImageV];
        [self addSubview:secondImageV];
        [self addSubview:thirdImageV];
        [self addSubview:fourthImageV];
        [self addSubview:fiveImageV];
        [self addSubview:numberLable];
        [self addSubview:loanNumberLabel];
        [self addSubview:divisionView];
        [self addSubview:monthlyFeeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setItem:(LendMoneyDetailModel *)item {
    _item = item;
    
    // 设置头像的frame
    CGFloat iconX = 15 * BOScreenW / BOPictureW;
    CGFloat iconY = 20 * BOScreenH / BOPictureH;
    CGFloat iconWH = 50 * BOScreenW / BOPictureW;
    self.iconImageV.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
    self.iconImageV.layer.cornerRadius = 25 * BOWidthRate;
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.layer.borderWidth = 2;
    self.iconImageV.layer.borderColor = BOColor(250, 254, 255).CGColor;
    // 设置名称label的frame
    CGFloat nameX = CGRectGetMaxX(self.iconImageV.frame) + 15 * BOPictureW / BOPictureW;
    CGFloat nameY = 24 * BOScreenH / BOPictureH;
    // 用字体大小和text实时计算label的宽度
    NSString *text = item.name;
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    CGFloat nameW =[text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]].width;
    CGFloat nameH = 20 * BOScreenH / BOPictureH;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLabel.text = text;
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    
    // 设置贷款类型的Label
    CGFloat loanX = CGRectGetMaxX(self.nameLabel.frame) + 20 * BOPictureW / BOPictureW;
    CGFloat loanY = 26 * BOScreenH / BOPictureH;
    CGFloat loanW = 200 * BOScreenW / BOPictureW;
    CGFloat loanH = 15 * BOScreenH / BOPictureH;
    self.loanLabel.frame = CGRectMake(loanX, loanY, loanW, loanH);
    self.loanLabel.textColor = BOColor(241, 241, 97);
    [self.loanLabel setFont:[UIFont systemFontOfSize:12]];
    NSMutableString *stringM = [NSMutableString string];
    NSArray *array = item.type;
    for (LendTypeModel *model in array) {
        [stringM appendFormat:@"%@ ", model.desc];
    }
    self.loanLabel.text = stringM;
    
    //中间的细线
    _lineView.frame = CGRectMake(loanX-20*BOScreenW/750, loanY, 1*BOScreenW/750, 30*BOScreenH/1334);
    
    // 设置第一颗星星
    CGFloat firstX = nameX;
    CGFloat firstY = CGRectGetMaxY(self.nameLabel.frame) + 14 * BOScreenH / BOPictureH;
    CGFloat firstWH = 12 * BOScreenW / BOPictureW;
    self.firstImageV.frame = CGRectMake(firstX, firstY, firstWH, firstWH);
    [self.firstImageV setImage:[UIImage imageNamed:@"icon_star_d"]];
    [self.firstImageV setHighlightedImage:[UIImage imageNamed:@"icon_star_h"]];
    // 设置第二颗星星
    CGFloat secondX = CGRectGetMaxX(self.firstImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat secondY = firstY;
    CGFloat secondWH = firstWH;
    self.secondImageV.frame = CGRectMake(secondX, secondY, secondWH, secondWH);
    [self.secondImageV setImage:[UIImage imageNamed:@"icon_star_d"]];
    [self.secondImageV setHighlightedImage:[UIImage imageNamed:@"icon_star_h"]];
    // 设置第三颗星星
    CGFloat thirdX = CGRectGetMaxX(self.secondImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat thirdY = firstY;
    CGFloat thirdWH = firstWH;
    self.thirdImageV.frame = CGRectMake(thirdX, thirdY, thirdWH, thirdWH);
    [self.thirdImageV setImage:[UIImage imageNamed:@"icon_star_d"]];
    [self.thirdImageV setHighlightedImage:[UIImage imageNamed:@"icon_star_h"]];
    // 设置第四颗星星
    CGFloat fourthX = CGRectGetMaxX(self.thirdImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat fourthY = firstY;
    CGFloat fourthWH = firstWH;
    self.fourthImageV.frame = CGRectMake(fourthX, fourthY, fourthWH, fourthWH);
    [self.fourthImageV setImage:[UIImage imageNamed:@"icon_star_d"]];
    [self.fourthImageV setHighlightedImage:[UIImage imageNamed:@"icon_star_h"]];
    // 设置第五颗星星
    CGFloat fiveX = CGRectGetMaxX(self.fourthImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat fiveY = firstY;
    CGFloat fiveWH = firstWH;
    self.fiveImageV.frame = CGRectMake(fiveX, fiveY, fiveWH, fiveWH);
    [self.fiveImageV setImage:[UIImage imageNamed:@"icon_star_d"]];
    [self.fiveImageV setHighlightedImage:[UIImage imageNamed:@"icon_star_h"]];
    
    for (int i = 0; i < (int)([item.score floatValue] + 0.5); i++) {
        UIImageView *imageV = self.starArrayM[i];
        imageV.highlighted = YES;
    }
    // 设置评分的label
    CGFloat numberX = CGRectGetMaxX(self.fiveImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat numberY = fiveY;
    CGFloat numberW = 30 * BOWidthRate;
    CGFloat numberH = 12 * BOHeightRate;
    self.numberLable.frame = CGRectMake(numberX, numberY, numberW, numberH);
    self.numberLable.text = [NSString stringWithFormat:@"%d.0",(int)([item.score floatValue] + 0.5)];
    self.numberLable.textColor = BOColor(161, 199, 241);
    [self.numberLable setFont:[UIFont systemFontOfSize:12]];
    // 设置放款人数的label
    CGFloat loanNumberX = 250 * BOWidthRate;
    CGFloat loanNumberY = numberY;
    CGFloat loanNumberW = BOScreenW - loanNumberX - 15 * BOWidthRate;
    CGFloat loanNumberH = numberH;
    self.loanNumberLabel.frame = CGRectMake(loanNumberX, loanNumberY, loanNumberW, loanNumberH);
    self.loanNumberLabel.text = [NSString stringWithFormat:@"%@人已放款",item.nums];
    self.loanNumberLabel.textColor = BOColor(161, 199, 241);
    self.loanNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.loanNumberLabel setFont:[UIFont systemFontOfSize:12]];
    // 设置分割线的frame
    CGFloat divisionX = iconX;
    CGFloat divisionY = 83 * BOHeightRate;
    CGFloat divisionW = BOScreenW - divisionX;
    CGFloat divisionH = 1;
    self.divisionView.frame = CGRectMake(divisionX, divisionY, divisionW, divisionH);
    self.divisionView.backgroundColor = BOColor(116, 191, 246);
    // 设置月率的label
    CGFloat monthX = iconX;
    CGFloat monthY = 96 * BOHeightRate;
    CGFloat monthW = 300 * BOWidthRate;
    CGFloat monthH = 15 * BOHeightRate;
    self.monthlyFeeLabel.frame = CGRectMake(monthX, monthY, monthW, monthH);
    self.monthlyFeeLabel.text = item.desc;
    self.monthlyFeeLabel.textColor = [UIColor whiteColor];
    [self.monthlyFeeLabel setFont:[UIFont systemFontOfSize:14]];

}
@end
