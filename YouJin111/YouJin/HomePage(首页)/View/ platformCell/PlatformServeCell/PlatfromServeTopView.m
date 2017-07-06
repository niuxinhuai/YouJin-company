//
//  PlatfromServeTopView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatfromServeTopView.h"
#import "PlatformServeDetailModel.h"
#import "CompanyImageModel.h"
@interface PlatfromServeTopView()

/**logo*/
@property (nonatomic, weak) UIImageView *logoImage;

/**店名*/
@property (nonatomic, weak) UILabel *shopNameLabel;

/**保存星星的数组*/
@property (nonatomic, strong) NSMutableArray *starArrayM;

/**评分label*/
@property (nonatomic, weak) UILabel *gradeLabel;

/**地址label*/
@property (nonatomic, weak) UILabel *addressLabel;

/**运作评分等label*/
@property (nonatomic, weak) UILabel *operationLabel;

/**典型客户的label*/
@property (nonatomic, weak) UILabel *clientLabel;

@property (nonatomic, weak) UIImageView *bigImage;
@end
@implementation PlatfromServeTopView
- (NSMutableArray *)starArrayM {
    if (_starArrayM == nil) {
        _starArrayM = [NSMutableArray array];
    }
    return _starArrayM;
}
- (NSMutableArray *)bannersArr {
    if (_bannersArr == nil) {
        _bannersArr = [NSMutableArray array];
    }
    return _bannersArr;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        //大的图片log
        UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 490*BOScreenH/1334)];
        self.bigImage = bigImage;
        bigImage.image = [UIImage imageNamed:@"pic_touxiang"];
        [self addSubview:bigImage];
        //对大图片的毛玻璃效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = bigImage.bounds;
        effectView.alpha = 0.98;
        [bigImage addSubview:effectView];
        
        //有banner图片数据的时候显示这个
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 490*BOScreenH/1334) delegate:nil placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
        //        topScrollView.imageURLStringsGroup = _bannerImageArr;//网络图
        _topScrollView.showPageControl = NO;
        _topScrollView.autoScrollTimeInterval = 4;
        [self addSubview:_topScrollView];       
        //中间的图片logo
        UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(315*BOScreenW/750, 420*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
        self.logoImage = logoImage;
        logoImage.image = [UIImage imageNamed:@"logo_youjin"];
        //加阴影
        logoImage.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.5].CGColor;//shadowColor阴影颜色
        logoImage.layer.shadowOffset = CGSizeMake(1,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        logoImage.layer.shadowOpacity = 0.4;//阴影透明度，默认0
        logoImage.layer.shadowRadius = 2;//阴影半径，默认3
        [self addSubview:logoImage];

//        //店名
//        CGFloat bigImageY = CGRectGetMaxY(bigImage.frame)+75*BOScreenH/1334;
//        UILabel *shopNameLabel = [[UILabel alloc]init];
//        self.shopNameLabel = shopNameLabel;
//        shopNameLabel.text = @"千店贷";
//        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
//        CGSize size=[shopNameLabel.text sizeWithAttributes:attrs];
//        [shopNameLabel setFrame:CGRectMake(30*BOScreenW/750, bigImageY, size.width, 40*BOScreenH/1334)];
//        shopNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//        [self addSubview:shopNameLabel];
//        
//        //评级的星星
//        CGFloat shopNameLabelX = CGRectGetMaxX(shopNameLabel.frame)+14*BOScreenH/1334;
//        for (int i = 0; i < 5; i++)
//        {
//            _starImage = [[UIImageView alloc]initWithFrame:CGRectMake(shopNameLabelX+i*(25*BOScreenW/750+6*BOScreenW/750), bigImageY+9*BOScreenH/1334, 25*BOScreenW/750, 25*BOScreenW/750)];
//            _starImage.image = [UIImage imageNamed:@"common_score_d"];
//            _starImage.highlightedImage = [UIImage imageNamed:@"common_score_h"];
//            [self.starArrayM addObject:_starImage];
//            [self addSubview:_starImage];
//        }
//        
//        //评分
//        CGFloat starImageX = CGRectGetMaxX(_starImage.frame) + 12*BOScreenW/750;
//        UILabel *gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(starImageX, bigImageY+5*BOScreenH/1334, 80*BOScreenW/750, 40*BOScreenW/750)];
//        self.gradeLabel = gradeLabel;
//        gradeLabel.text = @"4.7分";
//        gradeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
//        gradeLabel.font = [UIFont systemFontOfSize:11];
//        [self addSubview:gradeLabel];
//        
//        //地址
//        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-180*BOScreenW/750, bigImageY+3*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenW/750)];
//        self.addressLabel = addressLabel;
//        addressLabel.text = @"浙江,杭州";
//        addressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
//        addressLabel.font = [UIFont systemFontOfSize:12];
//        addressLabel.textAlignment = NSTextAlignmentRight;
//        [self addSubview:addressLabel];
//        
//        CGFloat shopNameLabelY = CGRectGetMaxY(shopNameLabel.frame) + 5*BOScreenH/1334;
//        UILabel *operationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, shopNameLabelY, 250 * BOWidthRate, 20 * BOHeightRate)];
//        self.operationLabel = operationLabel;
//        [operationLabel setFont:[UIFont systemFontOfSize:11]];
//        operationLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
//        [self addSubview:operationLabel];
//        // 添加典型客户的label
//        UILabel *clientLabel = [[UILabel alloc] init];
//        self.clientLabel = clientLabel;
//        clientLabel.frame = CGRectMake(15 * BOScreenW / BOPictureW, CGRectGetMaxY(_operationLabel.frame) + 15 * BOScreenH / BOPictureH, BOScreenW - 30 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH);
//                [self addSubview:clientLabel];
    }
    return self;
}
- (void)setItem:(PlatformServeDetailModel *)item {
    _item = item;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
//    // 拿到数据之后改变原来的frame
//    self.shopNameLabel.text = item.pname;
//    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    if (item.logo) {
        [self.bigImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
    }
    // 如果公司的图片为多张，设置为滚动图片
    // 得到banner图片的数据
    for (CompanyImageModel *imageUrl in item.com_img)
    {
        [self.bannersArr addObject:imageUrl.com_img];
    }
    if (self.bannersArr.count == 0)
    {
        self.topScrollView.hidden = YES;
        self.bigImage.hidden = NO;
//        _effectView.hidden = NO;
    }else
    {
        _topScrollView.imageURLStringsGroup = _bannersArr;//网络图
        self.topScrollView.hidden = NO;
        self.bigImage.hidden = YES;
//        _effectView.hidden = YES;
    }

    // 从新设置星星的frame
    //评级的星星
    //店名
    CGFloat bigImageY = CGRectGetMaxY(self.bigImage.frame)+75*BOScreenH/1334;
    UILabel *shopNameLabel = [[UILabel alloc]init];
    self.shopNameLabel = shopNameLabel;
    shopNameLabel.text = item.pname;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    CGSize size=[shopNameLabel.text sizeWithAttributes:attrs];
    [shopNameLabel setFrame:CGRectMake(30*BOScreenW/750, bigImageY, size.width, 40*BOScreenH/1334)];
    shopNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self addSubview:shopNameLabel];
    
    //评级的星星
    CGFloat shopNameLabelX = CGRectGetMaxX(shopNameLabel.frame)+14*BOScreenH/1334;
    for (int i = 0; i < 5; i++)
    {
        _starImage = [[UIImageView alloc]initWithFrame:CGRectMake(shopNameLabelX+i*(25*BOScreenW/750+6*BOScreenW/750), bigImageY+9*BOScreenH/1334, 25*BOScreenW/750, 25*BOScreenW/750)];
        _starImage.image = [UIImage imageNamed:@"common_score_d"];
        _starImage.highlightedImage = [UIImage imageNamed:@"common_score_h"];
        if (i < (int)([item.score floatValue] + 0.5)) {
            _starImage.highlighted = YES;
        }
        [self.starArrayM addObject:_starImage];
        [self addSubview:_starImage];
    }
    
    //评分
    CGFloat starImageX = CGRectGetMaxX(_starImage.frame) + 12*BOScreenW/750;
    UILabel *gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(starImageX, bigImageY+5*BOScreenH/1334, 80*BOScreenW/750, 40*BOScreenW/750)];
    self.gradeLabel = gradeLabel;
    gradeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    gradeLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:gradeLabel];
    
    //地址
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-180*BOScreenW/750, bigImageY+3*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenW/750)];
    self.addressLabel = addressLabel;
    addressLabel.text = @"浙江,杭州";
    addressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:addressLabel];
    
    CGFloat shopNameLabelY = CGRectGetMaxY(shopNameLabel.frame) + 5*BOScreenH/1334;
    UILabel *operationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, shopNameLabelY, 250 * BOWidthRate, 20 * BOHeightRate)];
    self.operationLabel = operationLabel;
    [operationLabel setFont:[UIFont systemFontOfSize:11]];
    operationLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [self addSubview:operationLabel];
    // 添加典型客户的label
    UILabel *clientLabel = [[UILabel alloc] init];
    self.clientLabel = clientLabel;
    clientLabel.frame = CGRectMake(15 * BOScreenW / BOPictureW, CGRectGetMaxY(_operationLabel.frame) + 15 * BOScreenH / BOPictureH, BOScreenW - 30 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH);
    [self addSubview:clientLabel];
//    for (int i = 0; i < (int)([item.score floatValue] + 0.5); i++) {
//        UIImageView *imageV = self.starArrayM[i];
//        imageV.highlighted = YES;
//    }
    self.gradeLabel.text = [NSString stringWithFormat:@"%d.0分",(int)([item.score floatValue] + 0.5)];
    self.addressLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng, item.shi];
    //运营 风控 服务 透明
   
    self.operationLabel.text = [NSString stringWithFormat:@"产品%@.0 · 功能%@.0 · 实力%@.0 · 服务%@.0",item.v1,item.v2,item.v3,item.v4];
    // 创建对应的富文本字典
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(57, 58, 60), NSForegroundColorAttributeName, nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(123, 124, 126),  NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attributeM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"典型客户：%@",item.example]];
    [attributeM setAttributes:dict1 range:NSMakeRange(0, 5)];
    [attributeM setAttributes:dict2 range:NSMakeRange(5, attributeM.length - 5)];
    self.clientLabel.attributedText = attributeM;

}
@end
