//
//  PublishViewController+LogicalFlow.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishViewController+Configuration.h"

@interface PublishViewController (LogicalFlow)


- (void)uploadImagesWithContents:(NSArray<ContentPartModel *> *)contents;
- (void)uploadImageContent:(ContentPartModel *)content;

- (void)createNewContentWithContentPublishModel:(ContentPublishModel *)model;


@end
