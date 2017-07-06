//
//  XMGBaseTabViewController.m
//  BuDeJie19
//
//  Created by xmg5 on 16/10/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

#import "BOBaseTabViewController.h"
#import "BOLcationButton.h"
static NSString * const ID = @"cell";
@interface BOBaseTabViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, weak)  UIView *underLine;
@property (nonatomic, assign)  BOOL isInitial;
//@property (nonatomic, strong) UIButton *btn;

@end

@implementation BOBaseTabViewController

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = BOColor(53, 135, 241);
    
    // 添加底部内容View
    [self setupBottomContaninerView];
    
    // 添加顶部标题View
    [self setupTopTitleView];
    
    // 取消自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //     在view即将显示的时候设置titleView的高度
    _topScrollView.frame = CGRectMake(0, 0, BOScreenW, _titleViewH);
    _topScrollView.backgroundColor = _titleBackColor;
    if (_isInitial == NO) {
        // 添加所有标题按钮
        [self setupAllTitleButton];
        _isInitial = YES;
    }
    
    
}

#pragma mark - 点击标题的时候调用
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    if (button == _selectedButton) {
        NSLog(@"重复点击了按钮");
        // 获取当前控制器
        //        XMGBaseTopiceViewController *topicVC = self.childViewControllers[i];
        
        // 刷新当前控制器的View
        //        [topicVC reload];
        
    }
    
    [self selButton:button];
    
    
    
    // 滚动对应的位置
//    CGFloat offsetX = i * BOScreenW;
    [_bottomCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

#pragma mark - 选中标题
- (void)selButton:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    if (_titleViewH == 64) {
        // 判断下划线的位置
        if (button.x > 198 * BOScreenW / BOPictureW) {
            // 移动下划线
            [UIView animateWithDuration:0.25 animations:^{
                
                _underLine.centerX = button.centerX;
            }];
            _underLine.hidden = YES;
            
        }else if (button.x <= 198 * BOScreenW / BOPictureW){
            
            // 移动下划线
            [UIView animateWithDuration:0.25 animations:^{
                
                _underLine.centerX = button.centerX;
            }];
            _underLine.hidden = NO;
        }
        
    }else if (_titleViewH == 44) {
        // 移动下划线
        [UIView animateWithDuration:0.25 animations:^{
            
            _underLine.centerX = button.centerX;
        }];
        
    }
}

- (void)setupAllTitleButton
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnW = BOScreenW / count;
    CGFloat btnH = _topScrollView.height;
    for (NSInteger i = 0; i< count; i++) {
        btnX = i * btnW;
        // i = 3 的按钮进行特殊处理
        UIButton *btn = nil;
        if (i == 3) {
            btn = [BOLcationButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"common_arrow_address"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(btnX + 20 * BOScreenW / BOPictureW, 3, btnW, btnH);
        }else if (i == 4) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"common_icon_fatie"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(btnX + 15 * BOScreenW / BOPictureW, 3, btnW, btnH);
        } else {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, 3, btnW, btnH);
        }
        btn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [_topScrollView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:BOColor(40, 136, 234) forState:UIControlStateSelected];
            _underLine.backgroundColor = BOColor(40, 136, 234);
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //        [_btns addObject:btn];
        [self.btns addObject:btn];
        
        if (i == 0) {
            // 添加下划线
            UIView *underLine = [[UIView alloc] init];
            [_topScrollView addSubview:underLine];
            _underLine = underLine;
            [btn.titleLabel sizeToFit];
            
            underLine.width = btn.titleLabel.width * 0.6;
            underLine.height = 2;
            underLine.centerX = btn.centerX;
            underLine.y = _topScrollView.height - underLine.height - 1;
            
            [self titleClick:btn];
        }
    }
}



- (void)setupBottomContaninerView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
//    layout.itemSize = CGSizeMake(BOScreenW, 1000);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    // UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.scrollsToTop = NO;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    _bottomCollectionView = collectionView;
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
}

- (void)setupTopTitleView
{
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW , _titleViewH)];
    _topScrollView.scrollsToTop = NO;
    _topScrollView.layer.borderWidth = 1;
    _topScrollView.layer.borderColor = BOColor(214, 214, 214).CGColor;
    _topScrollView.backgroundColor = _titleBackColor;
     [self.view addSubview:_topScrollView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 每次只要有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 移除之前子控制器的View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 切换子控制器View
    UITableViewController *vc = self.childViewControllers[indexPath.row];
    // 不让tableView内容被挡住
    vc.tableView.contentInset = UIEdgeInsetsMake(self.topScrollView.height, 0, 0, 0);
    // 控制器View尺寸一开始就不对
    vc.view.frame = self.view.frame;
    [cell.contentView addSubview:vc.view];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / BOScreenW;
    UIButton *btn = self.btns[page];
    [self selButton:btn];
}


@end
