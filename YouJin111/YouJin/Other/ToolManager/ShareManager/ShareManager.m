//
//  ShareManager.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareManager.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "ShareSheetView.h"
#import "ShareTool.h"
#import "NSMutableDictionary+Utilities.h"

@interface ShareManager ()<ShareSheetViewDelegate>

@property (nonatomic, retain) ShareTool *tool;
@property (nonatomic, retain) ShareSheetView *shareSheetView;

@end

@implementation ShareManager



+ (instancetype)shareManagerStandardWithDelegate:(id<ShareManagerDelegate>)delegate {
    static ShareManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[ShareManager alloc] init];
    });
    manager.delegate = delegate;
    return manager;
}


- (void)registShareSDK {
    [ShareSDK registerApp:ShareSDKKey activePlatforms:[self activePlatforms] onImport:^(SSDKPlatformType platformType) {
        [self importWithPlatformType:platformType];
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        [self configureWithPlatformType:platformType appInfo:appInfo];
    }];
}


#pragma mark - share

- (void)shareInView:(UIView *)view text:(NSString *)text image:(id)image url:(NSString *)url title:(NSString *)title objid:(NSNumber *)objid {
    self.tool.title = title;
    self.tool.url = url;
    self.tool.sharetext = text;
    self.tool.image = image;
    self.tool.objcid = objid;
    self.shareSheetView = [ShareSheetView createWithCollectionDelegate:self];
    [self.shareSheetView showInTheView:view animation:YES];
}


#pragma mark - login

- (void)loginWithPlatformType:(SSDKPlatformType)type {
    [ShareSDK authorize:type settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:{
                if ([self.delegate respondsToSelector:@selector(shareManager: loginSuccessWithResponse: platform:)]) {
                    [self.delegate shareManager:self loginSuccessWithResponse:user platform:type];
                }
            }
                break;
            case SSDKResponseStateFail: {
                if ([self.delegate respondsToSelector:@selector(shareManager: loginFailWithError: platform:)]) {
                    [self.delegate shareManager:self loginFailWithError:error platform:type];
                }
            }
                break;
            case SSDKResponseStateCancel: {
                if ([self.delegate respondsToSelector:@selector(shareManagerLoginDidCancel: platform:)]) {
                    [self.delegate shareManagerLoginDidCancel:self platform:type];
                }
            }
                break;
            default:
                break;
        }
    }];
}


#pragma mark - reget 

- (ShareTool *)tool {
    if (!_tool) {
        _tool = [[ShareTool alloc]init];
    }
    return _tool;
}


#pragma mark - <ShareSheetViewDelegate>

- (void)shareSheetViewdidCancelShare:(ShareSheetView *)view {
    if ([self.delegate respondsToSelector:@selector(shareManagerdDidCloseShareSheetView:)]) {
        [self.delegate shareManagerdDidCloseShareSheetView:self];
    }
    
}
- (void)releaseShareSheetView:(ShareSheetView *)view {
    self.shareSheetView = nil;
}
- (void)shareSheetViewCollectionView:(UICollectionView *)collectionView didSelectWithIndexPath:(NSIndexPath *)indexPath {
    [self.shareSheetView closeWithAnimation:NO];
    ShareSheetCell *cell = (ShareSheetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self shareActionWithPlatformType:cell.plateform.type];
}

#pragma mark - publicMethod

- (NSDictionary *)keyValuesWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform {
    NSMutableDictionary *extractDic = [NSMutableDictionary dictionary];
    NSDictionary *dic = [user.rawData mutableCopy];
    [extractDic setNewObject:dic[@"nickname"] forKey:@"nickname"];
    [extractDic setNewObject:dic[@"openid"] forKey:@"openid"];
    [extractDic setNewObject:dic[@"unionid"] forKey:@"unionid"];
    [extractDic setNewObject:dic[@"sex"] forKey:@"sex"];
    [extractDic setNewObject:dic[@"city"] forKey:@"city"];
    [extractDic setNewObject:dic[@"province"] forKey:@"province"];
    [extractDic setNewObject:dic[@"country"] forKey:@"country"];
    [extractDic setNewObject:dic[@"headimgurl"] forKey:@"head_image"];
    return extractDic;
}


#pragma mark - helpMethod


