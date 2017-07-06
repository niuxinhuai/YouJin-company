//
//  BuyBazaarCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BuyBazaarCell.h"
#import "BuyBazaarChildCell.h"
#import "BuyBazaarHeadView.h"
static NSString *const ID = @"cell";
@interface BuyBazaarCell ()<UITableViewDataSource, UITableViewDelegate>

/**cell底部的tableView*/
@property (nonatomic, weak) UITableView *bottomTabView;

/**展开的按钮*/
@property (nonatomic, weak) UIButton *spreadBtn;
@end
@implementation BuyBazaarCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建头像图片
        CGFloat pictureX = 10 * BOScreenW / BOPictureW;
        CGFloat pictureY = 15 * BOScreenH / BOPictureH;
        CGFloat pictureWH = 60 * BOScreenW / BOPictureW;
        UIImageView *pictureImageV = [[UIImageView alloc] initWithFrame:CGRectMake(pictureX, pictureY, pictureWH, pictureWH)];
        pictureImageV.layer.cornerRadius = 4;
        pictureImageV.layer.masksToBounds = YES;
        pictureImageV.image = [UIImage imageNamed:@"logo_youjin"];
        // 创建公司名称的label
        CGFloat nameX = 85 * BOScreenW / BOPictureW;
        CGFloat nameY = 20 * BOScreenH / BOPictureH;
        CGFloat nameW = 130 * BOScreenW / BOPictureW;
        CGFloat nameH = 25 * BOScreenH / BOPictureH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.text = @"微贷网";
        [nameLabel setFont:[UIFont systemFontOfSize:17]];
        [nameLabel setTextColor:BOColor(51, 51, 51)];
        // 创建总存量的label
        CGFloat stockX = 85 * BOScreenW / BOPictureW;
        CGFloat stockY = 60 * BOScreenH / BOPictureH;
        CGFloat stockW = 90 * BOScreenW / BOPictureW;
        CGFloat stockH = 10 * BOScreenH / BOPictureH;
        UILabel *stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(stockX, stockY, stockW, stockH)];
        stockLabel.text = @"本月网基总存量";
        [stockLabel setFont:[UIFont systemFontOfSize:12]];
        stockLabel.textColor = BOColor(127, 127, 127);
        // 创建显示数量的label
        CGFloat numberX = 185 * BOScreenW / BOPictureW;
        CGFloat numberY = 60 * BOScreenH / BOPictureH;
        CGFloat numberW = 100 * BOScreenW / BOPictureW;
        CGFloat numberH = 10 * BOScreenH / BOPictureH;
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(252, 91, 31), NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"↑2,637,855元"];
        [attributeString setAttributes:dictionary range:NSMakeRange(0, 10)];
         NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(127, 127, 127), NSForegroundColorAttributeName, nil];
        [attributeString setAttributes:dictionary1 range:NSMakeRange(10, 1)];
        numberLabel.attributedText = attributeString;
        [numberLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建展开收起的button
        CGFloat spreadX = BOScreenW - 25 * BOScreenW / BOPictureW;
        CGFloat spreadY = 60 * BOScreenH / BOPictureH;
        CGFloat spreadW = 15 * BOScreenW / BOPictureW;
        CGFloat spreadH = 20 * BOScreenH / BOPictureH;
        UIButton *spreadBtn = [[UIButton alloc] initWithFrame:CGRectMake(spreadX, spreadY, spreadW, spreadH)];
        _spreadBtn = spreadBtn;
        [spreadBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
        [spreadBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
        [spreadBtn addTarget:self action:@selector(spreadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 创建底部的tableView
        UITableView *bottomTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bottomTabView = bottomTabView;
        // 设置代理和数据源
        _bottomTabView.dataSource = self;
        _bottomTabView.delegate = self;
        [_bottomTabView registerClass:[BuyBazaarChildCell class] forCellReuseIdentifier:ID];
        _bottomTabView.separatorStyle = NO;
        [self addSubview:pictureImageV];
        [self addSubview:nameLabel];
        [self addSubview:stockLabel];
        [self addSubview:numberLabel];
        [self addSubview:spreadBtn];
        [self addSubview:bottomTabView];
        
    }
    return self;
}
#pragma mark - 展开按钮的点击事件
- (void)spreadBtnClick: (UIButton *)btn {
    // 如果按钮已经被选中
    if (btn.isSelected) {
        btn.selected = NO;
        _bottomTabView.frame = CGRectZero;
        // 调用收起的代理方法
        if ([self.delagete respondsToSelector:@selector(buyBazaarCellSpreadBtnPackupClick:)]) {
            [self.delagete buyBazaarCellSpreadBtnPackupClick:self];
        }
    }else if (!btn.isSelected) {
        // 如果按钮为被选中
        btn.selected = YES;
        // 通知代理(调用代理方法)
        if ([self.delagete respondsToSelector:@selector(buyBazaarCellSpreadBtnClick:)]) {
            [self.delagete buyBazaarCellSpreadBtnClick:self];
            [_bottomTabView reloadData];
        }
    }
}

#pragma mark - 重写cell中setmodel方法
- (void)setModel:(BuyModel *)model {
    _model = model;
    CGFloat bottomX = 0;
    CGFloat bottomY = CGRectGetMaxY(_spreadBtn.frame);
    CGFloat bottomW = BOScreenW;
    CGFloat bottomH = 60 * BOScreenH / BOPictureH;
    _bottomTabView.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
}

#pragma mark - UITableViewDatesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyBazaarChildCell *cell = [_bottomTabView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}
#pragma mark - UItabLeViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BuyBazaarHeadView *headView = [[BuyBazaarHeadView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 30 * BOScreenH / BOPictureH)];
    headView.backgroundColor = BOColor(250, 250, 250);
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30 * BOScreenH / BOPictureH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30 * BOScreenH / BOPictureH;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
