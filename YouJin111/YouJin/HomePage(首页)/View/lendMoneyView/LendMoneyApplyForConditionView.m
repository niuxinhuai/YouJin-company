//
//  LendMoneyApplyForConditionView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyApplyForConditionView.h"
#import "LendMoneyDetailModel.h"
@interface LendMoneyApplyForConditionView()

/**头像的icon*/
@property (nonatomic, weak) UIImageView *iconImageV;

/**申请资格的label*/
@property (nonatomic, weak) UILabel *applyForLabel;

/**申请资格的条件1label*/
@property (nonatomic, weak) UILabel *firstApplyForLabel;

/**申请资格的条件2label*/
@property (nonatomic, weak) UILabel *secondApplyForLabel;

/**申请资格的添加3label*/
@property (nonatomic, weak) UILabel *thirdApplyForLabel;

/**材料的icon*/
@property (nonatomic, weak) UIImageView *materialIconImageV;

/**所需材料的Lable*/
@property (nonatomic, weak) UILabel *materialLabel;

/**申请材料1label*/
@property (nonatomic, weak) UILabel *firstMateriaLabel;

/**申请材料2label*/
@property (nonatomic, weak) UILabel *secondMateriaLabel;

/**申请材料3label*/
@property (nonatomic, weak) UILabel *thirdMateriaLabel;

/**申请材料4label*/
@property (nonatomic, weak) UILabel *fourthMateriaLabel;

/**保存申请资格的数组 */
@property (nonatomic, strong) NSMutableArray *ziGeArrayM;

/**申请材料的数组*/
@property (nonatomic, strong) NSMutableArray *caiLiaoArrayM;

