//
//  BOChangeNicknameVC.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^NameChangeBlock)(NSString *newName);

@interface BOChangeNicknameVC : BaseViewController

/**用户昵称*/
@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, copy) NameChangeBlock nameChangeBlock;



@end
