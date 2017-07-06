//
//  CompanyApplyViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"

@interface CompanyApplyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyWebsiteTextField;
@property (weak, nonatomic) IBOutlet UITextField *operatorTextField;
@property (weak, nonatomic) IBOutlet UILabel *certificateDemandLabel;
@property (weak, nonatomic) IBOutlet UIImageView *certificateImageView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitButtonLeftToSuper;


+ (instancetype)create;


@end
