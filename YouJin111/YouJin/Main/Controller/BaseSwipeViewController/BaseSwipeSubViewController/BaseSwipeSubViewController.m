//
//  BaseSwipeSubViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeSubViewController.h"

@interface BaseSwipeSubViewController ()

@end

@implementation BaseSwipeSubViewController

+ (instancetype)createWithTableViewStyle:(UITableViewStyle)style {
    BaseSwipeSubViewController *vc = [[BaseSwipeSubViewController alloc]init];
    vc.tableViewStyle = style;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self addLackView];
    [self hiddenLackView:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTableView {
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:self.tableViewStyle];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"hdajhda"];
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}


- (void)addLackView {
    self.lackView = ({
        LackVIew *view = [[LackVIew alloc]init];
        [self.view insertSubview:view atIndex:0];
        view.hidden = YES;
        view;
    });
    
    [self.lackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hdajhda" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(baseSwipeSubViewControllerBeginDragging:)]) {
        [self.delegate baseSwipeSubViewControllerBeginDragging:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(baseSwipeSubViewControllerEndDragging:)]) {
        [self.delegate baseSwipeSubViewControllerEndDragging:self];
    }
}


#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([self.delegate respondsToSelector:@selector(baseSwipeSubViewController: observeContentOffset:)]) {
        [self.delegate baseSwipeSubViewController:self observeContentOffset:[change[NSKeyValueChangeNewKey] CGPointValue]];
    }
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    CGFloat offsetY = offset.y > 0 ? 0 :- offset.y;
    [self.lackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(offsetY));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

#pragma mark - reset && reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (void)setIsCanRefresh:(BOOL)isCanRefresh {
    _isCanRefresh = isCanRefresh;
    if (isCanRefresh) {
        [self configureTableViewRefresh];
    }
}

- (void)setIsCanLoadMore:(BOOL)isCanLoadMore {
    _isCanLoadMore = isCanLoadMore;
    if (_isCanLoadMore) {
        [self configureTableViewLoadMore];
    }
}


- (void)setIgnoredScrollViewContentInsetBottom:(CGFloat)ignoredScrollViewContentInsetBottom {
    if (_ignoredScrollViewContentInsetBottom != ignoredScrollViewContentInsetBottom) {
        _ignoredScrollViewContentInsetBottom = ignoredScrollViewContentInsetBottom;
    }
}

#pragma mark - helpMethod 

- (void)configureTableViewRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(topRefreshing)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.ignoredScrollViewContentInsetTop =  0;
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
}

- (void)configureTableViewLoadMore {
    MJRefreshFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(bottomRefreshing)];
   // footer.ignoredScrollViewContentInsetBottom = self.ignoredScrollViewContentInsetBottom;
    self.tableView.mj_footer = footer;
}


#pragma mark - actionMethod

- (void)topRefreshing {
    
}

- (void)bottomRefreshing {
    
}

#pragma mark - publicMethod

- (void)tableViewEndRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

- (void)hiddenLackView:(BOOL)hidden {
    if (!hidden) [self.view bringSubviewToFront:self.lackView];
    self.lackView.hidden = hidden;
    self.tableView.hidden = !hidden;
}


- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
