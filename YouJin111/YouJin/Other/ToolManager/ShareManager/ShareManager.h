//
//  ShareManager.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/SSDKTypeDefine.h>
#import <ShareSDK/SSDKUser.h>

@protocol ShareManagerDelegate;


@interface ShareManager : NSObject

@property (nonatomic, assign) id<ShareManagerDelegate> delegate;

+ (instancetype)shareManagerStandardWithDelegate:(id<ShareManagerDelegate>)delegate;
- (void)registShareSDK;
- (void)loginWithPlatformType:(SSDKPlatformType)type;
- (void)shareInView:(UIView *)view text:(NSString *)text image:(id)image url:(NSString *)url title:(NSString *)title objid:(NSNumber *)objid;
- (NSDictionary *)keyValuesWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform;

@end



@protocol ShareManagerDelegate <NSObject>

@optional
//login
- (void)shareManager:(ShareManager *)manager loginSuccessWithResponse:(SSDKUser *)user platform:(SSDKPlatformType)platform;
- (void)shareManager:(ShareManager *)manager loginFailWithError:(NSError *)error platform:(SSDKPlatformType)platform;
- (void)shareManagerLoginDidCancel:(ShareManager *)manager platform:(SSDKPlatformType)platform;

//share
- (void)shareManagerShareDidCancel:(ShareManager *)manager;
- (void)shareManagerShareDidSuccess:(ShareManager *)manager;
- (void)shareManager:(ShareManager *)manager shareDidFailWithError:(NSError *)error;
- (void)shareManagerdDidCloseShareSheetView:(ShareManager *)manager;

@end
