//
//  IpcView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IpcView.h"
#import "PlatformDetailsModel.h"

@implementation IpcView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        //ipc经营许可证view
        _ipcView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334)];
        _ipcView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_ipcView];
        //线view
        _lineVi = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        _lineVi.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_ipcView addSubview:_lineVi];
        //ipc经营许可证图片
        UIImageView *ipcImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        ipcImage.image = [UIImage imageNamed:@"icon_jyxk"];
        [_ipcView addSubview:ipcImage];
        //ipc经营许可证
        UILabel *ipcLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334)];
        ipcLabel.text = @"IPC经营许可证";
        ipcLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        ipcLabel.font = [UIFont systemFontOfSize:14];
        [_ipcView addSubview:ipcLabel];
        //已获得证书
        _certificateLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW - 190*BOScreenW/750, 25*BOScreenH/1334, 160*BOScreenW/750, 40*BOScreenH/1334)];
//        _certificateLabel.text = @"已获得证书";
        _certificateLabel.textAlignment = NSTextAlignmentRight;
        _certificateLabel.textColor = [UIColor colorWithHexString:@"#54c9a1" alpha:1];
        _certificateLabel.font = [UIFont systemFontOfSize:12];
        [_ipcView addSubview:_certificateLabel];
        
        
        //监管协会view
        _regulationAssociationView = [[UIView alloc]initWithFrame:CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _regulationAssociationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_regulationAssociationView];
        //线view
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_regulationAssociationView addSubview:_lineView];
        //监管协会图片
        CGFloat lineViewY = CGRectGetMaxY(_lineView.frame) + 25*BOScreenH/1334;
        UIImageView *associationImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, lineViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        associationImage.image = [UIImage imageNamed:@"icon_jgxh"];
        [_regulationAssociationView addSubview:associationImage];
        //监管协会
        UILabel *associationLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, lineViewY, 120*BOScreenW/750, 40*BOScreenH/1334)];
        associationLabel.text = @"监管协会";
        associationLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        associationLabel.font = [UIFont systemFontOfSize:14];
        [_regulationAssociationView addSubview:associationLabel];
        //中国互联网金融协会理事
        _directorLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW - 330*BOScreenW/750, lineViewY, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        _directorLabel.text = @"中国互联网金融协会理事";
        _directorLabel.textAlignment = NSTextAlignmentRight;
        _directorLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _directorLabel.font = [UIFont systemFontOfSize:12];
        [_regulationAssociationView addSubview:_directorLabel];

        
        //客服电话view
        _customerServiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 180*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _customerServiceView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_customerServiceView];
        //线view
        _twoLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        _twoLineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_customerServiceView addSubview:_twoLineView];
        //客服电话图片
        CGFloat twoLineViewY = CGRectGetMaxY(_twoLineView.frame) + 25*BOScreenH/1334;
        UIImageView *customerImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, twoLineViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        customerImage.image = [UIImage imageNamed:@"icon_kfdh"];
        [_customerServiceView addSubview:customerImage];
        //客服电话
        UILabel *customerLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, twoLineViewY, 120*BOScreenW/750, 40*BOScreenH/1334)];
        customerLabel.text = @"客服电话";
        customerLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        customerLabel.font = [UIFont systemFontOfSize:14];
        [_customerServiceView addSubview:customerLabel];
        //客服电话的箭头
        UIImageView *websiteImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, twoLineViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        websiteImages.image = [UIImage imageNamed:@"common_goto"];
        [_customerServiceView addSubview:websiteImages];
        //0571-86839575
        _websiteAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-365*BOScreenW/750, twoLineViewY, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        _websiteAddressLabel.text = @"0571-86839575";
        _websiteAddressLabel.textAlignment = NSTextAlignmentRight;
        _websiteAddressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _websiteAddressLabel.font = [UIFont systemFontOfSize:12];
        [_customerServiceView addSubview:_websiteAddressLabel];
        //客服电话button
        UIButton *customerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customerButton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        [customerButton addTarget:self action:@selector(customerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_customerServiceView addSubview:customerButton];
        
        
        //微信公众号view
        _weChatPublicView = [[UIView alloc]initWithFrame:CGRectMake(0, 270*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _weChatPublicView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_weChatPublicView];
        //线view
        UIView *threeLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        threeLineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_weChatPublicView addSubview:threeLineView];
        //微信公众号logo
        CGFloat threeLineViewY = CGRectGetMaxY(threeLineView.frame) + 25*BOScreenH/1334;
        UIImageView *thePublicImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, threeLineViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        thePublicImage.image = [UIImage imageNamed:@"icon_wxgzh"];
        [_weChatPublicView addSubview:thePublicImage];
        //微信公众号
        UILabel *thePublicLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, threeLineViewY, 160*BOScreenW/750, 40*BOScreenH/1334)];
        thePublicLabel.text = @"微信公众号";
        thePublicLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        thePublicLabel.font = [UIFont systemFontOfSize:14];
        [_weChatPublicView addSubview:thePublicLabel];
        //微信公众号的箭头
        UIImageView *publicImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, threeLineViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        publicImages.image = [UIImage imageNamed:@"common_goto"];
        [_weChatPublicView addSubview:publicImages];
        //hangzhouyoujinkejigongsi
        _markLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-365*BOScreenW/750, threeLineViewY, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        _markLabel.text = @"hangzhouyoujinkejigongsi";
        _markLabel.textAlignment = NSTextAlignmentRight;
        _markLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _markLabel.font = [UIFont systemFontOfSize:12];
        [_weChatPublicView addSubview:_markLabel];
        //微信公众号button
        _thePublicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thePublicButton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        [_weChatPublicView addSubview:_thePublicButton];
        
        
        //地址view
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 360*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _addressView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addressView];
        //线view
        UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        fourLineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_addressView addSubview:fourLineView];
        //地址logo
        CGFloat fourLineViewY = CGRectGetMaxY(fourLineView.frame) + 25*BOScreenH/1334;
        UIImageView *addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, fourLineViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        addressImage.image = [UIImage imageNamed:@"icon_locate"];
        [_addressView addSubview:addressImage];
        //地址
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, fourLineViewY, 550*BOScreenW/750, 40*BOScreenH/1334)];
//        _addressLabel.text = @"杭州市江干区风起东路新达城大厦506室柚今科技";
        _addressLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        [_addressView addSubview:_addressLabel];
        //地址的箭头
        UIImageView *addressBoultImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, fourLineViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        addressBoultImages.image = [UIImage imageNamed:@"common_goto"];
        [_addressView addSubview:addressBoultImages];
        //地址button
        UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addressButton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        [_addressView addSubview:addressButton];
    }
    return self;
}
-(void)setItem:(PlatformDetailsModel *)item
{
    _item = item;
    //ipc经营许可证view
    if (item.icp_xuke.length > 0)
    {
       self.certificateLabel.text = @"已获得证书";
    }else
    {
        _ipcView.hidden = YES;
        _lineView.hidden = YES;
        _regulationAssociationView.frame = CGRectMake(0, 0*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _customerServiceView.frame = CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _weChatPublicView.frame = CGRectMake(0, 180*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _addressView.frame = CGRectMake(0, 270*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
    }
    //监管协会view
    if (item.jianguan.length > 0)
    {
        self.directorLabel.text = item.jianguan;
    }else
    {
        _regulationAssociationView.hidden = YES;
        _customerServiceView.frame = CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _weChatPublicView.frame = CGRectMake(0, 180*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _addressView.frame = CGRectMake(0, 270*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
    }
    if (item.jianguan.length == 0 && item.icp_xuke.length == 0)
    {
        _ipcView.hidden = YES;
        _regulationAssociationView.hidden = YES;
        _twoLineView.hidden = YES;
        _customerServiceView.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        _weChatPublicView.frame = CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        _addressView.frame = CGRectMake(0, 180*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
    }
    
    self.websiteAddressLabel.text = item.serve_mobile;
    self.markLabel.text = item.public_weixin;
    self.addressLabel.text = item.addr;
}
#pragma mark---拨打客服电话的点击事件---
- (void)customerButtonClick
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.websiteAddressLabel.text];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}
@end
