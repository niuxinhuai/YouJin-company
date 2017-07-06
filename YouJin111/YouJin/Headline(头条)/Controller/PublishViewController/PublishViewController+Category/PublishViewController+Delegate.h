//
//  PublishViewController+Delegate.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishTableHeaderView.h"

@interface PublishViewController (Delegate)<UITableViewDelegate,ContentPartCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,PublishTableHeaderViewDelegate>

@end
