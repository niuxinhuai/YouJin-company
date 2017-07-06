//
//  MineInfomationViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController+LogicalFlow.h"
#import "MineInfomationViewController+Configures.h"
#import "NSMutableDictionary+Utilities.h"
#import "ImageConpressManager.h"

@implementation MineInfomationViewController (LogicalFlow)

- (void)requireUserData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getUserBaseInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            [self updateUserMessageItem:[SelfDataItem mj_objectWithKeyValues:responseObject[@"data"]]];
            if (!self.oldItem) {
                self.oldItem = [SelfDataItem mj_objectWithKeyValues:responseObject[@"data"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


- (void)requireForUpdateUserInfoSuccessBlock:(dispatch_block_t)successBlock{
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/updateBaseInfo",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:self.item.sex forKey:@"sex"];
    [param setNewObject:self.item.flag forKey:@"flag"];
    if (![self.item.uname isEqualToString:self.oldItem.uname]) [param setNewObject:self.item.uname forKey:@"uname"];
    [self.mgr POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self synchronizeLocalMessage];
            if (successBlock) {
                successBlock();
            }
            [self toast:@"更新成功" complete:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)requireForUpdateServiceHeadImageUrl:(NSString *)urlKey iamgeData:(NSData *)imageData successBlock:(dispatch_block_t)successBlock{
    NSString *urlString = [NSString stringWithFormat:@"%@Ucenter/uploadHeadImage",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"head_image"] = urlKey;
    [self.mgr POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"head_image"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.item.headImage = nil;
            if (successBlock) {
                successBlock();
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)uploadHeadImageWithImage:(UIImage *)image token:(NSString *)token successBlock:(dispatch_block_t)successBlock {
    UIImage *newImage = [UIImage imageWithData: [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:120 JPEGCompress:YES MaxSize_KB:20]];
    NSData *data = UIImagePNGRepresentation(newImage);
    NSString *key = [NSString stringWithFormat:@"head_%@_%ld",USERUID, (long)([[NSDate date] timeIntervalSince1970] * 1000)];
    [self.upManager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        [self requireForUpdateServiceHeadImageUrl:key iamgeData:data successBlock:successBlock];
    } option:nil];
}

- (void)requireQiNiuTokenSuccessBlock:(dispatch_block_t)successBlock {
    [self.mgr POST:QNTokenUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"] && ![responseObject[@"token"] isKindOfClass:[NSNull class]]) {
            [self uploadHeadImageWithImage:self.item.headImage token:responseObject[@"token"] successBlock:successBlock];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - helpMethod

- (void)synchronizeLocalMessage {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.item.sex forKey:@"sex"];
    [userDefault setObject:self.item.flag forKey:@"flag"];
    [userDefault setObject:self.item.uname forKey:@"uname"];
    [userDefault synchronize];
}


@end
