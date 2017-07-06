//
//  HotTopicViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicViewController.h"
#import "HotTopicViewController+Configures.h"
#import "HotTopicViewController+FlowLogical.h"

@interface HotTopicViewController ()

@end

@implementation HotTopicViewController


+ (instancetype)create {
    HotTopicViewController *hotTopicViewController = [[HotTopicViewController alloc]initWithNibName:@"HotTopicViewController" bundle:nil];
    return hotTopicViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self toolConfigures];
    [self requireBanner];
    [self requireForHotListWithStartCount:@0];
    [self addNotificationObserve];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc {
    [self removeNotificationObserve];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNotificationObserve {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotification:) name:WriteCommentComplish object:nil];
}

- (void)removeNotificationObserve {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - actionMethod

- (void)handleNotification:(NSNotification *)sender {
    if ([sender.name isEqualToString:WriteCommentComplish]) {
        [self requireForHotListWithStartCount:0];
    }
}

@end
