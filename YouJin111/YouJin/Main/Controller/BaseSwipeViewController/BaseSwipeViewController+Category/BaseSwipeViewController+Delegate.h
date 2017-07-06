//
//  BaseSwipeViewController+Delegate.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController.h"

@interface BaseSwipeViewController (Delegate)<UICollectionViewDelegate,UICollectionViewDataSource,BaseSwipeSubViewControllerDelegate>

- (void)updateContentOffsetWithCurrentScrollView:(UIScrollView *)currenScrollView prepareScrollView:(UIScrollView *)prepareScrollView;

@end
