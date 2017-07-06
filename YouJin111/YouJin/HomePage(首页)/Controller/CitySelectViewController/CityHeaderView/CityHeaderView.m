//
//  CityHeaderView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CityHeaderView.h"

@interface CityHeaderView ()<UISearchBarDelegate>

@end

@implementation CityHeaderView

+ (instancetype)create {
    CityHeaderView *view = [[CityHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 40)];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}


- (void)configureViews {
    [self addSearchBar];
}

- (void)addSearchBar {
    self.searchBar = ({
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.delegate = self;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchBar.placeholder = @"输入城市名称";
        [self addSubview:searchBar];
        searchBar;
    });
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.bounds.size.width - 10);
        make.height.offset(40);
        make.top.equalTo(self.mas_top).offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击搜索按钮编辑的结果是%@",searchBar.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self cancelSearch];
}

- (void)cancelSearch {
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    _searchBar.text = nil;
}


@end
