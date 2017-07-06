//
//  PlatformServeDetailVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServeDetailVC.h"
#import "PlatfromServeTopView.h"
#import "BOLcationButton.h"
#import "DetailNoPictureCellTableViewCell.h"
#import "DetailOnePictureCell.h"
#import "DetailOtherPictureCell.h"
#import <MJExtension/MJExtension.h>
#import "BODynamicItem.h"
#import "PlatformDetailViewModel.h"
#import "PlatformServeDetailModel.h"
#import "BOWebViewController.h"
static NSString *const NOPictureID = @"noPicturecell";
static NSString *const OnePictureID = @"onePicturecell";
static NSString *const OtherPictureID = @"otherPicturecell";
@interface PlatformServeDetailVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

/**详情scrollView*/
@property (nonatomic, strong) UIScrollView *detailScrollView;

/**展示其他产品的View*/
@property (nonatomic, strong) UIView *otherProductView;

/**展开显示全文的按钮*/
@property (nonatomic, strong) UIButton *wholeBtn;

/**标记全文按钮是否创建*/
@property (nonatomic, assign) BOOL btnFlag;

/**记录介绍公司View的高度*/
@property (nonatomic, assign) CGFloat introduceHeight;

/**显示公司简介内容的label*/
@property (nonatomic, strong) UILabel *introLabel;

/**显示简介公司整个的View*/
@property (nonatomic, strong) UIView *introduceView;

/**展示公司简介label下部的View*/
@property (nonatomic, strong) UIView *contentView;

/**根据文字大小以及行距计算出的行高*/
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, strong) NSMutableArray *detailVM;

/**底部的tableView*/
@property (nonatomic, weak) UITableView *detailTableView;
@property (nonatomic, strong) UITableViewCell *cell;

/**记录用户点评的View*/
@property (nonatomic, weak) UIView *indicatorView;

/**记录tableView的高度*/
@property (nonatomic, assign) CGFloat detailHeight;

/**返回的按钮*/
@property (nonatomic, weak) UIButton *returnButton;


/**毛玻璃的View*/
@property (nonatomic, strong) UIVisualEffectView *effectView;

/**scrollView滚动offestY*/
@property (nonatomic, assign) CGFloat offestY;

@property (nonatomic, weak) UIButton *backBtn;

@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**点评的数据*/
@property (nonatomic, strong) NSMutableArray *dataArrayM;
/**公司的数据*/
@property (nonatomic, strong) PlatformServeDetailModel *item;
/**引用PlatfromServeTopView*/
@property (nonatomic, weak) PlatfromServeTopView *platformTopView;

/**存放官网点击的按钮*/
@property (nonatomic, weak) BOLcationButton *websiteBtn;

/**显示其他商品的label*/
@property (nonatomic, weak) UILabel *otherLabel;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *businessLabel;

@property (nonatomic, weak) UILabel *addressLabel;

/**保存公司点评的数组*/
@property (nonatomic, strong) NSMutableArray *commentArrayM;

/**上传第一条评论的View*/
@property (nonatomic, weak) UIView *reviewView;

@end

