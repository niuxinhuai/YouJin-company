//
//  nameView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "nameView.h"
#import "PlatformDetailsModel.h"
#import "NameAndIDmodel.h"
#import "CompanyImageModel.h"

@implementation nameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _xingxingArr = [NSMutableArray array];
        _backgroundArr = [NSMutableArray array];
        _bannersArr = [NSMutableArray array];
        _typeArr = [[NSMutableArray alloc]initWithObjects:@"",@"车贷",@"消费分期",@"供应链",@"房贷",@"企业贷",@"优选理财",@"票据抵押",@"融资租赁",@"藏品质押",@"个人信用贷",@"",@"",@"", nil];
        self.backgroundColor = [UIColor whiteColor];
        //大的图片log
        _bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 490*BOScreenH/1334)];
//        _bigImage.image = [UIImage imageNamed:@"pic_touxiang"];
        [self addSubview:_bigImage];
        //对大图片的毛玻璃效果
        _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:_blurEffect];
        _effectView.frame = _bigImage.bounds;
        _effectView.alpha = 0.98;
        [_bigImage addSubview:_effectView];
        
        //有banner图片数据的时候显示这个
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 490*BOScreenH/1334) delegate:nil placeholderImage:[UIImage imageNamed:@""]];
//        topScrollView.imageURLStringsGroup = _bannerImageArr;//网络图
        _topScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _topScrollView.showPageControl = NO;
        _topScrollView.autoScrollTimeInterval = 4;
        [self addSubview:_topScrollView];

        
        //中间的图片logo
        _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(315*BOScreenW/750, 420*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
//        _logoImage.image = [UIImage imageNamed:@"logo_youjin"];
        _logoImage.layer.cornerRadius = 9;
        //加阴影
        _logoImage.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.5].CGColor;//shadowColor阴影颜色
        _logoImage.layer.shadowOffset = CGSizeMake(1,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _logoImage.layer.shadowOpacity = 0.4;//阴影透明度，默认0
        _logoImage.layer.shadowRadius = 2;//阴影半径，默认3
        _logoImage.clipsToBounds = YES;
        [self addSubview:_logoImage];
        
        //店名
//        _bigImageY = CGRectGetMaxY(_bigImage.frame)+75*BOScreenH/1334;
        _shopNameLabel = [[UILabel alloc]init];
//        _shopNameLabel.text = @"             ";
//        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
//        CGSize size=[_shopNameLabel.text sizeWithAttributes:attrs];
//        [_shopNameLabel setFrame:CGRectMake(30*BOScreenW/750, 565*BOScreenH/1334, size.width, 40*BOScreenH/1334)];
        _shopNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:_shopNameLabel];
        
        //评级的星星
//        CGFloat shopNameLabelX = CGRectGetMaxX(_shopNameLabel.frame)+14*BOScreenH/1334;
        for (int i = 0; i < 5; i++)
        {
            _starImage = [[UIImageView alloc]init];
//            _starImage.image = [UIImage imageNamed:@"common_score_h"];
            [self addSubview:_starImage];
            [_xingxingArr addObject:_starImage];
        }
        
        //评分
//        CGFloat starImageX = CGRectGetMaxX(_starImage.frame) + 12*BOScreenW/750;
        _gradeLabel = [[UILabel alloc]init];
//        _gradeLabel.text = @"4.7分";
        _gradeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _gradeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_gradeLabel];
        
        //地址
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-180*BOScreenW/750, 565*BOScreenH/1334+3*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenW/750)];
//        _addressLabel.text = @"浙江,杭州";
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_addressLabel];
        
        //运营 风控 服务 透明
//        CGFloat shopNameLabelY = CGRectGetMaxY(_shopNameLabel.frame) + 5*BOScreenH/1334;
        _operationLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 610*BOScreenH/1334, 494*BOScreenW/750, 40*BOScreenW/750)];
