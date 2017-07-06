//
//  BankDepoTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YhcgTableV;
@interface BankDepoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Logeimages;//logo
@property (weak, nonatomic) IBOutlet UILabel *lilvLabel;//利率
@property (weak, nonatomic) IBOutlet UILabel *jrLabel;//业务类型
@property (weak, nonatomic) IBOutlet UILabel *yhLabel;//存管银行
@property (nonatomic ,strong) YhcgTableV *item;
@end