- (void)shareActionWithPlatformType:(SSDKPlatformType)type {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    SSDKContentType contentType = SSDKContentTypeAuto;
    if (type == SSDKPlatformTypeSinaWeibo) {
        if (self.tool.url || self.tool.url.length > 0) {
            contentType = SSDKContentTypeWebPage;
        }
    }
    [shareParams SSDKSetupShareParamsByText:self.tool.sharetext
                                     images:self.tool.image
                                        url:[NSURL URLWithString:self.tool.url]
                                      title:self.tool.title
                                       type:contentType];
    [shareParams SSDKEnableUseClientShare];
    [ShareSDK share:type
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess: {
                 [self handleShareSuccessPlatformType:type];
             }
                 break;
             case SSDKResponseStateFail: {
                 [self handleShareFailWithError:error];
             }
                 break;
             case SSDKResponseStateCancel: {
                 [self handleShareCancel];
             }
                 break;
             default:
                 break;
         }
     }];

}


- (NSArray *)activePlatforms {
    return @[
             @(SSDKPlatformSubTypeWechatSession),
             @(SSDKPlatformSubTypeWechatTimeline),
             @(SSDKPlatformTypeSinaWeibo),
             @(SSDKPlatformTypeQQ),
             @(SSDKPlatformSubTypeQZone),
             @(SSDKPlatformTypeWechat)
             ];
}

- (void)importWithPlatformType:(SSDKPlatformType)type {
    switch (type) {
        case SSDKPlatformTypeWechat:
        case SSDKPlatformSubTypeWechatTimeline:
        case SSDKPlatformSubTypeWechatSession:
            [ShareSDKConnector connectWeChat:[WXApi class]];
            break;
        case SSDKPlatformSubTypeQZone:
        case SSDKPlatformTypeQQ:
            [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            break;
        case SSDKPlatformTypeSinaWeibo:
            [ShareSDKConnector connectWeibo:[WeiboSDK class]];
            break;
        default:
            break;
    }
}

- (void)configureWithPlatformType:(SSDKPlatformType)type appInfo:(NSMutableDictionary *)appInfo {
    switch (type) {
        case SSDKPlatformTypeSinaWeibo:
            [appInfo SSDKSetupSinaWeiboByAppKey:@"3725150236"
                                      appSecret:@"dc9763f99390217fa7f0c11ffc3b7fea"
                                    redirectUri:@"http://www.sharesdk.cn"
                                       authType:SSDKAuthTypeBoth];
            break;
        case SSDKPlatformTypeWechat:
            [appInfo SSDKSetupWeChatByAppId:@" wx474dccc6198c130f"
                                  appSecret:@"9741b92e2db1efcadafb8413834a3f0d"];
            break;
        case SSDKPlatformTypeQQ:
            [appInfo SSDKSetupQQByAppId:@"1105991634"
                                 appKey:@"0rWcFO7Bo7L6AZfT"
                               authType:SSDKAuthTypeSSO];
            break;
        default:
            break;
    }

}



- (void)handleShareSuccessPlatformType:(SSDKPlatformType)platformType {
    [self hideKeyboard];
    if (self.tool && self.tool.objcid && ![self.tool.objcid isKindOfClass:[NSNull class]]) {
        [self requestForAddUmoney];
    }
    if ([self.delegate respondsToSelector:@selector(shareManagerShareDidSuccess:)]) {
        [self.delegate shareManagerShareDidSuccess:self];
    }
}

- (void)handleShareFailWithError:(NSError *)error {
    [self hideKeyboard];
    if ([self.delegate respondsToSelector:@selector(shareManager: shareDidFailWithError:)]) {
        [self.delegate shareManager:self shareDidFailWithError:error];
    }
}

- (void)handleShareCancel {
    [self hideKeyboard];
    if ([self.delegate respondsToSelector:@selector(shareManagerShareDidCancel:)]) {
        [self.delegate shareManagerShareDidCancel:self];
    }
}


- (void)hideKeyboard {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        [window endEditing:YES];
    }
}


#pragma mark - require

- (void)requestForAddUmoney {
    if (!USERSid) return;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:self.tool.objcid forKey:@"type"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager bo_manager];
    [manager POST:[NSString stringWithFormat:@"%@Common/pushUbiByShare",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"dajkdjaksjd");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end