//        _operationLabel.text = @"运营3.7 · 风控5.0 · 服务4.7 · 透明5.0";
        _operationLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _operationLabel.font = [UIFont systemFontOfSize:11];
        _operationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_operationLabel];
        
        //年化收益
        _operationLabelY = CGRectGetMaxY(_operationLabel.frame) + 12*BOScreenH/1334;
        _earningsNameLabel = [[UILabel alloc]init];
        _earningsNameLabel.text = @"年化收益:";
        NSDictionary *attrss = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize sizes = [_earningsNameLabel.text sizeWithAttributes:attrss];
        [_earningsNameLabel setFrame:CGRectMake(30*BOScreenW/750, _operationLabelY, sizes.width, 40*BOScreenH/1334)];
        _earningsNameLabel.font = [UIFont systemFontOfSize:13];
        _earningsNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:_earningsNameLabel];
        //8.00~12.00%
        CGFloat earningsNameLabelX = CGRectGetMaxX(_earningsNameLabel.frame)+10*BOScreenW/750;
        _percentageLabel = [[UILabel alloc]init];
        _percentageLabel.text = @"00.00~00.00%";
        NSDictionary *attrsss = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize sizess = [_percentageLabel.text sizeWithAttributes:attrsss];
        [_percentageLabel setFrame:CGRectMake(earningsNameLabelX, _operationLabelY+1*BOScreenH/1334, sizess.width, 40*BOScreenH/1334)];
        _percentageLabel.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
        [_percentageLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        [self addSubview:_percentageLabel];
        
        //业务类型
        CGFloat percentageLabelX = CGRectGetMaxX(_percentageLabel.frame) + 35*BOScreenW/750;
        _businessLabel = [[UILabel alloc]init];
        _businessLabel.text = @"业务类型:";
        NSDictionary *attrssss = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        _sizessss = [_businessLabel.text sizeWithAttributes:attrssss];
        [_businessLabel setFrame:CGRectMake(percentageLabelX, _operationLabelY, _sizessss.width, 40*BOScreenH/1334)];
        _businessLabel.font = [UIFont systemFontOfSize:13];
        _businessLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:_businessLabel];
        //供应链金融
        CGFloat businessLabelX = CGRectGetMaxX(_businessLabel.frame)+10*BOScreenW/750;
        _financialLabel = [[UILabel alloc]init];
        _financialLabel.text = @"供应链金融";
        NSDictionary *attrsssss = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize sizesssss = [_financialLabel.text sizeWithAttributes:attrsssss];
        [_financialLabel setFrame:CGRectMake(businessLabelX, _operationLabelY, sizesssss.width, 40*BOScreenH/1334)];
        _financialLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [_financialLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_financialLabel];
        //上市 国资
        //标签
        _tabLabel = [[UILabel alloc] init];
        _tabLabel.layer.cornerRadius = 4;
        _tabLabel.layer.masksToBounds = YES;
        _tabLabel.backgroundColor = [UIColor colorWithHexString:@"#3bb5f4" alpha:1];
        _tabLabel.textAlignment = NSTextAlignmentCenter;
        _tabLabel.textColor = [UIColor whiteColor];
        [_tabLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        [self addSubview:_tabLabel];
        //农业银行存管
//        CGFloat segmentedControlX = CGRectGetMaxX(_segmentedControl.frame)+10*BOScreenW/750;
        _depositLabel = [[UILabel alloc]init];
//        _depositLabel.text = @"农业银行存管";
        _depositLabel.layer.cornerRadius = 4;
        _depositLabel.layer.masksToBounds = YES;
        _depositLabel.backgroundColor = [UIColor colorWithHexString:@"#8fc31f" alpha:1];
        _depositLabel.textAlignment = NSTextAlignmentCenter;
        _depositLabel.textColor = [UIColor whiteColor];
        [_depositLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        [self addSubview:_depositLabel];
        
        //线view
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 800*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [self addSubview:lineView];
        
        //通知图片
        CGFloat lineViewY = CGRectGetMaxY(lineView.frame) + 17*BOScreenH/1334;
        UIImageView *informImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, lineViewY, 45*BOScreenW/750, 45*BOScreenW/750)];
        informImage.image = [UIImage imageNamed:@"icon_tongzhi"];
        [self addSubview:informImage];
        
        //积分隆重上线
        _integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, lineViewY+3*BOScreenH/1334, 560*BOScreenW/750, 40*BOScreenH/1334)];
