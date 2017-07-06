//
//  PublishViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController+LogicalFlow.h"
#import <QNResponseInfo.h>
#import "NSMutableDictionary+Utilities.h"

@implementation PublishViewController (LogicalFlow)


- (void)uploadImagesWithContents:(NSArray<ContentPartModel *> *)contents {
    for (ContentPartModel *model in contents) {
        if ([model.type intValue] == 2 && model.word.length == 0 && model.cardImage) {
            [self uploadImageContent:model];
        }
    }
}


- (void)uploadImageContent:(ContentPartModel *)content {
    NSDate *datenow = [NSDate date];
    NSString *imageKey = [NSString stringWithFormat:@"top_uid%@_%ld",USERUID, (long)([datenow timeIntervalSince1970] * 1000)];
   [self.imageUploadManager uploadImage:content.cardImage key:imageKey complish:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
       if (info.ok) {
           content.word = key;
           content.status = ImageUploadSuccess;
       }else {
           [self toast:@"上传图片失败" complete:nil];
           content.status = ImageUploadFail;
       }
       [self.tableView reloadData];
   }];
}


- (void)createNewContentWithContentPublishModel:(ContentPublishModel *)model {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/addTop"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:USERUID forKey:@"uid"];
    [param setObject:USERSid forKey:@"sid"];
    [param setNewObject:model.mid forKey:@"mid"];
    [param setNewObject:model.title forKey:@"title"];
    [param setNewObject:model.is_myself forKey:@"is_myself"];
    [param setNewObject:[NSString jsonStringWithArray:model.image_array]  forKey:@"image_array"];
    if (model.content && model.content.count > 0) {
        NSMutableArray *partContents = [NSMutableArray array];
        for (ContentPartModel *partTool in model.content) {
            NSMutableDictionary *partDic = [NSMutableDictionary dictionary];
            [partDic setNewObject:[partTool.type stringValue] forKey:@"tag"];
            [partDic setNewObject:partTool.word forKey:@"word"];
            [partContents addObject:partDic];
        }
        [param setNewObject:[NSString jsonStringWithArray:partContents] forKey:@"content"];
    }
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            [self toast:@"发表成功" complete:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
            self.complishButton.enabled = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.complishButton.enabled = YES;
    }];
}


@end
