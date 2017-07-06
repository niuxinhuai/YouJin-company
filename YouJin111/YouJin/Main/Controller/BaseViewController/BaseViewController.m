//
//  BaseViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import <SVProgressHUD.h>
#import "UIColor+Scale.h"
#import <SDWebImageManager.h>

@interface BaseViewController ()

@property (nonatomic, strong) id showObserver;
@property (nonatomic, strong) id hideObserver;

@end

@implementation BaseViewController

+ (instancetype)create {
    BaseViewController *vc = [[BaseViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}



- (void)toast:(NSString *)message complete:(dispatch_block_t)complete {
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setCornerRadius:4.0];
    [SVProgressHUD showImage:nil status:message];
    [SVProgressHUD dismissWithDelay:1];
}


- (void)addAutoDismissKeyboardGesture {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autoDismissKeyboardGestureAction:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    // add Gesture
    __weak typeof(self) weakSelf = self;
    self.showObserver = [notificationCenter addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [weakSelf.view addGestureRecognizer:singleTapGesture];
    }];
    
    // remove Gesture
    self.hideObserver = [notificationCenter addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [weakSelf.view removeGestureRecognizer:singleTapGesture];
    }];
}

- (void)autoDismissKeyboardGestureAction:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self.hideObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self.showObserver];
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
