#import "PlatformServeViewController.h"
#import "BOPictureWheelPlay.h"
#import "UIColor+Scale.h"
#import "BOCommentTableViewCell.h"
#import "PlatformServeDetailVC.h"
#import "PlatformServeCommentModel.h"
#import "SystemSafetyTableVC.h"
#import "NoteServeTableVC.h"
#import "KeepAccountTableVC.h"
#import "SynthesizeTableVC.h"
#import "BannerModel.h"
#import "MiddleModel.h"
#import "BOWebViewController.h"
static NSString *const ID = @"cell";
@interface PlatformServeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *serveScrollView;
/**
 评论的tableView
 */
@property (nonatomic, strong) UITableView *commentTableView;

/**引用最新评论的标题View*/
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, strong) NSMutableArray *newCommentArrayM;
/**保存banner图的url的数组*/
@property (nonatomic, strong) NSMutableArray *bannerUrlArray;

/**保存中间广告跳转url的数组*/
@property (nonatomic, strong) NSMutableArray *middleUrlArray;


@end

@implementation PlatformServeViewController
#pragma mark - 懒加载首页ScrollView
- (UIScrollView *)serveScrollView {
    if (_serveScrollView == nil) {
        _serveScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 49)];
        _serveScrollView.backgroundColor = BOColor(244, 245, 247);
        _serveScrollView.showsVerticalScrollIndicator = NO;
        _serveScrollView.delegate = self;
        [self.view addSubview:_serveScrollView];
    }
    return  _serveScrollView;
}
#pragma mark - 懒加载bannerUrlArray
- (NSMutableArray *)bannerUrlArray {
    if (_bannerUrlArray == nil) {
        _bannerUrlArray = [NSMutableArray array];
    }
    return _bannerUrlArray;
}
- (NSMutableArray *)middleUrlArray {
    if (_middleUrlArray == nil) {
        _middleUrlArray = [NSMutableArray array];
    }
    return _middleUrlArray;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
#pragma mark - 懒加载最新点评的数组
- (NSMutableArray *)newCommentArrayM {
    if (_newCommentArrayM == nil) {
        _newCommentArrayM = [NSMutableArray array];
    }
    return _newCommentArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 请求网络数据
    [self requstNetData];
    // 设置navigationItem
    [self setupNavigationItem];
    // 设置滚动view
//    [self setupScrollViewPicture];
    // 设置系统安全，短信服务，支付。。。
    [self setupServeBtnView];
    // 展示text和图片的View
//    [self setupTextWithPictureView];
    // 设置最新评论的标题View
    [self setupCommentTitleView];
    // 设置底部的评论tableView
    [self setupCommentTableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    // 请求最新点评的数据
    NSString *rankString = [NSString stringWithFormat:@"%@WdApi/serviceHomePage",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"10";
    [self.mgr POST:rankString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *array = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"banner"]];
        for (BannerModel *item in array) {
            [self.bannerUrlArray addObject:item.img_url];
        }
        // 去中间跳转的url数组
        self.middleUrlArray = [MiddleModel mj_objectArrayWithKeyValuesArray:responseObject[@"middle"]];
        [self setupTextWithPictureView];
        // 设置滚动view
        [self setupScrollViewPicture];
        self.newCommentArrayM = [PlatformServeCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot_dianping"]];
        [self.commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
    // 设置navigationItem的左边按钮
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backToLevel)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    // 设置标题
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"平台服务"];
    self.navigationItem.titleView = titleView;
//    // 设置navigationItem的右边按钮
//    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_search"] highImage:[UIImage imageNamed:@"icon_search"] target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark - 返回上一级
- (void)backToLevel {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置滚动View
- (void)setupScrollViewPicture {
//    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 110 * BOScreenH / BOPictureH)] delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 110 * BOScreenH / BOPictureH) delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    topScrollView.imageURLStringsGroup = self.bannerUrlArray;//网络图
    topScrollView.autoScrollTimeInterval = 4;
    [self.serveScrollView addSubview:topScrollView];

}
#pragma mark - 设置系统安全，短信服务，支付。。。
- (void)setupServeBtnView {
    // 创建服务view并添加
    UIView *serveView = [[UIView alloc] initWithFrame:CGRectMake(0, 110 * BOScreenH / BOPictureH, BOScreenW, 88 * BOScreenH / BOPictureH)];
    serveView.backgroundColor = [UIColor whiteColor];
    [self.serveScrollView addSubview:serveView];
    // 创建图片数组和文字数组
    NSArray *pictureArray = [NSArray arrayWithObjects:@"wd_icon_xtaq", @"wd_icon_dxfw",  @"wd_icon_jzfw", @"wd_icon_zhfw", nil];
    NSArray *textArray = [NSArray arrayWithObjects:@"系统安全", @"短信服务", @"记账服务", @"综合服务", nil];
    // 创建按钮和label
    CGFloat btnWH = 40 * BOScreenW / BOPictureW;
    CGFloat margin = (BOScreenW - btnWH * 4) * 0.25;
    for (int i = 0; i < 4; i++) {
        CGFloat btnX = 0.5  * margin + i * (margin + btnWH);
        CGFloat btnY = 13 * BOScreenH / BOPictureH;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWH, btnWH)];
        [btn setImage:[UIImage imageNamed:pictureArray[i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [serveView addSubview:btn];
        // 添加对应的label
        UILabel *label = [[UILabel alloc] init];
        label.width = 50 * BOScreenW / BOPictureW;
        label.y = CGRectGetMaxY(btn.frame) + 4 * BOScreenH / BOPictureH;
        label.centerX = btn.centerX;
        label.height = 25;
        [label setFont:[UIFont systemFontOfSize:12]];
        label.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = textArray[i];
        [serveView addSubview:label];
    }
}
#pragma mark - 系统安全，短信服务，支付btn的点击事件
- (void)btnClick:(UIButton *)button {
    switch (button.tag) {
        case 0:
        {
            SystemSafetyTableVC *systemTableVC = [[SystemSafetyTableVC alloc] init];
            [self.navigationController pushViewController:systemTableVC animated:YES];
            break;
        }
        case 1:
        {
            NoteServeTableVC *noteServeVC = [[NoteServeTableVC alloc] init];
            [self.navigationController pushViewController:noteServeVC animated:YES];
            break;
        }
        case 2:
        {
            KeepAccountTableVC *keepAccountVC = [[KeepAccountTableVC alloc] init];
            [self.navigationController pushViewController:keepAccountVC animated:YES];
            break;
        }
        case 3:
        {
            SynthesizeTableVC *synthesizeTableVC = [[SynthesizeTableVC alloc] init];
            [self.navigationController pushViewController:synthesizeTableVC animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 展示text和图片的View
- (void)setupTextWithPictureView {
    CGFloat viewX = 0;
    CGFloat viewY = 206 * BOScreenH / BOPictureH;
    CGFloat viewW = BOScreenW;
    CGFloat viewH = 160 * BOScreenH / BOPictureH;
    UIView *textPictureView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    [self.serveScrollView addSubview:textPictureView];
    for (int i = 0; i < 4; i++) {
//        MiddleModel *model = self.middleUrlArray[i];
        int remainder = i % 2;
        int consult = i / 2;
        UIView *pictureView = [[UIView alloc] initWithFrame:CGRectMake(remainder * 0.5 * viewW, consult * 0.5 * viewH, 0.5 * viewW, 0.5 * viewH)];
        pictureView.layer.borderWidth = 0.25;
        pictureView.layer.borderColor = BOColor(227, 228, 229).CGColor;
        pictureView.backgroundColor = [UIColor whiteColor];
        [textPictureView addSubview:pictureView];
        // 创建textView
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10 * BOScreenW / BOPictureW, 15 * BOScreenH / BOPictureH, 90 * BOScreenW / BOPictureW, 60 * BOScreenH / BOPictureH)];
        [textView setFont:[UIFont systemFontOfSize:14]];
//        textView.text = model.desc;
        [pictureView addSubview:textView];
        // 创建pictureView
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(115 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH, 60 * BOScreenW / BOPictureW, 60 * BOScreenH / BOPictureH)];
//        [imageV sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:perchImage];
        imageV.layer.cornerRadius = 7 * BOWidthRate;
        imageV.layer.masksToBounds = YES;
        [pictureView addSubview:imageV];
        // 添加button
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.5 * viewW, 0.5 * viewH)];
        button.tag = i;
        [button addTarget:self action:@selector(textPictureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [pictureView addSubview:button];
    }
}
#pragma mark - 展示text和图片的View的Btn点击事件
- (void)textPictureBtnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0:
        {
             MiddleModel *model = self.middleUrlArray[btn.tag];
            BOWebViewController *wkWebView = [[BOWebViewController alloc] init];
            wkWebView.urlString = model.url;
            [self.navigationController pushViewController:wkWebView animated:YES];
            break;
        }
        case 1:
        {
            MiddleModel *model = self.middleUrlArray[btn.tag];
            BOWebViewController *wkWebView = [[BOWebViewController alloc] init];
            wkWebView.urlString = model.url;
            [self.navigationController pushViewController:wkWebView animated:YES];
            break;
        }
        case 2:
        {
            MiddleModel *model = self.middleUrlArray[btn.tag];
            BOWebViewController *wkWebView = [[BOWebViewController alloc] init];
            wkWebView.urlString = model.url;
            [self.navigationController pushViewController:wkWebView animated:YES];
            break;
        }
        case 3:
        {
            MiddleModel *model = self.middleUrlArray[btn.tag];
            BOWebViewController *wkWebView = [[BOWebViewController alloc] init];
            wkWebView.urlString = model.url;
            [self.navigationController pushViewController:wkWebView animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 设置最新评论的标题View
- (void)setupCommentTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 374 * BOScreenH / BOPictureH, BOScreenW, 40)];
    self.titleView = titleView;
    // 设置指示器
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5, 5, 17)];
    indicateView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    titleView.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:indicateView];
    
    // 添加最新评论lable
    UILabel *commentLable = [[UILabel alloc] init];
    commentLable.frame = CGRectMake(15, 10, 100, 20);
    commentLable.text = @"最新点评";
    [commentLable setFont:[UIFont systemFontOfSize:15.0]];
    [titleView addSubview:commentLable];
    [self.serveScrollView addSubview:titleView];
}

#pragma mark - 设置底部的评论tableView
- (void)setupCommentTableView {
    // 创建评论View
    self.commentTableView = [[UITableView alloc] init];
    self.commentTableView.frame = CGRectMake(0, 414.5 * BOScreenH / BOPictureH, BOScreenW, 0);
    //注册评论View
    [self.commentTableView registerNib:[UINib nibWithNibName:@"BOCommentTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    // 设置数据源代理和协议
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.scrollEnabled = NO;
    [self.serveScrollView addSubview:self.commentTableView];
    
    // 设置contsize
    self.serveScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.commentTableView.frame) - 49);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newCommentArrayM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOCommentTableViewCell *cell = [self.commentTableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.newCommentArrayM[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 192.0 * BOPictureH / BOPictureH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现UIScrollView的代理方法
#define offestY 374 * BOScreenH / BOPictureH
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= offestY) {
        self.titleView.frame = CGRectMake(0, 0, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.view addSubview:self.titleView];
    }else if (scrollView.contentOffset.y < offestY) {
        self.titleView.frame = CGRectMake(0, 374 * BOScreenH / BOPictureH, BOScreenW, 40);
        [self.serveScrollView addSubview:self.titleView];
    }
}

@end
