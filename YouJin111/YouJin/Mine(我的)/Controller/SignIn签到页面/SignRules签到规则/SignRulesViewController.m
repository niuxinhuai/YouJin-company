//
//  SignRulesViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SignRulesViewController.h"

@interface SignRulesViewController ()

@end

@implementation SignRulesViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"签到规则"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 40*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
    oneLabel.text = @"1.连续签到:";
    oneLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    oneLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self.view addSubview:oneLabel];
    
    CGFloat oneLabelY = CGRectGetMaxY(oneLabel.frame)+16*BOScreenH/1334;
    UILabel *onesLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, oneLabelY, 690*BOScreenW/750, 90*BOScreenH/1334)];
    onesLabel.text = @"第一天50U币，每日递增，上限300U币，中断则从第一天开始";
    onesLabel.numberOfLines = 0;
    onesLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    onesLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self.view addSubview:onesLabel];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle};
    onesLabel.attributedText = [[NSAttributedString alloc]initWithString:onesLabel.text attributes:attributes];

    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 195*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [self.view addSubview:lineView];
    
    
    CGFloat lineViewY = CGRectGetMaxY(lineView.frame) + 40*BOScreenH/1334;
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, lineViewY, 200*BOScreenW/750, 30*BOScreenH/1334)];
    twoLabel.text = @"1.阅读签到:";
    twoLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    twoLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self.view addSubview:twoLabel];
    
    CGFloat twoLabelY = CGRectGetMaxY(twoLabel.frame)+16*BOScreenH/1334;
    UILabel *twosLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, twoLabelY, 690*BOScreenW/750, 90*BOScreenH/1334)];
    twosLabel.text = @"回答问题正确即可获得相应的U币，回答错误则不能获得";
    twosLabel.numberOfLines = 0;
    twosLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    twosLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self.view addSubview:twosLabel];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc]init];
    paragraphStyles.lineSpacing = 6;
    NSDictionary *attributess = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyles};
    twosLabel.attributedText = [[NSAttributedString alloc]initWithString:twosLabel.text attributes:attributess];
    
    
//    UIView *linesView = [[UIView alloc]initWithFrame:CGRectMake(0, 390*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
//    linesView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
//    [self.view addSubview:linesView];
    
    
//    CGFloat linesViewY = CGRectGetMaxY(linesView.frame) + 40*BOScreenH/1334;
//    UILabel *threeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, linesViewY, 200*BOScreenW/750, 30*BOScreenH/1334)];
//    threeLabel.text = @"1.好友帮签:";
//    threeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    threeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//    [self.view addSubview:threeLabel];
//
//    CGFloat threeLabelY = CGRectGetMaxY(threeLabel.frame)+16*BOScreenH/1334;
//    UILabel *threesLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, threeLabelY, 690*BOScreenW/750, 200*BOScreenH/1334)];
//    threesLabel.text = @"邀请的好友每日签到，邀请人签到时可额外获得U币，如邀请人未签到则当日奖励过期，恢复签到即可继续享有好友帮签奖励（好友生日当日签到，邀请人第二日获得50U币／人，可叠加）";
//    threesLabel.numberOfLines = 0;
//    threesLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    threesLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
//    [self.view addSubview:threesLabel];
//    //设置行间距
//    NSMutableParagraphStyle *paragraphStyless = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyless.lineSpacing = 6;
//    NSDictionary *attributesss = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyless};
//    threesLabel.attributedText = [[NSAttributedString alloc]initWithString:threesLabel.text attributes:attributesss];
    
    if (iPhone6P)
    {
        twosLabel.frame = CGRectMake(30*BOScreenW/750, twoLabelY, 690*BOScreenW/750, 60*BOScreenH/1334);
//        linesView.frame = CGRectMake(0, 350*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334);
//        threesLabel.frame = CGRectMake(30*BOScreenW/750, threeLabelY - 10*BOScreenH/1334, 690*BOScreenW/750, 200*BOScreenH/1334);
    }
    if (iPhone5)
    {
        onesLabel.frame = CGRectMake(30*BOScreenW/750, oneLabelY, 690*BOScreenW/750, 100*BOScreenH/1334);
        twosLabel.frame = CGRectMake(30*BOScreenW/750, twoLabelY, 690*BOScreenW/750, 100*BOScreenH/1334);
//        threesLabel.frame = CGRectMake(30*BOScreenW/750, threeLabelY, 690*BOScreenW/750, 260*BOScreenH/1334);
    }
    
    
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
