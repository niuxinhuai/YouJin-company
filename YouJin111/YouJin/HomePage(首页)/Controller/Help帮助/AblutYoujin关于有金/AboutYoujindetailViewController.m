//
//  AboutYoujindetailViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AboutYoujindetailViewController.h"

@interface AboutYoujindetailViewController ()

@end

@implementation AboutYoujindetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.title = @"关于有金";
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:self.titleViewString];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    [self.view addSubview:bgView];
    
    //如何提高等级
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenH, 140*BOScreenH/1334)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.3].CGColor;
    topView.layer.shadowOffset = CGSizeMake(4, 2);
    topView.layer.shadowOpacity = 0.3;
    topView.layer.shadowRadius = 2;
    [bgView addSubview:topView];
    
    UIImageView *howtoImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 54*BOScreenH/1334, 32*BOScreenW/750, 32*BOScreenW/750)];
    howtoImage.image = [UIImage imageNamed:@"icon_wenti"];
    [topView addSubview:howtoImage];
    
    CGFloat howtoImageX = CGRectGetMaxX(howtoImage.frame) + 20*BOScreenW/750;
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(howtoImageX, 50*BOScreenH/1334, 500*BOScreenW/750, 40*BOScreenH/1334)];
//    levelLabel.text = @"如何提高等级?";
    levelLabel.text = self.problomString;
    [levelLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    levelLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [topView addSubview:levelLabel];
    
    //围绕推进
    UIImageView *aroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 178*BOScreenH/1334, 32*BOScreenW/750, 32*BOScreenW/750)];
    aroundImage.image = [UIImage imageNamed:@"icon_huida"];
    [bgView addSubview:aroundImage];
    
    UILabel *answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(howtoImageX, 166*BOScreenH/1334, BOScreenW - 30*BOScreenW/750-howtoImageX, BOScreenH-howtoImageX)];
//    answerLabel.text = @"围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。";
//    answerLabel.text = self.detailString;
    answerLabel.text = [self.detailString stringByAppendingString:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"];
    answerLabel.font = [UIFont systemFontOfSize:15];
    answerLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    answerLabel.numberOfLines = 0;
    
//    CGRect rect = [answerLabel.text boundingRectWithSize:answerLabel.frame.size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:answerLabel.font,NSFontAttributeName, nil] context:nil];
//    answerLabel.frame = CGRectMake(howtoImageX,166*BOScreenH/1334, BOScreenW - 30*BOScreenW/750-howtoImageX, BOScreenH-howtoImageX);
    
    [bgView addSubview:answerLabel];
    
  
    //设置行高
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: answerLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [answerLabel.text length])];
    answerLabel.attributedText = attributedString;
//    [answerLabel sizeToFit]; 可以超过label自身的高度
    
//    UILabel *answerNextLabel = [[UILabel alloc]initWithFrame:CGRectMake(howtoImageX, 300*BOScreenH/1334, BOScreenW - 30*BOScreenW/750-howtoImageX, 90*BOScreenH/1334)];
//    answerNextLabel.text = @"围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。围绕推进供给侧结构性改革的主线，银行业在当前致力为客户提供完善的服务。";
//    answerNextLabel.font = [UIFont systemFontOfSize:15];
//    answerNextLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//    answerNextLabel.numberOfLines = 0;
//    [bgView addSubview:answerNextLabel];
//    
//    //设置行高
//    NSMutableAttributedString *twoattributedString = [[NSMutableAttributedString alloc] initWithString: answerNextLabel.text];
//    NSMutableParagraphStyle *twoparagraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [twoparagraphStyle setLineSpacing:8];
//    [twoattributedString addAttribute:NSParagraphStyleAttributeName value:twoparagraphStyle range:NSMakeRange(0, [answerNextLabel.text length])];
//    answerNextLabel.attributedText = twoattributedString;
//    [answerNextLabel sizeToFit];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
