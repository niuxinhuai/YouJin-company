//
//  SecuritySystemView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SecuritySystemView.h"
#import "PlatformDetailsModel.h"

@implementation SecuritySystemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
         _typeArr = [[NSMutableArray alloc]initWithObjects:@"",@"车贷",@"消费分期",@"供应链",@"房贷",@"企业贷",@"优选理财",@"票据抵押",@"融资租赁",@"藏品质押",@"个人信用贷",@"",@"",@"", nil];

        //安全体系的view
        UIView *securitySystemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 328*BOScreenH/1334)];
        securitySystemView.backgroundColor = [UIColor whiteColor];
        [self addSubview:securitySystemView];
        
        //安全体系logo
        UIImageView *securitySystemImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        securitySystemImage.image = [UIImage imageNamed:@"icon_aqtx"];
        [securitySystemView addSubview:securitySystemImage];
        
        //安全体系
        UILabel *securitySystemLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
        securitySystemLabel.text = @"安全体系";
        securitySystemLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        securitySystemLabel.font = [UIFont systemFontOfSize:15];
        [securitySystemView addSubview:securitySystemLabel];
        
        //细线view
        UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        oneLineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [securitySystemView addSubview:oneLineView];
        
        //资金措施： 平安银行存管
        CGFloat oneLineViewY = CGRectGetMaxY(oneLineView.frame) + 30*BOScreenH/1334;
        _capitalMeasuresLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, oneLineViewY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _capitalMeasuresLabel.text = @"资金措施：平安银行存管";
        _capitalMeasuresLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _capitalMeasuresLabel.font = [UIFont systemFontOfSize:14];
        [securitySystemView addSubview:_capitalMeasuresLabel];
        
        //保障模式：平安银行担保，风险准备金5000万
        CGFloat capitalMeasuresLabelY = CGRectGetMaxY(_capitalMeasuresLabel.frame) + 31*BOScreenH/1334;
        _securityModelLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, capitalMeasuresLabelY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _securityModelLabel.text = @"保障模式：平安银行担保，风险准备金5000万";
        _securityModelLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _securityModelLabel.font = [UIFont systemFontOfSize:14];
        [securitySystemView addSubview:_securityModelLabel];
        
        //业务风控：专注于供应链金融业务
        CGFloat securityModelLabelY = CGRectGetMaxY(_securityModelLabel.frame) + 31*BOScreenH/1334;
        _businessControlLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, securityModelLabelY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _businessControlLabel.text = @"业务风控：专注于供应链金融业务";
        _businessControlLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _businessControlLabel.font = [UIFont systemFontOfSize:14];
        [securitySystemView addSubview:_businessControlLabel];
        
        //第一条粗线view
        CGFloat securitySystemViewY = CGRectGetMaxY(securitySystemView.frame);
        UIView *oneCoarseLineView = [[UIView alloc]initWithFrame:CGRectMake(0, securitySystemViewY, BOScreenW, 16*BOScreenH/1334)];
        oneCoarseLineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:oneCoarseLineView];
        
        //工商信息的View
        CGFloat oneCoarseLineViewY = CGRectGetMaxY(oneCoarseLineView.frame);
        UIView *commercialInformationView = [[UIView alloc]initWithFrame:CGRectMake(0, oneCoarseLineViewY, BOScreenW, 392*BOScreenH/1334)];
        commercialInformationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:commercialInformationView];
        
        //工商信息logo
        UIImageView *informationImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        informationImage.image = [UIImage imageNamed:@"icon_gsxx"];
        [commercialInformationView addSubview:informationImage];
        
        //工商信息
        UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
        informationLabel.text = @"工商信息";
        informationLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        informationLabel.font = [UIFont systemFontOfSize:15];
        [commercialInformationView addSubview:informationLabel];
        
        //细线view
        UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        twoLineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [commercialInformationView addSubview:twoLineView];
        
        //公司名称：杭州市千贷店互联网金融服务公司
        CGFloat twoLineViewY = CGRectGetMaxY(twoLineView.frame) + 30*BOScreenH/1334;
        _companyNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, twoLineViewY, BOScreenW - 60*BOScreenW/750, 40*BOScreenH/1334)];
//        _companyNameLabel.text = @"公司名称：杭州市千贷店互联网金融服务公司";
        _companyNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _companyNameLabel.font = [UIFont systemFontOfSize:14];
        [commercialInformationView addSubview:_companyNameLabel];
        
        //营业执照：11000000200001
        CGFloat companyNameLabelY = CGRectGetMaxY(_companyNameLabel.frame) + 31*BOScreenH/1334;
        _businessLicenseLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, companyNameLabelY, 400*BOScreenW/750, 40*BOScreenH/1334)];