@end
@implementation LendMoneyApplyForConditionView
- (NSMutableArray *)ziGeArrayM {
    if (_ziGeArrayM == nil) {
        _ziGeArrayM = [NSMutableArray array];
    }
    return _ziGeArrayM;
}
- (NSMutableArray *)caiLiaoArrayM {
    if (_caiLiaoArrayM == nil) {
        _caiLiaoArrayM = [NSMutableArray array];
    }
    return _caiLiaoArrayM;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加头像的icon
        UIImageView *iconImageV = [[UIImageView alloc] init];
        self.iconImageV = iconImageV;
        [self addSubview:iconImageV];
        
        // 添加申请资格的label
        UILabel *applyForLabel = [[UILabel alloc] init];
        self.applyForLabel = applyForLabel;
        [self addSubview:applyForLabel];
        
        // 添加申请资格的条件1label
        UILabel *firstApplyForLabel = [[UILabel alloc] init];
        self.firstApplyForLabel = firstApplyForLabel;
        [self.ziGeArrayM addObject:firstApplyForLabel];
        [self addSubview:firstApplyForLabel];
        
        // 添加申请资格的条件2label
        UILabel *secondApplyForLabel = [[UILabel alloc] init];
        self.secondApplyForLabel = secondApplyForLabel;
        [self.ziGeArrayM addObject:secondApplyForLabel];
        [self addSubview:secondApplyForLabel];
        
        // 添加申请资格的添加3label
        UILabel *thirdApplyForLabel = [[UILabel alloc] init];
        self.thirdApplyForLabel = thirdApplyForLabel;
        [self.ziGeArrayM addObject:thirdApplyForLabel];
        [self addSubview:thirdApplyForLabel];
        
        // 添加材料的icon
        UIImageView *materialIconImageV = [[UIImageView alloc] init];
        self.materialIconImageV = materialIconImageV;
        [self addSubview:materialIconImageV];
        
        // 添加所需材料的Lable
        UILabel *materialLabel = [[UILabel alloc] init];
        self.materialLabel = materialLabel;
        [self addSubview:materialLabel];
        
        // 添加申请材料1label
        UILabel *firstMateriaLabel = [[UILabel alloc] init];
        self.firstMateriaLabel = firstMateriaLabel;
        [self.caiLiaoArrayM addObject:firstMateriaLabel];
        [self addSubview:firstMateriaLabel];
        
        // 添加申请材料2label
        UILabel *secondMateriaLabel = [[UILabel alloc] init];
        self.secondMateriaLabel = secondMateriaLabel;
        [self.caiLiaoArrayM addObject:secondMateriaLabel];
        [self addSubview:secondMateriaLabel];
        
        // 添加申请材料3label
        UILabel *thirdMateriaLabel = [[UILabel alloc] init];
        self.thirdMateriaLabel = thirdMateriaLabel;
        [self.caiLiaoArrayM addObject:thirdMateriaLabel];
        [self addSubview:thirdMateriaLabel];
        // 添加申请材料4label
        UILabel *fourthMateriaLabel = [[UILabel alloc] init];
        self.fourthMateriaLabel = fourthMateriaLabel;
        [self.caiLiaoArrayM addObject:fourthMateriaLabel];
        [self addSubview:fourthMateriaLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)setItem:(LendMoneyDetailModel *)item {
    _item = item;
    //设置头像的icon
    CGFloat iconX = 15 * BOWidthRate;
    CGFloat iconY = 11 * BOHeightRate;
    CGFloat iconWH = 15 * BOWidthRate;
    self.iconImageV.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    self.iconImageV.image = [UIImage imageNamed:@"icon_sqzg"];
    // 设置申请资格的label
    CGFloat applyForX = CGRectGetMaxX(self.iconImageV.frame) + 9 * BOWidthRate;
    CGFloat applyForY = 11 * BOHeightRate;
    CGFloat applyForW = 60 * BOWidthRate;
    CGFloat applyForH = 15 * BOHeightRate;
    self.applyForLabel.frame = CGRectMake(applyForX, applyForY, applyForW, applyForH);
    self.applyForLabel.text = @"申请资格";
    self.applyForLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [self.applyForLabel setFont:[UIFont systemFontOfSize:13]];
    self.currentY = 40;
    NSArray *array1 = [item.tiaojian componentsSeparatedByString:@"|"];
    for (int i = 0; i < array1.count ;i++) {
        UILabel *label = self.ziGeArrayM[i];
        label.frame = CGRectMake(15 * BOWidthRate, self.currentY * BOHeightRate, 330 * BOWidthRate, 15 * BOWidthRate);
        [label setFont:[UIFont systemFontOfSize:13]];
        label.text = array1[i];
        self.currentY += 29 * BOHeightRate;
    }
    self.currentY += 12 * BOHeightRate;
    
    // 设置所需材料的icon
    CGFloat materiaIconX = 15 * BOWidthRate;
    CGFloat materiaIconY = self.currentY * BOHeightRate;
    CGFloat materiaIconWh = 15 * BOWidthRate;
    self.materialIconImageV.frame = CGRectMake(materiaIconX, materiaIconY, materiaIconWh, materiaIconWh);
    self.materialIconImageV.image = [UIImage imageNamed:@"icon_sxcl"];
    // 设置显示所需材料的label
    CGFloat materiaX = CGRectGetMaxX(self.materialIconImageV.frame) + 8 * BOWidthRate;
    CGFloat materiaY = self.currentY * BOHeightRate;
    CGFloat materiaW = 60 * BOWidthRate;
    CGFloat materiaH = 15 * BOHeightRate;
    self.materialLabel.frame = CGRectMake(materiaX, materiaY, materiaW, materiaH);
    self.materialLabel.text = @"所需材料";
    [self.materialLabel setFont:[UIFont systemFontOfSize:13]];
    self.materialLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    self.currentY += 29 * BOHeightRate;
    NSArray *array2 = [item.need componentsSeparatedByString:@"|"];
    for (int i = 0; i < array2.count ;i++) {
        UILabel *label = self.caiLiaoArrayM[i];
        label.frame = CGRectMake(15 * BOWidthRate, self.currentY * BOHeightRate, 330 * BOWidthRate, 15 * BOWidthRate);
        [label setFont:[UIFont systemFontOfSize:13]];
        label.text = array2[i];
        self.currentY += 29 * BOHeightRate;
    }
    self.currentY += 8;
    
}
@end
