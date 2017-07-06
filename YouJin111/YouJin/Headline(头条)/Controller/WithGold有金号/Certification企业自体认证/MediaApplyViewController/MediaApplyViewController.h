//
//  MediaApplyViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"

@interface MediaApplyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *declareTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitButtonLeftToSuper;

+ (instancetype)create;



@end