//        _businessLicenseLabel.text = @"营业执照：11000000200001";
        _businessLicenseLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _businessLicenseLabel.font = [UIFont systemFontOfSize:14];
        [commercialInformationView addSubview:_businessLicenseLabel];
        
        //查看证件Button
        CGFloat businessLicenseLabelX = CGRectGetMaxX(_businessLicenseLabel.frame)+40*BOScreenW/750;
        UIButton *checkDocumentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkDocumentsButton.frame = CGRectMake(businessLicenseLabelX, companyNameLabelY-2*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [checkDocumentsButton setTitle:@"查看证件" forState:UIControlStateNormal];
        [checkDocumentsButton setTitleColor:[UIColor colorWithHexString:@"#4697fb" alpha:1] forState:UIControlStateNormal];
        checkDocumentsButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [commercialInformationView addSubview:checkDocumentsButton];
        
        //注册资本：1000万
        CGFloat businessLicenseLabelY = CGRectGetMaxY(_businessLicenseLabel.frame) + 31*BOScreenH/1334;
        _registeredCapitalLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, businessLicenseLabelY, 250*BOScreenW/750, 40*BOScreenH/1334)];
//        _registeredCapitalLabel.text = @"注册资本：1000万";
        _registeredCapitalLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _registeredCapitalLabel.font = [UIFont systemFontOfSize:14];
        [commercialInformationView addSubview:_registeredCapitalLabel];
        
        //实缴资本：800万
        CGFloat registeredCapitalLabelX = CGRectGetMaxX(_registeredCapitalLabel.frame) + 70*BOScreenH/1334;
        _contributedCapitalLabel = [[UILabel alloc]initWithFrame:CGRectMake(registeredCapitalLabelX, businessLicenseLabelY, 250*BOScreenW/750, 40*BOScreenH/1334)];
