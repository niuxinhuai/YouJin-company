//
//  PlatformServiceDetailHeadView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailHeadView.h"
#import "NSString+Utilities.h"

@implementation PlatformServiceDetailHeadView

+ (instancetype)create {
    PlatformServiceDetailHeadView *view = [[NSBundle mainBundle]loadNibNamed:@"PlatformServiceDetailHeadView" owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

#pragma mark - configuration

- (void)configureViews {
    self.clipsToBounds = YES;
    [self configureImageCycleView];
    self.productLabel.lineSpacing = 1;
    self.companyInfoLabel.lineSpacing = 1;
    [self.logoImageView makeCornerWithCornerRadius:5];
    [self.starView updateForeImage:@"total_yellow_star" backImage:@"total_gray_star"];
    [self.companyTabContainer makeCornerBorderWithWidth:1 cornerRadius:2 borderColor:[UIColor colorWithIntRed:92 green:187 blue:240 alpha:1]];
}

- (void)configureImageCycleView {
    self.detailImageCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.detailImageCycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.detailImageCycleView.autoScrollTimeInterval = 4;
}


#pragma mark - helpMethod

- (void)updatePlatformServiceDetailModel:(PlatformServiceDetailModel *)model {
    self.detail = model;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"] options:SDWebImageCacheMemoryOnly];
    self.nameLabel.text = model.pname;
    [self.starView updateScore:ceilf([model.score floatValue]) / 5.0];
    self.gradeLabel.text = [NSString stringWithFormat:@"%.1f分",[model.score floatValue]];
    self.evaluateLabel.text = [NSString evaluateStringWithObjects:@[@"产品",@"功能",@"实力",@"服务"] scores:@[model.v1,model.v2,model.v3,model.v4]];
    self.cityLabel.text = [model.sheng stringByAppendingString:[NSString stringWithFormat:@",%@",model.shi]];
    self.customerLabel.text = model.example;
    self.officiaUrlLabel.text = model.url;
    self.proProductLabel.text = @"其他产品";
    if (model.pro_name && model.pro_name.length > 0) self.proProductLabel.text = [self.proProductLabel.text stringByAppendingString:[NSString stringWithFormat:@"(主打产品:%@)",model.pro_name]];
    self.productLabel.text = model.other_pro;
    self.companyTabLabel.text = model.tab;
    if (!model.tab || model.tab.length == 0) self.companyTabContainer.hidden = YES;
    self.companyNameLabel.text = model.com_name;
    self.companyInfoLabel.text = model.desc;
    self.phoneNumberLabel.text = model.mobile;
    self.locationLabel.text = model.addr;
    self.detailImageCycleView.infiniteLoop = model.com_img.count > 0;
    self.detailImageCycleView.imageURLStringsGroup = [self bannerImageUrlStrings:model.com_img];
    [self configureLayoutConstraint];
    if (model.isNoNeedLoadMore) {
        self.loadMoreButtonHeight.constant = 0;
        self.loadMoreButtonBottomToSuperBottom.constant = 0;
        self.loadMoreButton.hidden = YES;
    }
}

- (void)configureLayoutConstraint {
    self.productContainerHeight.constant = 61 + [self.detail.other_pro getSizeWithFont:13 constrainedToSize:CGSizeMake([UIScreen screenWidth] - 30, MAXFLOAT) andlineSpacing:1].height;
}


#pragma mark - actionMethod

- (IBAction)pasteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(platformServiceDetailHeadView: pasteText:)]) {
        [self.delegate platformServiceDetailHeadView:self pasteText:self.officiaUrlLabel.text];
    }
}

- (IBAction)pushToOfficaialUrl:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(platformServiceDetailHeadView: pushOfficialUrl:)]) {
        [self.delegate platformServiceDetailHeadView:self pushOfficialUrl:self.officiaUrlLabel.text];
    }
}


- (IBAction)callAction:(UIButton *)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.phoneNumberLabel.text];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}
- (IBAction)companyInfoMoreAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(platformServiceDetailHeadView:loadMoreCompanyInfo:)]) {
        [self.delegate platformServiceDetailHeadView:self loadMoreCompanyInfo:sender.selected];
    }
}


#pragma mark - helpMethod

- (NSArray *)bannerImageUrlStrings:(NSArray *)images {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *imageDic in images) {
        if ([imageDic objectForKey:@"com_img"]) {
            [array addObject:[imageDic objectForKey:@"com_img"]];
        }
    }
    return array;
}

@end
