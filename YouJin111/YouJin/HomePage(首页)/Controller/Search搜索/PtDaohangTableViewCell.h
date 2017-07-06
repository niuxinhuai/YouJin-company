//
//  PtDaohangTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PtDaohangModel;
@interface PtDaohangTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *logoImage;
@property (nonatomic ,strong)UILabel *naemLabel;
@property (nonatomic ,strong)PtDaohangModel *item;
@end