//        _contributedCapitalLabel.text = @"实缴资本：800万";
        _contributedCapitalLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _contributedCapitalLabel.font = [UIFont systemFontOfSize:14];
        [commercialInformationView addSubview:_contributedCapitalLabel];
        
        //法人代表：张三
        CGFloat registeredCapitalLabelY = CGRectGetMaxY(_registeredCapitalLabel.frame) + 31*BOScreenH/1334;
        _legalRepresentativeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, registeredCapitalLabelY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _legalRepresentativeLabel.text = @"法人代表：张三";
        _legalRepresentativeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _legalRepresentativeLabel.font = [UIFont systemFontOfSize:14];
        [commercialInformationView addSubview:_legalRepresentativeLabel];
        
        //第二条粗线view
        CGFloat commercialInformationViewY = CGRectGetMaxY(commercialInformationView.frame);
        UIView *twoCoarseLineView = [[UIView alloc]initWithFrame:CGRectMake(0, commercialInformationViewY, BOScreenW, 16*BOScreenH/1334)];
        twoCoarseLineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:twoCoarseLineView];
        
        //股东结构view
        CGFloat twoCoarseLineViewY = CGRectGetMaxY(twoCoarseLineView.frame);
        UIView *shareholderStructureView = [[UIView alloc]initWithFrame:CGRectMake(0, twoCoarseLineViewY, BOScreenW, 190*BOScreenH/1334)];
        shareholderStructureView.backgroundColor = [UIColor whiteColor];
        [self addSubview:shareholderStructureView];
        
        //股东结构logo
        UIImageView *shareholdersImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        shareholdersImage.image = [UIImage imageNamed:@"icon_gdjg"];
        [shareholderStructureView addSubview:shareholdersImage];
        
        //股东结构
        UILabel *shareholdersLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 160*BOScreenW/750, 40*BOScreenH/1334)];
        shareholdersLabel.text = @"股东结构";
        shareholdersLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        shareholdersLabel.font = [UIFont systemFontOfSize:15];
        [shareholderStructureView addSubview:shareholdersLabel];
        
        //股东结构的箭头
        UIImageView *structureImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, 30*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        structureImages.image = [UIImage imageNamed:@"common_goto"];
        [shareholderStructureView addSubview:structureImages];
        
        //查看股东族谱
        UILabel *familyTreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-365*BOScreenW/750, 25*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
        familyTreeLabel.text = @"查看股东族谱";
        familyTreeLabel.textAlignment = NSTextAlignmentRight;
        familyTreeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        familyTreeLabel.font = [UIFont systemFontOfSize:12];
        [shareholderStructureView addSubview:familyTreeLabel];
        
        //查看股东族谱button
        _familyTreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _familyTreeButton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        [shareholderStructureView addSubview:_familyTreeButton];
        
        //线view
        UIView *threelineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        threelineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [shareholderStructureView addSubview:threelineView];
        
        //疑似实际股权控制人：张三
        CGFloat threelineViewY = CGRectGetMaxY(threelineView.frame) + 30*BOScreenH/1334;
        _actualLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, threelineViewY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _actualLabel.text = @"疑似实际股权控制人：张三";
        _actualLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _actualLabel.font = [UIFont systemFontOfSize:14];
        [shareholderStructureView addSubview:_actualLabel];
        
        //第三条粗线view
        CGFloat shareholderStructureViewY = CGRectGetMaxY(shareholderStructureView.frame);
        UIView *threeCoarseLineView = [[UIView alloc]initWithFrame:CGRectMake(0, shareholderStructureViewY, BOScreenW, 16*BOScreenH/1334)];
        threeCoarseLineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:threeCoarseLineView];
        
        //备案信息的view
        CGFloat threeCoarseLineViewY = CGRectGetMaxY(threeCoarseLineView.frame);
        UIView *recordInformationView = [[UIView alloc]initWithFrame:CGRectMake(0, threeCoarseLineViewY, BOScreenW, 328*BOScreenH/1334)];
        recordInformationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:recordInformationView];
        
        //备案信息logo
        UIImageView *recordImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        recordImage.image = [UIImage imageNamed:@"icon_baxx"];
        [recordInformationView addSubview:recordImage];
        
        //备案信息
        UILabel *recordLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
        recordLabel.text = @"备案信息";
        recordLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        recordLabel.font = [UIFont systemFontOfSize:15];
        [recordInformationView addSubview:recordLabel];
        
        //细线view
        UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        fourLineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [recordInformationView addSubview:fourLineView];
        
        //ICP备案：京ICP备200903003
        CGFloat fourLineViewY = CGRectGetMaxY(fourLineView.frame) + 30*BOScreenH/1334;
        _icprecordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, fourLineViewY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _icprecordLabel.text = @"ICP备案：京ICP备200903003";
        _icprecordLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _icprecordLabel.font = [UIFont systemFontOfSize:14];
        [recordInformationView addSubview:_icprecordLabel];
        
        //ICP证书：京ICP备200903003
        CGFloat icprecordLabelY = CGRectGetMaxY(_icprecordLabel.frame) + 31*BOScreenH/1334;
        _icpCertificateLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, icprecordLabelY, 400*BOScreenW/750, 40*BOScreenH/1334)];
//        _icpCertificateLabel.text = @"ICP证书：京ICP备200903003";
        _icpCertificateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _icpCertificateLabel.font = [UIFont systemFontOfSize:14];
        [recordInformationView addSubview:_icpCertificateLabel];
        
        //查看证件Button
        CGFloat icpCertificateLabelX = CGRectGetMaxX(_icpCertificateLabel.frame)+20*BOScreenW/750;
        UIButton *twoCheckDocumentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        twoCheckDocumentsButton.frame = CGRectMake(icpCertificateLabelX, icprecordLabelY-2*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [twoCheckDocumentsButton setTitle:@"查看证件" forState:UIControlStateNormal];
        [twoCheckDocumentsButton setTitleColor:[UIColor colorWithHexString:@"#4697fb" alpha:1] forState:UIControlStateNormal];
        twoCheckDocumentsButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [recordInformationView addSubview:twoCheckDocumentsButton];
        
        //公安备案：11000002000001
        CGFloat icpCertificateLabelY = CGRectGetMaxY(_icpCertificateLabel.frame) + 31*BOScreenH/1334;
        _therecordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, icpCertificateLabelY, BOScreenW - 70*BOScreenW/750, 40*BOScreenH/1334)];
