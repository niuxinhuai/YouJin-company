//
//  ImageUploadManager.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QNUploadManager.h>

@protocol ImageUploadManagerDelegate;

extern NSString *uploadImagesKey;
extern NSString *uploadKeysKey;

@interface ImageUploadManager : NSObject


@property (nonatomic, strong) QNUploadManager *uploadManger;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, assign) id<ImageUploadManagerDelegate> delegate;

@property (nonatomic, strong) NSMutableDictionary *failImageDic;
@property (nonatomic, strong) NSMutableDictionary *imagesDic;
@property (nonatomic, assign) NSInteger uploadCount;
@property (nonatomic, assign) NSInteger totalUploadCount;


+ (instancetype)imageUploadManagerWithDelegate:(id<ImageUploadManagerDelegate>)delegate;

- (void)reuploadFailImages;
- (void)uploadImages:(NSArray<UIImage *> *)images keys:(NSArray<NSString *> *)keys isReupload:(BOOL)isReupload;
- (void)uploadImage:(UIImage *)image key:(NSString *)key complish:(QNUpCompletionHandler)completionHandler;
- (void)uploadImage:(UIImage *)image key:(NSString *)key option:(QNUploadOption *)option complish:(QNUpCompletionHandler)completionHandle;


@end



@protocol ImageUploadManagerDelegate <NSObject>

@optional
- (void)imageUploadManagerUploadImagesSuccess:(ImageUploadManager *)manager;
- (void)imageUploadManagerUploadImagesFail:(ImageUploadManager *)manager;

@end
