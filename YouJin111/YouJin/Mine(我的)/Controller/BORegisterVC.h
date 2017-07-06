//
//  BORegisterVC.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol BORegisterVCDelegate;

@interface BORegisterVC : BaseViewController

@property (nonatomic, weak) id<BORegisterVCDelegate> delegate;

@end


@protocol BORegisterVCDelegate <NSObject>

@optional
- (void)BORegisterVCDelegateDidRegisterSuccess:(BORegisterVC *)registerVC;

@end