//        _therecordLabel.text = @"公安备案：110000020000001";
        _therecordLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _therecordLabel.font = [UIFont systemFontOfSize:14];
        [recordInformationView addSubview:_therecordLabel];
        
        //第四条粗线view
        CGFloat recordInformationViewY = CGRectGetMaxY(recordInformationView.frame);
        UIView *fourCoarseLineView = [[UIView alloc]initWithFrame:CGRectMake(0, recordInformationViewY, BOScreenW, 16*BOScreenH/1334)];
        fourCoarseLineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:fourCoarseLineView];
        
        //运营团队
        CGFloat fourCoarseLineViewY = CGRectGetMaxY(fourCoarseLineView.frame);
        UIView *operatingView = [[UIView alloc] initWithFrame:CGRectMake(0, fourCoarseLineViewY, BOScreenW, 90*BOScreenH/1334)];
        operatingView.backgroundColor = [UIColor whiteColor];
        [self addSubview:operatingView];
        
        //运营团队logo
        UIImageView *operatingImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        operatingImage.image = [UIImage imageNamed:@"icon_yytd"];
        [operatingView addSubview:operatingImage];
        
        //运营团队
        UILabel *operatingLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
        operatingLabel.text = @"运营团队";
        operatingLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        operatingLabel.font = [UIFont systemFontOfSize:15];
        [operatingView addSubview:operatingLabel];
        
//        //细线view
//        UIView *endLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
//        endLineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
//        [operatingView addSubview:endLineView];
    }
    return self;
}
-(void)setItem:(PlatformDetailsModel *)item
{
    _item = item;
    self.capitalMeasuresLabel.text = [NSString stringWithFormat:@"资金措施：%@存管",item.cg_bank];
    //字体显示两种颜色
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"资金措施：%@存管",item.cg_bank]];
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@存管",item.cg_bank]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@存管",item.cg_bank]].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:redRangeTwo];
    [_capitalMeasuresLabel setAttributedText:noteStr];
    [_capitalMeasuresLabel sizeToFit];
    
    self.securityModelLabel.text = [NSString stringWithFormat:@"保障模式：%@",item.bz_model];
    //字体显示两种颜色
    NSMutableAttributedString *twonoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"保障模式：%@",item.bz_model]];
    NSRange tworedRangeTwo = NSMakeRange([[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.bz_model]].location, [[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.bz_model]].length);
    [twonoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:tworedRangeTwo];
    [_securityModelLabel setAttributedText:twonoteStr];
    [_securityModelLabel sizeToFit];
    

    if (item.bus_model.length > 0)
    {
        self.businessControlLabel.text = [NSString stringWithFormat:@"业务风控：专注于%@业务",_typeArr[[item.bus_model intValue]]];
        //字体显示两种颜色
        NSMutableAttributedString *threenoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"业务风控：专注于%@业务",_typeArr[[item.bus_model intValue]]]];
        NSRange threeredRangeTwo = NSMakeRange([[threenoteStr string] rangeOfString:[NSString stringWithFormat:@"专注于%@业务",_typeArr[[item.bus_model intValue]]]].location, [[threenoteStr string] rangeOfString:[NSString stringWithFormat:@"专注于%@业务",_typeArr[[item.bus_model intValue]]]].length);
        [threenoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:threeredRangeTwo];
        [_businessControlLabel setAttributedText:threenoteStr];
        [_businessControlLabel sizeToFit];
    }else
    {
        self.businessControlLabel.text = @"暂无信息";
    }
  
//=======
//    self.businessControlLabel.text = [NSString stringWithFormat:@"业务风控：专注于%@业务",_typeArr[[item.bus_model intValue]]];
//    //字体显示两种颜色
//    NSMutableAttributedString *threenoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"业务风控：专注于%@业务",_typeArr[[item.bus_model intValue]]]];
//    NSRange threeredRangeTwo = NSMakeRange([[threenoteStr string] rangeOfString:[NSString stringWithFormat:@"专注于%@业务",_typeArr[[item.bus_model intValue]]]].location, [[threenoteStr string] rangeOfString:[NSString stringWithFormat:@"专注于%@业务",_typeArr[[item.bus_model intValue]]]].length);
//    [threenoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:threeredRangeTwo];
//    [_businessControlLabel setAttributedText:threenoteStr];
//    [_businessControlLabel sizeToFit];
//>>>>>>> Stashed changes
    
    self.companyNameLabel.text = [NSString stringWithFormat:@"公司名称：%@",item.company_name];
    //字体显示两种颜色
    NSMutableAttributedString *fournoteStri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"公司名称：%@",item.company_name]];
    NSRange fourredRangeTwo = NSMakeRange([[fournoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.company_name]].location, [[fournoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.company_name]].length);
    [fournoteStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:fourredRangeTwo];
    [_companyNameLabel setAttributedText:fournoteStri];