@implementation PlatformServeDetailVC
#pragma mark - 懒加载
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}
- (NSMutableArray *)commentArrayM {
    if (_commentArrayM == nil) {
        _commentArrayM = [NSMutableArray array];
    }
    return _commentArrayM;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
#pragma mark - 懒加载dynamicVM
- (NSMutableArray *)detailVM {
    if (_detailVM == nil) {
        _detailVM = [NSMutableArray array];
    }
    return _detailVM;
}

#pragma mark - 懒加载detailScrollView
- (UIScrollView *)detailScrollView {
    if (_detailScrollView == nil) {
        _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, BOScreenW, BOScreenH + 20)];
        _detailScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _detailScrollView.showsVerticalScrollIndicator = NO;
        _detailScrollView.delegate = self;
        _detailScrollView.contentSize = CGSizeMake(0, 1000);
        [self.view addSubview:_detailScrollView];
    }
    return _detailScrollView;
}
#pragma mark - View的加载已经即将显示的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //请求公司数据
    [self requstNetData];
    //请求公司点评数据
    [self requstBottomCommentData];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    // 从plist中加载测试数据
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DynamicView.plist" ofType:nil]];
    NSArray *tempArray = [BODynamicItem mj_objectArrayWithKeyValuesArray:dictArray];
    // 遍历数组获取数据
    for (BODynamicItem *item in tempArray) {
        PlatformDetailViewModel *VM = [[PlatformDetailViewModel alloc] init];
        VM.item = item;
        self.detailHeight += VM.cellH;
        [self.detailVM addObject:VM];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
//    
//    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"重置登录密码"];
//    self.navigationItem.titleView = titleView;
//    
//    // 设置rightButtonItem
//    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_fenxiangs"] title:nil titleColor:[UIColor whiteColor] target:self action:@selector(pushNextPage)];
//    self.navigationItem.rightBarButtonItem = rightBtnItem;

}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - push下一个界面
- (void)pushNextPage {
   
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.navigationController.navigationBar.alpha = 0.01;
    self.view.bounds = CGRectMake(0, 0, BOScreenW, BOScreenH + 24 * BOHeightRate);
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    // 请求最新点评的数据
    NSString *rankString = [NSString stringWithFormat:@"%@WdApi/serviceCompanyInfo",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"svid"] = self.svid;
    [self.mgr POST:rankString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 根据数据创建控件
//        [self addChildViewForScrollView];
        self.item = [PlatformServeDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self addChildViewForScrollView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - 添加detailScrollView
- (void)setupDetailScrollView {
    [self.view addSubview:self.detailScrollView];
    
}
#pragma mark - 为scrollView添加子控件
- (void)addChildViewForScrollView {
    // 添加顶部的View
    [self setTopView];
    // 添加显示进入官网的View
    [self setupShowOfficialWebsite];
    // 添加显示其他产品的View
    [self setupShowOtherProductView];
    // 添加介绍公司的View
    [self setupIntroduceCompanyView];
}
#pragma mark - 添加scrollView的topView
- (void)setTopView {
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 370 * BOScreenH / BOPictureH;
    PlatfromServeTopView *platformTopView = [[PlatfromServeTopView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    self.platformTopView = platformTopView;
    self.platformTopView.item = self.item;
    [self.detailScrollView addSubview:platformTopView];
}

#pragma mark - 显示官网及其跳转的View
- (void)setupShowOfficialWebsite {
    // 创建显示官网跳转的View
    CGFloat websiteX = 0;
    CGFloat websiteY = 378 * BOScreenH / BOPictureH;
    CGFloat websiteW = BOScreenW;
    CGFloat websiteH = 45 * BOScreenH / BOPictureH;
    UIView *websiteView = [[UIView alloc] initWithFrame:CGRectMake(websiteX, websiteY, websiteW, websiteH)];
    websiteView.backgroundColor = [UIColor whiteColor];
    
    [self.detailScrollView addSubview:websiteView];
    // 添加图标
    CGFloat iconX = 15 * BOScreenW / BOPictureW;
    CGFloat iconY = 12.5 * BOScreenH / BOPictureH;
    CGFloat iconWH = 20 * BOScreenW / BOPictureW;
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
    iconImageV.image = [UIImage imageNamed:@"tabbar_home_pre"];
    [websiteView addSubview:iconImageV];
    // 添加官网label
    CGFloat weblX = 44 * BOScreenW/ BOPictureW;
    CGFloat weblY = iconY;
    CGFloat weblW = 40 * BOPictureW / BOPictureW;
    CGFloat weblH = iconWH;
    UILabel *websiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(weblX, weblY, weblW, weblH)];
    websiteLabel.text = @"官网";
    [websiteLabel setTextColor:BOColor(50, 52, 53)];
    [websiteLabel setFont:[UIFont systemFontOfSize:14]];
    [websiteView addSubview:websiteLabel];
    // 创建官网点击的按钮
    CGFloat btnX = 185 * BOScreenW / BOPictureW;
    CGFloat btnY = iconY;
    CGFloat btnW = 180* BOScreenW / BOPictureW;
    CGFloat btnH = 20 * BOScreenH / BOPictureH;
    BOLcationButton *websiteBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    self.websiteBtn = websiteBtn;
    [websiteBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [websiteBtn setTitle:@"renyunkeji.com" forState:UIControlStateNormal];
    [websiteBtn setTitleColor:BOColor(130, 131, 132) forState:UIControlStateNormal];
    [websiteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    websiteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [websiteBtn addTarget:self action:@selector(websiteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [websiteView addSubview:websiteBtn];
    [self.websiteBtn setTitle:self.item.url forState:UIControlStateNormal];
    

}
#pragma mark - 官网点击的跳转页面
- (void)websiteBtnClick {
    BOWebViewController *webVC = [[BOWebViewController alloc] init];
    webVC.urlString = self.item.url;
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - 展示其他产品的View
- (void)setupShowOtherProductView {
    // 给展示的内容赋值
    NSString *showString = self.item.other_pro;
    // 创建对应的行间距
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    // 创建富文本对应的字典
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, BOColor(178, 179, 180),NSForegroundColorAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    // 计算不确定文字对应的高度
    CGFloat height = [showString boundingRectWithSize:CGSizeMake(BOScreenW - 35 * BOScreenW / BOPictureW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    // 创建显示其他产品跳转的View
    CGFloat otherX = 0;
    CGFloat otherY = 430 * BOScreenH / BOPictureH;
    CGFloat otherW = BOScreenW;
    CGFloat otherH = (65 + height) * BOScreenH / BOPictureH;
    UIView *otherProductView = [[UIView alloc] initWithFrame:CGRectMake(otherX, otherY, otherW, otherH)];
    otherProductView.backgroundColor = [UIColor whiteColor];
    _otherProductView = otherProductView;
    [self.detailScrollView addSubview:otherProductView];
    // 添加图标
    CGFloat iconX = 15 * BOScreenW / BOPictureW;
    CGFloat iconY = 12.5 * BOScreenH / BOPictureH;
    CGFloat iconWH = 20 * BOScreenW / BOPictureW;
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
    iconImageV.image = [UIImage imageNamed:@"icon_qtcp"];
    [otherProductView addSubview:iconImageV];
    // 添加其他产品label
    CGFloat productX = 44 * BOScreenW/ BOPictureW;
    CGFloat productY = iconY;
    CGFloat productW = 250 * BOPictureW / BOPictureW;
    CGFloat productH = iconWH;
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(productX, productY, productW, productH)];
    productLabel.text = [NSString stringWithFormat:@"其他产品(主打产品：%@)",self.item.pro_name];
    [productLabel setTextColor:BOColor(50, 52, 53)];
    [productLabel setFont:[UIFont systemFontOfSize:14]];
    [otherProductView addSubview:productLabel];
    // 创建分割线View
    CGFloat divisionX = iconX;
    CGFloat divisionY = 45 * BOScreenH / BOPictureH;
    CGFloat divisionW = BOScreenW - iconX;
    CGFloat divisionH = 1;
    UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(divisionX, divisionY, divisionW, divisionH)];
    divisionView.backgroundColor = BOColor(236, 237, 238);
    [otherProductView addSubview:divisionView];
    
    // 创建一个显示其他商品的label
    CGFloat otherLX = 15 * BOScreenW / BOPictureW;
    CGFloat otherLY = CGRectGetMaxY(divisionView.frame) + 10 * BOScreenH / BOPictureH;
    CGFloat otherLW = BOScreenW - 35 * BOScreenW / BOPictureW;
    CGFloat otherLH = height;
    UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(otherLX, otherLY, otherLW, otherLH)];
    self.otherLabel = otherLabel;
    otherLabel.numberOfLines = 0;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.item.other_pro attributes:dict];
    otherLabel.attributedText = attribute;
    [otherProductView addSubview:otherLabel];
    
}

#pragma mark - 展示介绍公司的View
- (void)setupIntroduceCompanyView {
    // 给展示的内容赋值
    NSString *showString = self.item.desc;
    // 创建对应的行间距
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    // 创建富文本对应的字典
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(178, 179, 180),NSForegroundColorAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    // 计算label的单行行高
    CGFloat lineHeight = [showString sizeWithAttributes:dict].height;
    self.lineHeight = lineHeight;
    // 计算不确定文字对应的高度
    CGFloat height = [showString boundingRectWithSize:CGSizeMake(BOScreenW - 35 * BOScreenW / BOPictureW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    self.introduceHeight = height;
    // 根据单行行高和计算出的总行高，算出当前一共多少行
    int lines = (height + 5) / lineHeight;
    // 创建显示介绍公司的View
    CGFloat introduceX = 0;
    CGFloat introduceY = CGRectGetMaxY(self.otherProductView.frame) + 8 * BOScreenH / BOPictureH;
    CGFloat introduceW = BOScreenW;
        CGFloat introduceH;
    UIView *introduceView = [[UIView alloc] init];
    self.introduceView = introduceView;
    introduceView.backgroundColor = [UIColor whiteColor];
    [self.detailScrollView addSubview:introduceView];
    
    // 添加图标
    CGFloat iconX = 15 * BOScreenW / BOPictureW;
    CGFloat iconY = 12.5 * BOScreenH / BOPictureH;
    CGFloat iconWH = 20 * BOScreenW / BOPictureW;
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
    iconImageV.image = [UIImage imageNamed:@"icon_gsmc"];
    [introduceView addSubview:iconImageV];
    // 添加公司名称的label
    CGFloat nameX = 44 * BOScreenW / BOPictureW;
    CGFloat nameY = iconY;
    CGFloat nameW = 180 * BOScreenW / BOPictureW;
    CGFloat nameH = iconWH;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    self.nameLabel = nameLabel;
    nameLabel.text = @"杭州任润科技股份有限公司";
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [introduceView addSubview:nameLabel];
    // 添加背景lebel
    CGFloat backX = 260 * BOScreenW / BOPictureW;
    CGFloat backY = iconY;
    CGFloat backW = 85 * BOScreenW / BOPictureW;
    CGFloat backH = iconWH;
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(backX, backY, backW, backH)];
    backLabel.text = @"新三板上市";
    backLabel.textAlignment = NSTextAlignmentCenter;
    [backLabel setFont:[UIFont systemFontOfSize:14]];
    backLabel.textColor = BOColor(96, 185, 250);
    backLabel.layer.borderWidth = 1;
    backLabel.layer.borderColor = BOColor(96, 185, 250).CGColor;
    backLabel.layer.cornerRadius = 3;
    backLabel.layer.masksToBounds = YES;
    [introduceView addSubview:backLabel];
    // 创建分割线View
    CGFloat divisionX = iconX;
    CGFloat divisionY = 45 * BOScreenH / BOPictureH;
    CGFloat divisionW = BOScreenW - iconX;
    CGFloat divisionH = 1;
    UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(divisionX, divisionY, divisionW, divisionH)];
    divisionView.backgroundColor = BOColor(236, 237, 238);
    [introduceView addSubview:divisionView];
    // 创建显示简介内容的label
    CGFloat introX = 15 * BOScreenW / BOPictureW;
    CGFloat introY = CGRectGetMaxY(divisionView.frame) + 10 * BOScreenH / BOPictureH;
    CGFloat introW = BOScreenW - 35 * BOScreenW / BOPictureW;
    CGFloat introH = height;
    UILabel *introLabel = [[UILabel alloc] init];
    self.introLabel = introLabel;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:showString attributes:dict];
    introLabel.attributedText = attribute;
    [introduceView addSubview:introLabel];
    // 点击创建contentView当内容展开的时候，整个简介下面的View整体下移
    CGFloat contentX = 0;
    CGFloat contentY;
    CGFloat contentW = BOScreenW;
    CGFloat contentH = 126 * BOScreenH / BOPictureH;
    UIView *contentView = [[UIView alloc] init];
    _contentView = contentView;
    [introduceView addSubview:contentView];
    // 判断当前label的行数要是大于三行隐藏为三行，同时添加展开按钮
    if (lines >= 3) {
        introLabel.numberOfLines = 3;
        // 从新设置介绍公司内容的label
        introH = 60 * BOHeightRate;
        introLabel.frame = CGRectMake(introX, introY, introW, introH);
        // 添加全文的btn
        CGFloat wholeX = 15 * BOScreenW / BOPictureW;
        CGFloat wholeY = 0;
        CGFloat wholeW = 40 * BOScreenW / BOPictureW;
        CGFloat wholeH = 15 * BOScreenH / BOPictureH;
        UIButton *wholeBtn = [[UIButton alloc] initWithFrame:CGRectMake(wholeX, wholeY, wholeW, wholeH)];
        _wholeBtn = wholeBtn;
        [wholeBtn setTitle:@"全文" forState:UIControlStateNormal];
        [wholeBtn setTitleColor:BOColor(87, 135, 97) forState:UIControlStateNormal];
        [wholeBtn addTarget:self action:@selector(wholeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [wholeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.btnFlag = YES;
        [contentView addSubview:wholeBtn];
        
    } else {
        introLabel.frame = CGRectMake(introX, introY, introW, introH);
        introLabel.numberOfLines = lines;
        self.btnFlag = NO;
    }
    
    // 添加第二条分割线
    CGFloat secondX = divisionX;
    CGFloat secondY;
    if (self.btnFlag) {
        secondY = CGRectGetMaxY(self.wholeBtn.frame) + 21 * BOScreenH / BOPictureH;
    }else {
        secondY = height + 21 * BOScreenH / BOPictureH;
    }
    CGFloat secondW = divisionW;
    CGFloat secondH = 1;
    UIView *secondDivisionView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secondH)];
    secondDivisionView.backgroundColor = BOColor(236, 237, 238);
    [contentView addSubview:secondDivisionView];
    // 创建电话的icon
    CGFloat phoneX = iconX;
    CGFloat phoneY = CGRectGetMaxY(secondDivisionView.frame) + iconY;
    CGFloat phoneWH = iconWH;
    UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWH, phoneWH)];
    phoneIcon.image = [UIImage imageNamed:@"icon_kfdh"];
    [contentView addSubview:phoneIcon];
    // 创建业务电话的label
    CGFloat businessX = 44 * BOScreenW/ BOPictureW;
    CGFloat businessY = phoneY;
    CGFloat businessW = 150 * BOScreenW / BOPictureW;
    CGFloat businessH = 20 * BOScreenH / BOPictureH;
    UILabel *businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(businessX, businessY, businessW, businessH)];
    self.businessLabel = businessLabel;
    businessLabel.text = @"业务电话";
    [businessLabel setFont:[UIFont systemFontOfSize:14]];
    [contentView addSubview:businessLabel];
    // 创建点击拨打电话的按钮
    CGFloat dialX = 260 * BOScreenW / BOPictureW;
    CGFloat dialY = businessY;
    CGFloat dialW = 125 * BOScreenW / BOPictureW;
    CGFloat dialH = 20 * BOScreenH / BOPictureH;
    BOLcationButton *dialPhoneBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(dialX, dialY, dialW, dialH)];
    [dialPhoneBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [dialPhoneBtn setTitle:@"110119120" forState:UIControlStateNormal];
    [dialPhoneBtn setTitleColor:BOColor(130, 131, 132) forState:UIControlStateNormal];
    [dialPhoneBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    dialPhoneBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:dialPhoneBtn];
    // 添加第三条分割线
    CGFloat thirdX = secondX;
    CGFloat thirdY = CGRectGetMaxY(dialPhoneBtn.frame) + 12.5 * BOScreenH / BOPictureH;
    CGFloat thirdW = secondW;
    CGFloat thirdH = secondH;
    UIView *thirdDivisionView = [[UIView alloc] initWithFrame:CGRectMake(thirdX, thirdY, thirdW, thirdH)];
    thirdDivisionView.backgroundColor = BOColor(236, 237, 238);
    [contentView addSubview:thirdDivisionView];
    //创建地址的imageView
    CGFloat locationX = phoneX;
    CGFloat locationY = CGRectGetMaxY(thirdDivisionView.frame) + 12.5 * BOScreenH / BOPictureH;
    CGFloat locationWH = phoneWH;
    UIImageView *locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(locationX, locationY, locationWH, locationWH)];
    locationIcon.image = [UIImage imageNamed:@"icon_locate"];
    [contentView addSubview:locationIcon];
    // 创建一个显示地址的label
    CGFloat addressX = 44 * BOScreenW / BOPictureW;
    CGFloat addressY = locationY;
    CGFloat addressW = 265 * BOScreenW / BOPictureW;
    CGFloat addressH = 20 * BOScreenH / BOPictureH;
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressX, addressY, addressW, addressH)];
    self.addressLabel = addressLabel;
    [addressLabel setText:@"杭州市江干区凤起东路新达成大厦888号"];
    [addressLabel setFont:[UIFont systemFontOfSize:14]];
    [contentView addSubview:addressLabel];
    // 创建进去地图的btn
    CGFloat mapX = 345 * BOScreenW / BOPictureW;
    CGFloat mapY = locationY;
    CGFloat mapW = 15 * BOScreenW / BOPictureW;
    CGFloat mapH = 20 * BOScreenH / BOPictureH;
     UIButton *mapBtn = [[UIButton alloc] initWithFrame:CGRectMake(mapX, mapY, mapW, mapH)];
    [mapBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [contentView addSubview:mapBtn];
    
    // 设置内容View的frame
    contentY = (66 + introLabel.height) * BOScreenH / BOPictureH;
    contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    // 根据是否需要显示全文确定View的高度
    introduceH = (192 + introLabel.height) * BOScreenH / BOPictureH;
    introduceView.frame = CGRectMake(introduceX, introduceY, introduceW, introduceH);
    
    self.nameLabel.text = self.item.com_name;
    self.businessLabel.text = self.item.mobile;
    self.addressLabel.text = self.item.addr;

}
#pragma mark - 全文按钮的点击事件
- (void)wholeBtnClick: (UIButton *)btn {
    if (btn.selected == NO) {
        btn.selected = YES;
        self.introLabel.height = self.introduceHeight;
        self.introLabel.numberOfLines = 0;
        self.introduceView.height = (192 + self.introLabel.height) * BOScreenH / BOPictureH;
        self.contentView.y = (66 + self.introLabel.height) * BOScreenH / BOPictureH;
        self.indicatorView.y = CGRectGetMaxY(self.introduceView.frame) + 8 * BOHeightRate;
        self.reviewView.y = CGRectGetMaxY(self.indicatorView.frame) + 1;
//        self.detailScrollView.contentSize = CGSizeMake(0, self.detailScrollView.contentSize.height + self.introLabel.height);
    }else if (btn.selected == YES) {
        btn.selected = NO;
        self.introLabel.height = 60 * BOHeightRate;
        self.introLabel.numberOfLines = 3;
        self.introduceView.height = 254 * BOHeightRate;
        self.contentView.y = (66 + self.introLabel.height) * BOScreenH / BOPictureH;
        self.indicatorView.y = 786 * BOHeightRate;
        self.reviewView.y = CGRectGetMaxY(self.indicatorView.frame) + 1;
//        self.detailScrollView.contentSize = CGSizeMake(0, self.detailScrollView.contentSize.height - self.introLabel.height);
    }
}
#pragma mark - 请求底部的用户点评数据
- (void)requstBottomCommentData {
    // 请求最新点评的数据
    NSString *rankString = [NSString stringWithFormat:@"%@WdApi/svDpList",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"svid"] = self.svid;
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"3";
    [self.mgr POST:rankString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 添加指示器显示用户跳转的View
        [self setupUserCommentView];
        if ([responseObject[@"count"] intValue] > 0) {
            // 添加底部tableView
            [self setupBottomTabView];
           
            [self.detailTableView registerClass:[DetailNoPictureCellTableViewCell class] forCellReuseIdentifier:NOPictureID];
            [self.detailTableView registerClass:[DetailOnePictureCell class] forCellReuseIdentifier:OnePictureID];
            [self.detailTableView registerClass:[DetailOtherPictureCell class] forCellReuseIdentifier:OtherPictureID];
        }else {
            [self uploadTheFirstReviewView];
            self.detailScrollView.contentSize = CGSizeMake(0,CGRectGetMaxY(self.indicatorView.frame) + 202 * BOHeightRate);
        }
        // 设返回和分享按钮
        [self setupBackWithShareBtn];
        // 设置底部的写点评的View
        [self writeCommentsOnView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - 创建用户点评的View
- (void)setupUserCommentView {
    CGFloat indicatorX = 0;
    CGFloat indicatorY = CGRectGetMaxY(self.introduceView.frame) + 8 * BOScreenH / BOPictureH;
    CGFloat indicatorW = BOScreenW;
    CGFloat indicatorH = 45 * BOScreenH / BOPictureH;
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH)];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [UIColor whiteColor];
    [self.detailScrollView addSubview:indicatorView];
    // 创建用户点评的label
    CGFloat commentX = 15 * BOScreenW / BOPictureW;
    CGFloat commentY = 12.5 * BOScreenH / BOPictureH;
    CGFloat commentW = 65 * BOScreenW / BOPictureW;
    CGFloat commentH = 20 * BOScreenH / BOPictureH;
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentX, commentY, commentW, commentH)];
    commentLabel.text = @"用户点评";
    [commentLabel setFont:[UIFont systemFontOfSize:15]];
    [indicatorView addSubview:commentLabel];
    // 添加显示评论数字的label
    CGFloat numberX = CGRectGetMaxX(commentLabel.frame) + 6 * BOScreenW / BOPictureW;
    CGFloat numberY = commentY;
    CGFloat numberW = 75 * BOScreenW / BOPictureW;
    CGFloat numberH = 20 * BOScreenH / BOPictureH;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
    numberLabel.text = @"(132)";
    [numberLabel setFont:[UIFont systemFontOfSize:15]];
    [indicatorView addSubview:numberLabel];
    // 创建点击跳转的btn
    CGFloat skipX = 345 * BOScreenW / BOPictureW;
    CGFloat skipY = commentY;
    CGFloat skipW = 15 * BOScreenW /BOPictureW;
    CGFloat skipH = 20 * BOScreenH / BOPictureH;
    UIButton *skipBtn = [[UIButton alloc] initWithFrame:CGRectMake(skipX, skipY, skipW, skipH)];
    [skipBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [indicatorView addSubview:skipBtn];
}
#pragma mark---上传第一条点评---
- (void)uploadTheFirstReviewView
{
    //上传第一条点评view
    CGFloat commentsViewY = CGRectGetMaxY(self.indicatorView.frame) + 1;
    UIView *reviewView = [[UIView alloc]initWithFrame:CGRectMake(0, commentsViewY, BOScreenW, 270*BOScreenH/1334)];
    self.reviewView = reviewView;
    reviewView.backgroundColor = [UIColor whiteColor];
    [self.detailScrollView addSubview:reviewView];
    
    //上传第一条点评button
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake(235*BOScreenW/750, 64*BOScreenH/1334, 280*BOScreenW/750, 72*BOScreenH/1334);
    [commentsButton setTitle:@" 上传第1条点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_dianping_dark"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [commentsButton.layer setMasksToBounds:YES];
    [commentsButton.layer setCornerRadius:4];
    [commentsButton.layer setBorderWidth:1.0];
    commentsButton.layer.borderColor = [UIColor colorWithHexString:@"#999999" alpha:1].CGColor;
    [reviewView addSubview:commentsButton];
}

#pragma mark - 设置底部的tableView
- (void)setupBottomTabView {
    CGFloat tableX = 0;
    CGFloat tableY = CGRectGetMaxY(self.indicatorView.frame) + 1;
    CGFloat tableW = BOScreenW;
    CGFloat tableH = self.detailHeight + 60 * BOScreenH / BOPictureH;
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStyleGrouped];
    self.detailTableView = detailTableView;
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    detailTableView.scrollEnabled = NO;
    [self.detailScrollView addSubview:detailTableView];
    
    // 设置scrollView的contsize
    self.detailScrollView.contentSize = CGSizeMake(0, tableY + self.detailHeight + 60 * BOScreenH / BOPictureH);
    self.detailScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailVM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformDetailViewModel *cellVM = self.detailVM[indexPath.row];
    if ([cellVM.item.picture_number integerValue] == 0) {
        DetailNoPictureCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOPictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
        
    }else if ([cellVM.item.picture_number integerValue] == 1) {
        DetailOnePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:OnePictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
    }else if ([cellVM.item.picture_number integerValue] > 0){
        DetailOtherPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:OtherPictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
    }
    return self.cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.detailVM[indexPath.row] cellH];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat moreVX = 0;
    CGFloat moreVY = 0;
    CGFloat moreVW = BOScreenW;
    CGFloat moreVH = 40 * BOScreenH / BOPictureH;
    UIView *lookMoreView = [[UIView alloc] initWithFrame:CGRectMake(moreVX, moreVY, moreVW, moreVH)];
    lookMoreView.backgroundColor = [UIColor whiteColor];
    // 在该View中添加查看更多的btn
    CGFloat lookX = (BOScreenW - 80 * BOScreenW / BOPictureW) * 0.5;
    CGFloat lookY = 10 * BOScreenH / BOPictureH;
    CGFloat lookW = 80 * BOScreenW / BOPictureW;
    CGFloat lookH = 20 * BOScreenH / BOPictureH;
    UIButton *lookMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(lookX, lookY, lookW, lookH)];
    [lookMoreBtn setTitle:@"查看更多评论" forState:UIControlStateNormal];
    [lookMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [lookMoreBtn setTitleColor:BOColor(155, 156, 157) forState:UIControlStateNormal];
    [lookMoreView addSubview:lookMoreBtn];
    return lookMoreView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40 * BOScreenH / BOPictureH;
}
#pragma mark - 设置返回和分享按钮
- (void)setupBackWithShareBtn {
    // 添加返回按钮
    CGFloat backX = 10 * BOScreenW / BOPictureW;
    CGFloat backY = 12 * BOScreenH / BOPictureH;
    CGFloat backWH = 32 * BOScreenW / BOScreenW;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(backX, backY, backWH, backWH)];
    backBtn.layer.cornerRadius = 16 * BOScreenW / BOScreenW;
    self.backBtn = backBtn;
    backBtn.layer.masksToBounds = YES;
    [backBtn setImage:[UIImage imageNamed:@"icon_backs"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backLastPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    // 添加分享按钮
    CGFloat shareX = BOScreenW - 42 * BOScreenW / BOPictureW;
    CGFloat shareY = 12 * BOScreenH / BOPictureH;
    CGFloat shareWH = backWH;
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(shareX, shareY, shareWH, shareWH)];
    shareBtn.layer.cornerRadius = 16 * BOScreenW / BOScreenW;
    self.shareBtn = shareBtn;
    shareBtn.layer.masksToBounds = YES;
    [shareBtn setImage:[UIImage imageNamed:@"icon_fenxiangs"] forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
}
#pragma mark - 返回上一个界面
- (void)backLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---写点评---
- (void)writeCommentsOnView
{
    //    //写点评view
    //    UIView *writeCommentView =[[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334)];
    //    writeCommentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7fa" alpha:1];
    //    [self.view addSubview:writeCommentView];
    
    //毛玻璃效果
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    self.effectView = effectView;
    effectView.frame = CGRectMake(0, BOScreenH - 64, BOScreenW, 49);
    effectView.alpha = 0.97;
    [self.view addSubview:effectView];
    UIVisualEffectView *sub = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
    sub.frame = effectView.bounds;
    [effectView.contentView addSubview:sub];
    //写点评的button
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake((BOScreenW-200*BOScreenW/750)/2, 19*BOScreenH/1334, 200*BOScreenW/750, 60*BOScreenH/1334);
    [commentsButton setTitle:@"  写点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_xdp"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#2380f4" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [sub addSubview:commentsButton];
    //线view
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 1*BOScreenH/1334)];
    fourLineView.backgroundColor = [UIColor colorWithHexString:@"#c6c7c7" alpha:1];
    [sub addSubview:fourLineView];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > self.offestY) {
        self.effectView.hidden = YES;
        self.offestY = scrollView.contentOffset.y;
    }else if (scrollView.contentOffset.y < self.offestY) {
        self.effectView.hidden = NO;
    }
//    CGFloat contentOffset = scrollView.contentOffset.y;
//    //当offset值等于64的时候 alpha = 1
//    CGFloat alpha = contentOffset * 1 / 20;
//    if (alpha >= 1)
//    {
//        alpha = 0.99;
//    }
//    self.navigationController.navigationBar.alpha = alpha;
//    //设置背景图片
//    //把颜色转成图片
//    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:alpha] WithAlpha:alpha];
//    //把图片设置为背景
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.effectView.hidden = NO;
}


@end
