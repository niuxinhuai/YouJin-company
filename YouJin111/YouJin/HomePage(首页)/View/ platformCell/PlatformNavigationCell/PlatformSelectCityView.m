//
//  PlatformSelectCityView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformSelectCityView.h"
#import "LeftTableView.h"
#import "RightTableView.h"
#import "ShengModel.h"
#import "ShiModel.h"
static NSString *const ID = @"cell";
@interface PlatformSelectCityView()<UITableViewDataSource, UITableViewDelegate>

/**引用leftTableView*/
@property (nonatomic, weak) UITableView *leftTableView;
/**引用RightTableView*/
@property (nonatomic, weak) UITableView *rightTableView;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**保存城市数据的数组*/
@property (nonatomic, strong) NSMutableArray *cityArrayM;

@property (nonatomic, strong) NSArray *shiArray;

@end
@implementation PlatformSelectCityView
#pragma mark - 懒加载
- (NSMutableArray *)cityArrayM {
    if (_cityArrayM == nil) {
        _cityArrayM = [NSMutableArray array];
        [_cityArrayM addObject:@"全部地区"];
    }
    return _cityArrayM;
}
- (NSArray *)shiArray {
    if (_shiArray == nil) {
        _shiArray = [NSArray array];
    }
    return _shiArray;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self requstNetData];
        
        self.backgroundColor = [UIColor whiteColor];
        // 添加左边的tableView
        LeftTableView *leftTabelView = [[LeftTableView alloc] init];
        leftTabelView.delegate = self;
        leftTabelView.dataSource = self;
        // 设置bordeWidth
        leftTabelView.layer.borderWidth = 1;
        leftTabelView.layer.borderColor = BOColor(229, 231, 233).CGColor;
        self.leftTableView = leftTabelView;
        [self addSubview:leftTabelView];
        // 添加右边的tableView
        RightTableView *rightTableView = [[RightTableView alloc] init];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        self.rightTableView = rightTableView;
        [self addSubview:rightTableView];
        
        // 注册tableViewCell
        [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置左边的tableView的frame
    CGFloat leftX = 0;
    CGFloat leftY = 0;
    CGFloat leftW = 0.5 * BOScreenW;
    CGFloat leftH = self.height;
    self.leftTableView.frame = CGRectMake(leftX, leftY, leftW, leftH);
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isKindOfClass:[LeftTableView class]]) {
        return self.cityArrayM.count;
    }
    
    return self.shiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if ([tableView isKindOfClass:[LeftTableView class]]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部地区";
            cell.textLabel.highlightedTextColor = BOColor(71, 150, 243);
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else {
            ShengModel *model = self.cityArrayM[indexPath.row];
            cell.textLabel.text = model.name;
            cell.textLabel.highlightedTextColor = BOColor(71, 150, 243);
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }else if ([tableView isKindOfClass:[RightTableView class]]) {
            ShiModel *model = self.shiArray[indexPath.row];
            cell.textLabel.text = model.name;
            cell.textLabel.highlightedTextColor = BOColor(71, 150, 243);
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
    }
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = BOColor(229, 231, 233).CGColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 * BOScreenH / BOPictureH;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[LeftTableView class]]) {
        if (indexPath.row != 0) {
            ShengModel *model = self.cityArrayM[indexPath.row];
            self.shiArray = model.child;
            CGFloat rightX = 0.5 * BOScreenW ;
            CGFloat rightY = 0;
            CGFloat rightW = 0.5 * BOScreenW;
            CGFloat rightH;
            if (self.shiArray.count > 9) {
                rightH = 360 * BOHeightRate;
            }else {
                rightH = self.shiArray.count * 40 * BOHeightRate;
            }
            self.rightTableView.frame = CGRectMake(rightX, rightY, rightW, rightH);
            [self.rightTableView reloadData];
        }else {
            if ([self.delegate respondsToSelector:@selector(platformSelectCityViewSelectCity:cityNumber:)]) {
                [self.delegate platformSelectCityViewSelectCity:@"全部地区" cityNumber:[NSString stringWithFormat:@"0"]];
            }

            self.rightTableView.height = 0;
        }
        
    }else if ([tableView isKindOfClass:[RightTableView class]]) {
        ShiModel *model = self.shiArray[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(platformSelectCityViewSelectCity:cityNumber:)]) {
            [self.delegate platformSelectCityViewSelectCity:model.name cityNumber:[NSString stringWithFormat:@"%d",model.city]];
        }
    }
}

#pragma mark - 请求数据
- (void)requstNetData {
    NSString *url = [NSString stringWithFormat:@"%@Common/getArea",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [ShengModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (ShengModel *model in array) {
            [self.cityArrayM addObject:model];
        }
        [self.leftTableView reloadData];
        // 设置右边的tableView的frame
        CGFloat rightX = 0.5 * BOScreenW ;
        CGFloat rightY = 0;
        CGFloat rightW = 0.5 * BOScreenW;
        CGFloat rightH = self.shiArray.count * 40 * BOHeightRate;
        self.rightTableView.frame = CGRectMake(rightX, rightY, rightW, rightH);
        [self.rightTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