//    [_companyNameLabel sizeToFit];
    
    self.businessLicenseLabel.text = [NSString stringWithFormat:@"营业执照：%@",item.com_reg_num];
    //字体显示两种颜色
    NSMutableAttributedString *fivenoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"营业执照：%@",item.com_reg_num]];
    NSRange fiveredRangeTwo = NSMakeRange([[fivenoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.com_reg_num]].location, [[fivenoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.com_reg_num]].length);
    [fivenoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:fiveredRangeTwo];
    [_businessLicenseLabel setAttributedText:fivenoteStr];
    [_businessLicenseLabel sizeToFit];
    
    self.registeredCapitalLabel.text = [NSString stringWithFormat:@"注册资本：%@万",item.reg_money];
    //字体显示两种颜色
    NSMutableAttributedString *sixnoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"注册资本：%@万",item.reg_money]];
    NSRange sixredRangeTwo = NSMakeRange([[sixnoteStr string] rangeOfString:[NSString stringWithFormat:@"%@万",item.reg_money]].location, [[sixnoteStr string] rangeOfString:[NSString stringWithFormat:@"%@万",item.reg_money]].length);
    [sixnoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:sixredRangeTwo];
    [_registeredCapitalLabel setAttributedText:sixnoteStr];
    [_registeredCapitalLabel sizeToFit];
    
    self.contributedCapitalLabel.text = [NSString stringWithFormat:@"实缴资本：%@万",item.real_money];
    //字体显示两种颜色
    NSMutableAttributedString *eightnoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"实缴资本：%@万",item.real_money]];
    NSRange eightredRangeTwo = NSMakeRange([[eightnoteStr string] rangeOfString:[NSString stringWithFormat:@"%@万",item.real_money]].location, [[eightnoteStr string] rangeOfString:[NSString stringWithFormat:@"%@万",item.real_money]].length);
    [eightnoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:eightredRangeTwo];
    [_contributedCapitalLabel setAttributedText:eightnoteStr];
    [_contributedCapitalLabel sizeToFit];
    
    self.legalRepresentativeLabel.text = [NSString stringWithFormat:@"法人代表：%@",item.legal_person];
    //字体显示两种颜色
    NSMutableAttributedString *sevennoteStri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"法人代表：%@",item.legal_person]];
    NSRange sevenredRangeTwo = NSMakeRange([[sevennoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.legal_person]].location, [[sevennoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.legal_person]].length);
    [sevennoteStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:sevenredRangeTwo];
    [_legalRepresentativeLabel setAttributedText:sevennoteStri];
    [_legalRepresentativeLabel sizeToFit];
    
    self.actualLabel.text = [NSString stringWithFormat:@"疑似实际股权控制人：%@",item.big_boss]; //字体显示两种颜色
    NSMutableAttributedString *ninenoteStri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"疑似实际股权控制人：%@",item.big_boss]];
    NSRange nineredRangeTwo = NSMakeRange([[ninenoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.big_boss]].location, [[ninenoteStri string] rangeOfString:[NSString stringWithFormat:@"%@",item.big_boss]].length);
    [ninenoteStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:nineredRangeTwo];
    [_actualLabel setAttributedText:ninenoteStri];
    [_actualLabel sizeToFit];
    
    self.icprecordLabel.text = [NSString stringWithFormat:@"ICP备案：%@",item.icp_beian];
    //字体显示两种颜色
    NSMutableAttributedString *tennoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"ICP备案：%@",item.icp_beian]];
    NSRange tenredRangeTwo = NSMakeRange([[tennoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.icp_beian]].location, [[tennoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.icp_beian]].length);
    [tennoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:tenredRangeTwo];
    [_icprecordLabel setAttributedText:tennoteStr];
    [_icprecordLabel sizeToFit];
    
    self.icpCertificateLabel.text = [NSString stringWithFormat:@"ICP证书：%@",item.icp_xuke];
    //字体显示两种颜色
    NSMutableAttributedString *elevennoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"ICP证书：%@",item.icp_xuke]];
    NSRange elevenredRangeTwo = NSMakeRange([[elevennoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.icp_xuke]].location, [[elevennoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.icp_xuke]].length);
    [elevennoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:elevenredRangeTwo];
    [_icpCertificateLabel setAttributedText:elevennoteStr];
    [_icpCertificateLabel sizeToFit];
    
    self.therecordLabel.text = [NSString stringWithFormat:@"公安备案：%@",item.police_beian];
    //字体显示两种颜色
    NSMutableAttributedString *twelvenoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"公安备案：%@",item.police_beian]];
    NSRange twelveredRangeTwo = NSMakeRange([[twelvenoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.police_beian]].location, [[twelvenoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",item.police_beian]].length);
    [twelvenoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#737373" alpha:1] range:twelveredRangeTwo];
    [_therecordLabel setAttributedText:twelvenoteStr];
    [_therecordLabel sizeToFit];
}
@end
