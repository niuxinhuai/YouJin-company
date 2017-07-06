//
//  BONoteVerifyLogiin.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol BONoteVerifyLogiinDelegate;

@interface BONoteVerifyLogiin : BaseViewController


@property (nonatomic, weak) id<BONoteVerifyLogiinDelegate> delegate;


@end


@protocol BONoteVerifyLogiinDelegate <NSObject>

@optional
- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc;

@end

