//
//  MediaApplyViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MediaApplyViewController.h"
#import "KnowTheViewController.h"

@interface MediaApplyViewController ()

@property (nonatomic, retain) AFHTTPSessionManager *manager;

@end

@implementation MediaApplyViewController

+ (instancetype)create {
    MediaApplyViewController *vc = [[MediaApplyViewController alloc]initWithNibName:@"MediaApplyViewController" bundle:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    [self configureViews];
    [self configureConstraint];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - configureViews 

- (void)configureViews {
    [self configureBar];
    [self.submitButton makeCornerWithCornerRadius:self.submitButton.height / 2.0];
}


- (void)configureBar {
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(returnAction:)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"自媒体认证"];
}

- (void)configureConstraint {
    self.submitButtonLeftToSuper.constant = 40 * BOWidthRate;
}


#pragma mark - request


- (void)mediaApplyRequestWithName:(NSString *)name note:(NSString *)note {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/personalAuthApply"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:USERUID forKey:@"uid"];
    [param setObject:USERSid forKey:@"sid"];
    [param setObject:name forKey:@"name"];
    [param setObject:note forKey:@"note"];
    
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self pushToApplySucceeViewController];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



#pragma mark - buttonAction

- (IBAction)submitAction:(UIButton *)sender {
    if (self.nameTextField.text.length == 0) {
        [self toast:@"请输入您的名字" complete:nil];
        return;
    }else if (self.declareTextField.text.length == 0) {
        [self toast:@"请输入您的个人说明" complete:nil];
        return;
    }
    [self mediaApplyRequestWithName:self.nameTextField.text note:self.declareTextField.text];
    
}


- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - reget 

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - helpMethod

- (void)pushToApplySucceeViewController {
    KnowTheViewController *knowVc = [[KnowTheViewController alloc]init];
    knowVc.hidesBottomBarWhenPushed = YES;
    knowVc.str = @"自媒体申请";
    [self.navigationController pushViewController:knowVc animated:YES];
}

@end
