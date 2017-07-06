//
//  BOMinePageCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMinePageCell.h"
@interface BOMinePageCell()
@property (nonatomic, strong) NSMutableArray *imageVArray;

@property (nonatomic, weak) UILabel *numberLable;
@end
@implementation BOMinePageCell
- (NSMutableArray *)imageVArray {
    if (_imageVArray == nil) {
        _imageVArray = [NSMutableArray array];
    }
    return _imageVArray;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建名称label
        CGFloat nameX = 15 * BOWidthRate;
        CGFloat nameY = 19 * BOHeightRate;
        CGFloat nameW = 71 * BOWidthRate;
        CGFloat nameH = 17 * BOHeightRate;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        [self setupLabel:nameLabel fontSize:[UIFont fontWithName:@"Helvetica-Bold" size:14] textColor:[UIColor colorWithHexString:@"#333333" alpha:1] textAlignment:NSTextAlignmentLeft];
        nameLabel.text = @"沃伦巴菲特";
        [self.contentView addSubview:nameLabel];
        
        // 添加点评了某某的label
        CGFloat commentX = CGRectGetMaxX(nameLabel.frame) + 5 * BOWidthRate;
        CGFloat commentY = nameY;
        CGFloat commetnW = 130 * BOWidthRate;
        CGFloat commentH = nameH;
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake( commentX, commentY, commetnW, commentH)];
        commentLabel.text = @"点评了一两理财";
        [self setupLabel:commentLabel fontSize:[UIFont fontWithName:@"Helvetica-Bold" size:14] textColor:[UIColor colorWithHexString:@"#333333" alpha:1] textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:commentLabel];
        
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
        
        // 添加时间label
        CGFloat timeX = (BOScreenW - 105 * BOWidthRate);
        CGFloat timeY = 23 * BOHeightRate;
        CGFloat timeW = 90 * BOWidthRate;
        CGFloat timeH = 15 * BOHeightRate;
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        [self setupLabel:timeLabel fontSize:[UIFont systemFontOfSize:11] textColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] textAlignment:NSTextAlignmentRight];
        timeLabel.text = @"16分钟前";
        [self.contentView addSubview:timeLabel];
        
        // 创建内容的label
        CGFloat contentX = 15 * BOWidthRate;
        CGFloat contentY = CGRectGetMaxY(firstImageV.frame) + 21 * BOHeightRate;
        CGFloat contentW = BOScreenW - 30 * BOWidthRate;
        CGFloat contentH = 40 * BOHeightRate;
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        // 创建对应的行间距
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 5;
        // 创建富文本对应的字典
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, [UIColor colorWithHexString:@"#333333" alpha:1],NSForegroundColorAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
        NSString *showString = @"一两理财，隶属于杭州乾袋科技有限公司，是国内第一家众筹模式成立的互联网理财公司，于2015年5月上线";
        contentLabel.numberOfLines = 2;
        contentLabel.attributedText = [[NSAttributedString alloc] initWithString:showString attributes:dict];
        [self.contentView addSubview:contentLabel];
        
        // 创建bottomView
        CGFloat bottomX = 15 * BOWidthRate;
        CGFloat bottomY = CGRectGetMaxY(contentLabel.frame) + 19 * BOHeightRate;
        CGFloat bottomW = BOScreenW - 30 * BOWidthRate;
        CGFloat bottomH = 40 * BOHeightRate;
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F7" alpha:1];
        [self.contentView addSubview:bottomView];
        
        // 创建imageView
        CGFloat imageX = 7 * BOWidthRate;
        CGFloat imageY = 7 * BOHeightRate;
        CGFloat imageWH = 26 * BOWidthRate;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWH, imageWH)];
        imageV.image = [UIImage imageNamed:@"logo_youjin"];
        [bottomView addSubview:imageV];
        
        // 创建点评对象的label
        CGFloat objectX = CGRectGetMaxX(imageV.frame) + 10 * BOWidthRate;
        CGFloat objectY = 13 * BOHeightRate;
        CGFloat objectW = 50 * BOWidthRate;
        CGFloat objectH = 14 * BOHeightRate;
        UILabel *objectLabel = [[UILabel alloc] initWithFrame:CGRectMake(objectX, objectY, objectW, objectH)];
        objectLabel.text = @"一两理财";
        [self setupLabel:objectLabel fontSize:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"#999999" alpha:1] textAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:objectLabel];
        
        // 添加分割线View
        UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(objectLabel.frame) + 10 * BOWidthRate, 10 * BOHeightRate, 1 * BOWidthRate, 20 * BOHeightRate)];
        divisionView.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [bottomView addSubview:divisionView];
        
        // 添加运营风控的评分
        UILabel *zongGradeLbale = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(divisionView.frame) + 10 * BOWidthRate, objectY, 210 * BOWidthRate, objectH)];
        [self setupLabel:zongGradeLbale fontSize:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"#999999" alpha:1] textAlignment:NSTextAlignmentLeft];
        zongGradeLbale.text = @"运营3.3 · 风控2.3 · 服务3.3 · 透明4.6";
        [bottomView addSubview:zongGradeLbale];
    }
    return self;
}

- (void)setupLabel:(UILabel *)label fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    [label setFont:fontSize];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
}

#pragma mark - 设置imageView的正常和高亮的图片
- (void)setupImageView:(UIImageView *)imageView {
    [imageView setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [imageView setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
}

@end
