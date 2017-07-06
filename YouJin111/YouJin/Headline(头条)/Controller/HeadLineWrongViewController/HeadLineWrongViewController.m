//
//  HeadLineWrongViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineWrongViewController.h"


@implementation HeadLineWrongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSelectButton];
    [self addContentLabel];
}


- (void)addSelectButton {
    self.selectButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"icon_selectsmall_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_selectsmall_pre"] forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        button;
    });
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(self.selectButton.mas_height);
        make.width.mas_equalTo(@20);
    }];
}

- (void)addContentLabel {
    self.contentLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor colorWithIntRed:51 green:51 blue:51 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [label sizeToFit];
        [self.contentView addSubview:label];
        label;
    });
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.selectButton.mas_right).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    if (_indexPath != indexPath) {
        _indexPath = indexPath;
        self.backgroundColor = indexPath.row % 2 == 1 ? [UIColor colorWithIntRed:253 green:248 blue:244 alpha:1] : [UIColor colorWithIntRed:253 green:238 blue:230 alpha:1];
    }
}

- (void)updateTitle:(NSString *)text {
    self.title = text;
    self.contentLabel.text = text;
}

- (void)updateSelected:(BOOL)isSelected {
    self.isSelected = isSelected;
    self.selectButton.selected = isSelected;
}

@end


@interface HeadLineWrongViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HeadLineWrongViewController

+ (instancetype)create {
    HeadLineWrongViewController *vc = [[HeadLineWrongViewController alloc]initWithNibName:@"HeadLineWrongViewController" bundle:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - configration


- (void)configureViews {
    [self.commitButton makeCornerWithCornerRadius:self.commitButton.height / 2.0];
    self.commitButtonWidth.constant = commitButtonWidthRatio * [UIScreen screenWidth];
    [self configrueTableView];
    [self configureContentInputView];
    [self configureBars];
}


- (void)configrueTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[HeadLineWrongCell class] forCellReuseIdentifier:NSStringFromClass([HeadLineWrongCell class])];
}

- (void)configureContentInputView {
    [self.contentInputView makeCornerBorderWithWidth:1 cornerRadius:0 borderColor:[UIColor placeholderColor]];
    [self.contentInputView updateWordCountLabelShow:NO];
    [self.contentInputView updatePlaceholderText:@"请输出您要报错的内容"];
}

- (void)configureBars {
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(returnAction:)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                    target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"我要报错"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadLineWrongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeadLineWrongCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    [cell updateSelected:self.selectedIndex.row == indexPath.row];
    [cell updateTitle:self.titles[indexPath.row]];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath;
    for (HeadLineWrongCell *cell in [tableView visibleCells]) {
        [cell updateSelected:self.selectedIndex.row == cell.indexPath.row];
    }
}

#pragma mark - reget 

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"内容有错误",@"重复内容",@"内容有错别字",@"内容侵犯他人著作权",@"其他"];
    }
    return _titles;
}

- (NSIndexPath *)selectedIndex {
    if (!_selectedIndex) {
        _selectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectedIndex;
}

#pragma mark - actionMethod

- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commitAction:(UIButton *)sender {
    [self toast:@"已反馈" complete:nil];
    [self returnAction:nil];
}

@end
