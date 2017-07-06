//
//  BODynamicViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BODynamicViewController.h"
#import "hotTopicTableVC.h"
#import "BOLcationButton.h"
#import "BOPictureWheelPlay.h"
#import "hotTopicTableVC.h"
#import "BestNewTableVC.h"
#import "NotAttentionVC.h"
#import "SendPostVC.h"
#import "SendPostView.h"
#import "ChooseSectionCollectionViewController.h"
#import "AttentionSectionVC.h"
#import "HotTopicViewController.h"

@interface BODynamicViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, weak) UIView *underLine;
@property (nonatomic, weak) UIScrollView *bottomScrollView;
@property (nonatomic, weak) UIScrollView *hotScorllView;
@property (nonatomic, retain) HotTopicViewController *hotTopicViewController;
@property (nonatomic, weak) BestNewTableVC *bestNewTableVC;
@property (nonatomic, weak) SendPostView *sendPostView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation BODynamicViewController
- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (void)setSelectBtn:(UIButton *)selectBtn {
    _selectBtn.selected = NO;
    selectBtn.selected = YES;
    _selectBtn = selectBtn;
    if (_selectBtn.tag != 4) {
        // 移动下划线
        [UIView animateWithDuration:0.25 animations:^{
            
            self.underLine.centerX = _selectBtn.centerX;
        }];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    // 隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    
    // 添加顶部的热门,最新,关注,版块View
    [self setupTopView];
    // 添加最底层的scrollView
    [self setupBottomScrollView];
    
    // 添加发帖的View
    [self setupSendPostView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGPoint offest = self.hotScorllView.contentOffset;
    offest.y = 0;
    self.hotScorllView.contentOffset = offest;
    
    self.selectBtn = self.btnArray[0];
    // 点击按钮改变scrollView的contentoffest
    CGPoint bottomOffest = self.bottomScrollView.contentOffset;
    bottomOffest.x = 0;
    self.bottomScrollView.contentOffset = bottomOffest;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)setupSendPostView {
    SendPostView *sendPostView = [[SendPostView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    sendPostView.backgroundColor = [UIColor whiteColor];
    sendPostView.alpha = 0.92;
    self.sendPostView = sendPostView;
    sendPostView.hidden = YES;
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [sendPostView addGestureRecognizer:tap];
    [self.view addSubview:sendPostView];

}
#pragma mark - 设置顶部的热门,最新,关注,版块View
- (void)setupTopView {
    // 添加上部的蓝色的View
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 64;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topView.backgroundColor = BOColor(53, 135, 241);
    [self.view addSubview:topView];
    // 添加热门按钮
    CGFloat hotX = 0;
    CGFloat hotY = 35 * BOHeightRate;
    CGFloat hotW = (320 * BOWidthRate) / 4.0;
    CGFloat hotH = 18 * BOHeightRate;
    UIButton *hotBtn = [[UIButton alloc] initWithFrame:CGRectMake(hotX, hotY, hotW, hotH)];
    [self setupTopBtnProperty:hotBtn];
    [hotBtn setTitle:@"热门" forState:UIControlStateNormal];
    self.selectBtn = hotBtn;
    hotBtn.tag = 0;
    [topView addSubview:hotBtn];
    
    // 添加下滑线View
    UIView *underLine = [[UIView alloc] init];
    self.underLine = underLine;
    underLine.height = 2;
    underLine.width = 20;
    underLine.centerX = hotBtn.centerX;
    underLine.y = 61;
    underLine.backgroundColor = [UIColor whiteColor];
    [topView addSubview:underLine];
    // 添加最新按钮
    CGFloat newX = CGRectGetMaxX(hotBtn.frame);
    CGFloat newY = hotY;
    CGFloat newW = hotW;
    CGFloat newH = hotH;
    UIButton *newBtn = [[UIButton alloc] initWithFrame:CGRectMake(newX, newY, newW, newH)];
    [self setupTopBtnProperty:newBtn];
    [newBtn setTitle:@"最新" forState:UIControlStateNormal];
    newBtn.tag = 1;
    [topView addSubview:newBtn];
    
    // 添加关注按钮
    CGFloat attentionX = CGRectGetMaxX(newBtn.frame);
    CGFloat attentionY = hotY;
    CGFloat attentionW = hotW;
    CGFloat attentionH = hotH;
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(attentionX, attentionY, attentionW, attentionH)];
    [self setupTopBtnProperty:attentionBtn];
    attentionBtn.tag = 2;
    [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [topView addSubview:attentionBtn];
    
    // 添加版块按钮
    CGFloat moduleX = CGRectGetMaxX(attentionBtn.frame);
    CGFloat moduleY = hotY;
    CGFloat moduleW = 50 * BOWidthRate;
    CGFloat moduleH = hotH;
    UIButton *moduleBtn = [[UIButton alloc] initWithFrame:CGRectMake(moduleX, moduleY, moduleW, moduleH)];
    [self setupTopBtnProperty:moduleBtn];
    [moduleBtn setTitle:@"版块" forState:UIControlStateNormal];
    moduleBtn.tag = 3;
    [topView addSubview:moduleBtn];
    
    // 添加发帖按钮
    CGFloat postX = 345 * BOWidthRate;
    CGFloat postY = hotY - 2;
    CGFloat postW = 20 * BOWidthRate;
    CGFloat postH = 20 * BOHeightRate;
    UIButton *postBtn = [[UIButton alloc] initWithFrame:CGRectMake(postX, postY, postW, postH)];
    [postBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [postBtn setImage:[UIImage imageNamed:@"common_icon_fatie"] forState:UIControlStateNormal];
    postBtn.hidden = YES;
    postBtn.tag = 4;
    [self.btnArray addObject:postBtn];
    [topView addSubview:postBtn];
}

#pragma mark - 添加最底层的scrollView
- (void)setupBottomScrollView {
    CGFloat bottomX = 0;
    CGFloat bottomY = 64;
    CGFloat bottomW = BOScreenW;
    CGFloat bottomH = BOScreenH - 113;
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    // 设置tag
    bottomScrollView.tag = 6;
    bottomScrollView.contentSize = CGSizeMake(BOScreenW * 4, BOScreenH - 113);
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.bounces = NO;
    self.bottomScrollView = bottomScrollView;
    bottomScrollView.delegate = self;
    bottomScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:bottomScrollView];
    
    // 设置热门相关的子控件
    [self setUpHotTopicViewController];
    // 设置最新相关控制器
    [self setupBestNewTableVC];
    // 设置没关注的控制器
    [self setupNotAttentionVC];
    // 设置关注的控制器
//    [self setupAttentionVC];
    // 设置选择版块的控制器
    [self setupChooseSectionController];
}
#pragma mark - 设置热门相关的子控件
- (void)setupHotChildView {
    // 添加热门的scrollView
    CGFloat hotX = 0;
    CGFloat hotY = 0;
    CGFloat hotW = BOScreenW;
    CGFloat hotH = BOScreenH - 64;
    UIScrollView *hotScorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(hotX, hotY, hotW, hotH)];
    hotScorllView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    hotScorllView.delegate = self;
    hotScorllView.tag = 7;
    self.hotScorllView = hotScorllView;
    hotScorllView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.bottomScrollView addSubview:hotScorllView];
    // 添加头部的滚动图
    [self setupWheelView];
    // 添加热门话题的View
    [self setupHotTopicView];
    // 添加底部的talbeView
    [self setupHotTableView];
}

#pragma mark - 设置热门版块

- (void)setUpHotTopicViewController {
    self.hotTopicViewController = [HotTopicViewController create];
    self.hotTopicViewController.view.frame = CGRectMake(0, 0, BOScreenW, BOScreenH - 64);
    [self addChildViewController:self.hotTopicViewController];
    [self.bottomScrollView addSubview:self.hotTopicViewController.view];
}


#pragma mark - 设置最新相关的tableView
- (void)setupBestNewTableVC {
    BestNewTableVC *bestNewTableVC = [[BestNewTableVC alloc] init];
    self.bestNewTableVC = bestNewTableVC;
    bestNewTableVC.tableView.frame = CGRectMake(BOScreenW, 0, BOScreenH, BOScreenH - 64);
    bestNewTableVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    bestNewTableVC.tableView.bounces = NO;
    [self addChildViewController:bestNewTableVC];
    [self.bottomScrollView addSubview:bestNewTableVC.tableView];
}
#pragma mark - 设置关注版块的控制器
- (void)setupAttentionVC {
    AttentionSectionVC *attentionVC = [[AttentionSectionVC alloc] init];
    attentionVC.view.frame = CGRectMake(2 * BOScreenW, 0, BOScreenW, BOScreenH - 64);
    [self addChildViewController:attentionVC];
    [self.bottomScrollView addSubview:attentionVC.view];
}
#pragma mark - 设置没关注版块的控制器
- (void)setupNotAttentionVC {
    NotAttentionVC *notAttentionVC = [[NotAttentionVC alloc] init];
    notAttentionVC.view.frame = CGRectMake(2 * BOScreenW, 0, BOScreenW, BOScreenH - 64);
    [self addChildViewController:notAttentionVC];
    [self.bottomScrollView addSubview:notAttentionVC.view];
}
#pragma mark - 设置选择版块的控制器
- (void)setupChooseSectionController {
    ChooseSectionCollectionViewController *chooseSectionCollectionVC = [[ChooseSectionCollectionViewController alloc] init];
    chooseSectionCollectionVC.view.frame = CGRectMake(3 * BOScreenW, 0, BOScreenW, BOScreenH - 64);
    [self addChildViewController:chooseSectionCollectionVC];
    [self.bottomScrollView addSubview:chooseSectionCollectionVC.view];

}
#pragma mark - 设置热门滚动的View
- (void)setupWheelView {
    UIView *hotWheelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 75 * BOScreenH / BOPictureH)];
    hotWheelView.backgroundColor = [UIColor blueColor];
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"dongtaibanner"], [UIImage imageNamed:@"dongtaibanner"], [UIImage imageNamed:@"dongtaibanner"], [UIImage imageNamed:@"dongtaibanner"], [UIImage imageNamed:@"dongtaibanner"], nil];
    SDCycleScrollView *cycleScrollView = [BOPictureWheelPlay PictureWheelPlayWithFrame:hotWheelView.frame WithImageArray:images WithTimeInterval:1.0];
    [hotWheelView addSubview:(UIView *)cycleScrollView];
    [self.hotScorllView addSubview:hotWheelView];
}
#pragma mark - 添加热门中热门话题的View
- (void)setupHotTopicView {
    // 创建热门话题的View
    CGFloat topicX = 0;
    CGFloat topicY = 75 * BOHeightRate;
    CGFloat topicW = BOScreenW;
    CGFloat topicH = 38 * BOHeightRate;
    UIView *topicView = [[UIView alloc] initWithFrame:CGRectMake(topicX, topicY, topicW, topicH)];
    topicView.backgroundColor = [UIColor whiteColor];
    [self.hotScorllView addSubview:topicView];
    
    // 添加hotImageV
    CGFloat hotIX = 10 * BOWidthRate;
    CGFloat hotIY = 11.5 * BOHeightRate;
    CGFloat hotIW = 24 * BOWidthRate;
    CGFloat hotIH = 15 * BOHeightRate;
    UIImageView *hotImageV = [[UIImageView alloc] initWithFrame:CGRectMake(hotIX, hotIY, hotIW, hotIH)];
    hotImageV.image = [UIImage imageNamed:@"icon_hots"];
    [topicView addSubview:hotImageV];
    
    // 添加热门话题的label
    CGFloat topicLX = CGRectGetMaxX(hotImageV.frame) + 7 * BOWidthRate;
    CGFloat topicLY = hotIY;
    CGFloat topicLW = 230 * BOWidthRate;
    CGFloat topicLH = hotIH;
    UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(topicLX, topicLY, topicLW, topicLH)];
    topicLabel.text = @"#热门话题热门话题热门话题#";
    [topicLabel setFont:[UIFont systemFontOfSize:14]];
    [topicLabel setTextColor:[UIColor colorWithHexString:@"#FA993E" alpha:1]];
    [topicView addSubview:topicLabel];
    
    // 更多话题的label
    CGFloat moreX = 300 * BOWidthRate;
    CGFloat moreY = hotIY;
    CGFloat moreW = 80 * BOWidthRate;
    CGFloat moreH = hotIH;
    BOLcationButton *moreBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(moreX, moreY, moreW, moreH)];
    [moreBtn setTitle:@"更多话题" forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [topicView addSubview:moreBtn];
    
}
#pragma mark - 添加热门的talbeView
- (void)setupHotTableView {
    hotTopicTableVC *hotTableVC = [[hotTopicTableVC alloc] init];
    hotTableVC.tableView.scrollEnabled = NO;
    hotTableVC.tableView.bounces = NO;
    hotTableVC.tableView.frame = CGRectMake(0, 121 * BOHeightRate, BOScreenW, hotTableVC.tableViewHeight);
    self.hotScorllView.contentSize = CGSizeMake(0, CGRectGetMaxY(hotTableVC.tableView.frame));
    [self addChildViewController:hotTableVC];
    [self.hotScorllView addSubview:hotTableVC.tableView];
}
#pragma mark - topBtnClick
- (void)topBtnClick: (UIButton *)btn {
    if (btn.tag == 4) {
        self.sendPostView.hidden = NO;
    }
    if (btn.tag != 4) {
        // 移动下划线
        [UIView animateWithDuration:0.25 animations:^{
            
            self.underLine.centerX = btn.centerX;
        }];
        // 点击按钮改变scrollView的contentoffest
        CGPoint bottomOffest = self.bottomScrollView.contentOffset;
        bottomOffest.x = btn.tag * BOScreenW;
        self.bottomScrollView.contentOffset = bottomOffest;
        

    }
       // 设置点击按钮的选中状态
    [self setSelectBtn:btn];

}
#pragma mark - 处理点击sendPostVCView的事件
- (void)viewClick {
    self.sendPostView.hidden = YES;
}
#pragma mark - 设置顶部按钮的属性
- (void)setupTopBtnProperty: (UIButton *)btn {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:BOColor(192, 210, 245) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    // 添加按钮到数组
    [self.btnArray addObject:btn];
    [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - UICollectionViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 6) {
        NSInteger page = scrollView.contentOffset.x / BOScreenW;
        UIButton *btn = self.btnArray[page];
        [self setSelectBtn:btn];
        if (self.page != page) {
            // 让热门的scrollView的每次偏移量为0
            CGPoint hotOffest = self.hotScorllView.contentOffset;
            hotOffest.y = 0;
            self.hotScorllView.contentOffset = hotOffest;
            // 让最新的偏移量为0
            CGPoint newOffest = self.bestNewTableVC.tableView.contentOffset;
            newOffest.y = 0;
            self.bestNewTableVC.tableView.contentOffset = newOffest;
            
        }
        self.page = page;

    }
    }

@end
