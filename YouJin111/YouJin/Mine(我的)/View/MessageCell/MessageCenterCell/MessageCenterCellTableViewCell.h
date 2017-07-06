//
//  MessageCenterCellTableViewCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageCenterModel.h"

typedef enum {
    kReplyMessage = 1,
    kSystemMessage,
    kFocusMessage,
    kOfficialMessage
}MessageCenterType;

@interface MessageCenterCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) MessageCenterType type;
@property (nonatomic, strong) MessageCenterModel *model;

- (void)updateMessageModel:(MessageCenterModel *)model messageType:(MessageCenterType)type;



@end
