//
//  HeadLineWrongViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "ContentInputView.h"

#define commitButtonWidthRatio (240 / 375.0)


@interface HeadLineWrongCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;


- (void)updateTitle:(NSString *)text;
- (void)updateSelected:(BOOL)isSelected;


@end


@interface HeadLineWrongViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet ContentInputView *contentInputView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commitButtonWidth;


@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end
