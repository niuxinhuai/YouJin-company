//
//  IpcView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformDetailsModel;
@interface IpcView : UIView
@property (nonatomic ,strong)UILabel *certificateLabel;//已获得证书
@property (nonatomic ,strong)UILabel *directorLabel;//中国互联网金融协会理事
@property (nonatomic ,strong)UILabel *websiteAddressLabel;//0571-86839575
@property (nonatomic ,strong)UILabel *markLabel;//微信公众号
@property (nonatomic ,strong)UIButton *thePublicButton;//微信公众号button
@property (nonatomic ,strong)UILabel *addressLabel;//地址

//@property (nonatomic ,strong)UIView *lineView;//监管协会上面的细线
//@property (nonatomic ,assign)CGFloat lineViewY;//监管协会的Y
@property (nonatomic ,strong)UIView *lineVi;//ipc经营许可证细线
@property (nonatomic ,strong)UIView *lineView;//监管协会的细线
@property (nonatomic ,strong)UIView *twoLineView;//客服电话的细线

@property (nonatomic ,strong)UIView *ipcView;//ipc经营许可证view
@property (nonatomic ,strong)UIView *regulationAssociationView;//监管协会view
@property (nonatomic ,strong)UIView *customerServiceView;//客服电话view
@property (nonatomic ,strong)UIView *weChatPublicView;//微信公众号
@property (nonatomic ,strong)UIView *addressView;//地址view
@property (nonatomic ,strong)PlatformDetailsModel *item;
@end
