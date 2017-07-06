//
//  ImageUploadManager.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ImageUploadManager.h"
#import <QNResponseInfo.h>
#import "NSMutableDictionary+Utilities.h"

const NSString *uploadImagesKey = @"images";
const NSString *uploadKeysKey = @"keys";

@implementation ImageUploadManager


+ (instancetype)imageUploadManagerWithDelegate:(id<ImageUploadManagerDelegate>)delegate {
    ImageUploadManager *manager =  [[ImageUploadManager alloc]init];
    manager.delegate = delegate;
    return manager;
}


- (void)reuploadFailImages {
    NSMutableDictionary *failDics = [self.failImageDic mutableCopy];
    [self.failImageDic removeAllObjects];
    self.failImageDic = nil;
    NSMutableArray *images = [failDics objectForKey:uploadImagesKey];
    NSMutableArray *keys = [failDics objectForKey:uploadKeysKey];
    [self uploadImages:images keys:keys isReupload:YES];
}

- (void)uploadImages:(NSArray<UIImage *> *)images keys:(NSArray<NSString *> *)keys isReupload:(BOOL)isReupload {
    self.uploadCount = 0;
    self.totalUploadCount = images.count;
    if (!isReupload) {
        [self.imagesDic setObject:images forKey:uploadImagesKey];
        [self.imagesDic setObject:keys forKey:uploadKeysKey];
    }
    for (NSInteger i = 0; i < self.totalUploadCount; i ++) {
        [self uploadImage:images[i] key:keys[i] complish:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            [self uploadComplishWithImage:images[i] key:keys[i] responseInfo:info];
            NSLog(@"dajdhaks");
        }];
    }
}


- (void)uploadImage:(UIImage *)image key:(NSString *)key complish:(QNUpCompletionHandler)completionHandler{
    [self uploadImage:image key:key option:nil complish:completionHandler];
}


- (void)uploadImage:(UIImage *)image key:(NSString *)key option:(QNUploadOption *)option complish:(QNUpCompletionHandler)completionHandle{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [self requireTokenToUploadImage:image key:key option:option complish:completionHandle];
//    if ([userDefault objectForKey:@"QNToken"]) {
//        NSString *token = [userDefault objectForKey:@"QNToken"];
//        [self uploadImage:image key:key token:token option:option complish:completionHandle];
//    }else {
//        [self requireTokenToUploadImage:image key:key option:option complish:completionHandle];
//    }
}

- (void)uploadImage:(UIImage *)image key:(NSString *)key token:(NSString *)token option:(QNUploadOption *)option complish:(QNUpCompletionHandler)completionHandle{
    NSData *data = UIImagePNGRepresentation(image);
    [self.uploadManger putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (completionHandle) {
            completionHandle(info,key,resp);
        }
    } option:option];
    
}


- (void)requireTokenToUploadImage:(UIImage *)image key:(NSString *)key option:(QNUploadOption *)option complish:(QNUpCompletionHandler)completionHandle{
    [self.manager POST:QNTokenUrl parameters:[NSDictionary dictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"token"] forKey:@"QNToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self uploadImage:image key:key token:responseObject[@"token"] option:option complish:completionHandle];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}


- (QNUploadManager *)uploadManger {
    if (!_uploadManger) {
        _uploadManger = [[QNUploadManager alloc]init];
    }
    return _uploadManger;
}

- (NSMutableDictionary *)failImageDic {
    if (!_failImageDic) {
        _failImageDic = [NSMutableDictionary dictionary];
    }
    return _failImageDic;
}

- (NSMutableDictionary *)imagesDic {
    if (!_imagesDic) {
        _imagesDic = [NSMutableDictionary dictionary];
    }
    return _imagesDic;
}

#pragma mark - helpMethod

- (void)uploadComplishWithImage:(UIImage *)image key:(NSString *)key responseInfo:(QNResponseInfo *)info {
    self.uploadCount ++;
    if (info.statusCode != 200) {
        NSMutableArray *images = [self.failImageDic objectForKey:uploadImagesKey];
        if (!images) images = [NSMutableArray array];
        NSMutableArray *keys = [self.failImageDic objectForKey:uploadKeysKey];
        if (!keys) keys = [NSMutableArray array];
        [images addObject:image];
        [keys addObject:key];
        [self.failImageDic setObject:images forKey:uploadImagesKey];
        [self.failImageDic setObject:keys forKey:uploadKeysKey];
    }
    if (self.uploadCount == self.totalUploadCount) {
        if (self.failImageDic.count == 0) {
            if ([self.delegate respondsToSelector:@selector(imageUploadManagerUploadImagesSuccess:)]) {
                [self.delegate imageUploadManagerUploadImagesSuccess:self];
            }
        }else {
            if ([self.delegate respondsToSelector:@selector(imageUploadManagerUploadImagesFail:)]) {
                [self.delegate imageUploadManagerUploadImagesFail:self];
            }
        }
    }
}


@end