//        _integralLabel.text = @"千店贷积分商城隆重上线！特惠兑换活动正式开始快快行动吧。";
        _integralLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _integralLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_integralLabel];
        
        //箭头
        UIImageView *arrowsImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, lineViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [self addSubview:arrowsImage];
        
        //积分商城按钮
        UIButton *informButton = [UIButton buttonWithType:UIButtonTypeCustom];
        informButton.frame = CGRectMake(85*BOScreenW/750, lineViewY-17*BOScreenH/1334, BOScreenW - 85*BOScreenW/750, 80*BOScreenH/1334);
        [self addSubview:informButton];
    }
    return self;
}
-(void)setItem:(PlatformDetailsModel *)item
{
    _item = item;
    //顶部的图片和bannertu
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    //得到banner图片的数据
    [_bannersArr removeAllObjects];
    for (CompanyImageModel *imageUrl in item.com_img)
    {
        [_bannersArr addObject:imageUrl.com_img];
    }
    if (_bannersArr.count == 0)
    {
        self.topScrollView.hidden = YES;
        self.bigImage.hidden = NO;
        _effectView.hidden = NO;
    }else
    {
        _topScrollView.imageURLStringsGroup = _bannersArr;//网络图
        self.topScrollView.hidden = NO;
        self.bigImage.hidden = YES;
        _effectView.hidden = YES;
    }
    
    //店名
    self.shopNameLabel.text = item.name;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    CGSize size=[_shopNameLabel.text sizeWithAttributes:attrs];
    [_shopNameLabel setFrame:CGRectMake(30*BOScreenW/750, 565*BOScreenH/1334, size.width, 40*BOScreenH/1334)];
    //星星的frame
    CGFloat shopNameLabelX = CGRectGetMaxX(_shopNameLabel.frame)+14*BOScreenH/1334;
    int xxNumber = (int)_xingxingArr.count;
    for (int i = 0; i < xxNumber; i++)
    {
        UIImageView *imag = _xingxingArr[i];
        imag.frame = CGRectMake(shopNameLabelX+i*(25*BOScreenW/750+6*BOScreenW/750), 565*BOScreenH/1334+9*BOScreenH/1334, 25*BOScreenW/750, 25*BOScreenW/750);
    }
    //评分的frame
    CGFloat starImageX = CGRectGetMaxX(_starImage.frame) + 12*BOScreenW/750;
    self.gradeLabel.frame = CGRectMake(starImageX, 565*BOScreenH/1334+5*BOScreenH/1334, 120*BOScreenW/750, 40*BOScreenW/750);
    self.gradeLabel.text = [NSString stringWithFormat:@"%@分",item.score];
    
    
    
    //设置星星的显示个数
//    int j = [item.score intValue]%6;
    int j = (int)([item.score floatValue]+0.5)/1;
    [self setCount:j];

    
    
    //设置地址
    self.addressLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng,item.shi];
    //设置运营 风控 服务 透明
    self.operationLabel.text = [NSString stringWithFormat:@"运营%@ · 风控%@ · 服务%@ · 透明%@",item.v1,item.v2,item.v3,item.v4];
    //年化收益
    self.percentageLabel.text = [NSString stringWithFormat:@"%@~%@%@",item.apr_min,item.apr_max,@"%"];
    //业务类型
    if (item.bus_model.length > 0)
    {
        _financialLabel.text = _typeArr[[item.bus_model intValue]];
    }else
    {
        _financialLabel.text = @"暂无信息";
    }
    [_backgroundArr removeAllObjects];
    //上市系 国资系
    for (NameAndIDmodel *nameid in item.bg_array)
    {
        [_backgroundArr addObject:nameid.name];
    }
    _earningsNameLabelY = CGRectGetMaxY(_earningsNameLabel.frame) + 25*BOScreenH/1334;
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:_backgroundArr];
//    _segmentedControl.frame = CGRectMake(30*BOScreenW/750, _earningsNameLabelY, 260*BOScreenW/750, 35*BOScreenH/1334);
    _segmentedControl.tintColor = [UIColor colorWithHexString:@"#3bb5f4" alpha:1];
    _segmentedControl.userInteractionEnabled = NO;
    UIFont *font = [UIFont boldSystemFontOfSize:11.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [_segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self addSubview:_segmentedControl];
    if (_backgroundArr.count == 0)
    {
        _segmentedControl.frame = CGRectMake(30*BOScreenW/750, _earningsNameLabelY, 0*BOScreenW/750, 35*BOScreenH/1334);
    }else if (_backgroundArr.count == 1)
    {
        _segmentedControl.frame = CGRectMake(30*BOScreenW/750, _earningsNameLabelY, 80*BOScreenW/750, 35*BOScreenH/1334);
    }else if (_backgroundArr.count == 2)
    {
        _segmentedControl.frame = CGRectMake(30*BOScreenW/750, _earningsNameLabelY, 160*BOScreenW/750, 35*BOScreenH/1334);
    }else
    {
        _segmentedControl.frame = CGRectMake(30*BOScreenW/750, _earningsNameLabelY, 240*BOScreenW/750, 35*BOScreenH/1334);
    }
    //标签
    CGFloat segmentedControlX = CGRectGetMaxX(_segmentedControl.frame);
    NSDictionary *attrsss = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:11]};
    CGSize sizes=[item.tab sizeWithAttributes:attrsss];
    if (item.tab.length > 0)
    {
        self.tabLabel.frame = CGRectMake(segmentedControlX, _earningsNameLabelY, sizes.width, 35*BOScreenH/1334);
        self.tabLabel.text = item.tab;
    }else
    {
        self.tabLabel.frame = CGRectMake(segmentedControlX, _earningsNameLabelY, 0, 35*BOScreenH/1334);
    }
    //设置银行存管
    CGFloat tabLabelX = CGRectGetMaxX(_tabLabel.frame) + 10*BOScreenW/750;
    if ([item.cgid intValue] > 0)
    {
        self.depositLabel.text = [NSString stringWithFormat:@"%@存管",item.cg_bank];
        NSDictionary *haha = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:11]};
        CGSize hehes =[self.depositLabel.text sizeWithAttributes:haha];
        self.depositLabel.frame = CGRectMake(tabLabelX, _earningsNameLabelY, hehes.width, 35*BOScreenH/1334);
    }else
    {
        self.depositLabel.frame = CGRectMake(tabLabelX, _earningsNameLabelY, 0, 35*BOScreenH/1334);
    }
    //公告
    if (item.down_url.length > 0)
    {
        //分隔字符串
        NSArray *integralArray = [item.down_url componentsSeparatedByString:@"|"];
        if (integralArray.count > 0)
        {
            if (integralArray.count == 1)
            {
                self.integralLabel.text = @"暂无平台新闻";
            }else
            {
                self.integralLabel.text = integralArray[0];
            }
        }else
        {
            self.integralLabel.text = @"暂无数据";
        }
    }else
    {
        self.integralLabel.text = @"暂无数据";
    }
    
    if ([_xffqStr isEqualToString:@"xiaofeifenqiPage"])
    {
        _earningsNameLabel.hidden = YES;
        _percentageLabel.hidden = YES;
        _businessLabel.text = @"分期类型:";
        [_businessLabel setFrame:CGRectMake(30*BOScreenW/750, _operationLabelY, _sizessss.width, 40*BOScreenH/1334)];
        CGFloat businessLabelXs = CGRectGetMaxX(_businessLabel.frame)+10*BOScreenW/750;
        [_financialLabel setFrame:CGRectMake(businessLabelXs, _operationLabelY, 400*BOScreenW/750, 40*BOScreenH/1334)];
        _financialLabel.text = self.xffqTypeString;
    }
}
#pragma mark---设置星星显示与隐藏---
- (void)setCount:(int)count
{
    int xingxCount = (int)_xingxingArr.count;
    
    for (int i = 0; i < xingxCount; i++)
    {
        UIImageView *round = _xingxingArr[i];
        if (i < count)
        {
            round.image = [UIImage imageNamed:@"evaluate_score_h"];
        } else
        {
            round.image = [UIImage imageNamed:@"evaluate_score_d"];
        }
    }
}

@end
