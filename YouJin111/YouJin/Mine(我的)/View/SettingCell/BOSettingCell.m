//
//  BOSettingCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSettingCell.h"
#import "BORowItem.h"
#import "BOSettingArrowItem.h"
#import "BOSettingGroupItem.h"
@implementation BOSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    
    static NSString *ID = @"settingCell";
    BOSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BOSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加titleLabel
        CGFloat titleX = 15 * BOWidthRate;
        CGFloat titleY = 15 * BOHeightRate;
        CGFloat titleW = 150 * BOWidthRate;
        CGFloat titleH = 15 * BOHeightRate;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        [self.contentView addSubview:titleLabel];
        
        // 添加subtitleView
        CGFloat subTitleX = BOScreenW - 160 * BOWidthRate;
        CGFloat subTitleY = titleY;
        CGFloat subTitleW = 133 * BOWidthRate;
        CGFloat subTitleH = titleH;
        UILabel *subTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLable;
        [subTitleLable setFont:[UIFont systemFontOfSize:12]];
        subTitleLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        subTitleLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:subTitleLable];
        
        // 添加箭头icon
        CGFloat arrowX = CGRectGetMaxX(subTitleLable.frame) + 20 * BOWidthRate;
        CGFloat arrowY = 15 * BOHeightRate;
        CGFloat arrowW = 10 * BOWidthRate;
        CGFloat arrowH = 15 * BOHeightRate;
        UIImageView *arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(arrowX, arrowY, arrowW, arrowH)];
        self.arrowIcon = arrowIcon;
        arrowIcon.image = [UIImage imageNamed:@"common_goto"];
        [self.contentView addSubview:arrowIcon];
    }
    return self;
}

- (void)setRowItem:(BORowItem *)rowItem {
    _rowItem = rowItem;
    //设置数据
    [self setUpData:rowItem];
    //设置辅助视图
    [self setUpAccessoryView:rowItem];
}

//设置数据
- (void)setUpData:(BORowItem *)rowItem {
    //设置数据
    self.titleLabel.text = rowItem.title;
    self.arrowIcon.image = rowItem.image;
    self.subTitleLabel.text = rowItem.subTitle;
}


//设置辅助视图
- (void)setUpAccessoryView:(BORowItem *)rowItem {
    //设置辅助视图
    if ([rowItem isKindOfClass:[BOSettingArrowItem class]]) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_goto"]];
    }
}
@end
