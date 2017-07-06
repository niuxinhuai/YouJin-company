//
//  XHLaunchAd.h
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 2016/6/13.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd

//  版本:3.5.4
//  发布:2017.05.26

//  如果你在使用过程中出现bug,请及时以下面任意一种方式联系我，我会及时修复bug并帮您解决问题。
//  QQ交流群:537476189
//  Email:it7090@163.com
//  新浪微博:朱晓辉Allen

//  GitHub:https://github.com/CoderZhuXH
//  使用说明:https://github.com/CoderZhuXH/XHLaunchAd/blob/master/README.md

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XHLaunchAdConfiguration.h"


NS_ASSUME_NONNULL_BEGIN
@class XHLaunchAd;

@protocol XHLaunchAdDelegate <NSObject>

@optional

/**
 *  广告点击
 *
 *  @param launchAd      launchAd
 *  @param openURLString  打开页面地址
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 下载的image
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image;

/**
 *  video本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  本地保存路径
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL;

/**
 视频下载进度回调

 @param launchAd XHLaunchAd
 @param progress 下载进度
 @param total    总大小
 @param current  当前已下载大小
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current;

/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration;

/**
 *  广告显示完成
 */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd;

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理

 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url;

@end

@interface XHLaunchAd : NSObject

@property(nonatomic,assign) id<XHLaunchAdDelegate> delegate;

/**
 *  设置等待数据源时间(default 3)
 *
 *  @param waitDataDuration waitDataDuration
 */
+(void)setWaitDataDuration:(NSInteger )waitDataDuration;

/**
 *  图片开屏广告数据配置
 *
 *  @param imageAdconfiguration 数据配置
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)imageAdWithImageAdConfiguration:(XHLaunchImageAdConfiguration *)imageAdconfiguration;

/**
 *  图片开屏广告数据配置
 *
 *  @param imageAdconfiguration 数据配置
 *  @param delegate             delegate
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)imageAdWithImageAdConfiguration:(XHLaunchImageAdConfiguration *)imageAdconfiguration delegate:(nullable id)delegate;
/**
 *  视频开屏广告数据配置
 *
 *  @param videoAdconfiguration 数据配置
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)videoAdWithVideoAdConfiguration:(XHLaunchVideoAdConfiguration *)videoAdconfiguration;

/**
 *  视频开屏广告数据配置
 *
 *  @param videoAdconfiguration 数据配置
 *  @param delegate             delegate
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)videoAdWithVideoAdConfiguration:(XHLaunchVideoAdConfiguration *)videoAdconfiguration delegate:(nullable id)delegate;

#pragma mark - 如果你需要提前下载并缓存广告图片或视频 请调用下面方法
/**
 *  批量下载并缓存image(异步)
 *
 *  @param urlArray image URL Array
 */
+(void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray;

/**
 *  批量下载并缓存视频(异步)
 *
 *  @param urlArray 视频URL Array
 */
+(void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray;

#pragma mark - skipAction
/**
 *  跳过按钮事件
 */
+(void)skipAction;

#pragma mark - 是否已缓存
/**
 *  是否已缓存在该图片
 *
 *  @param url image url
 *
 *  @return BOOL
 */
+(BOOL)checkImageInCacheWithURL:(NSURL *)url;

/**
 *  是否已缓存该视频
 *
 *  @param url video url
 *
 *  @return BOOL
 */
+(BOOL)checkVideoInCacheWithURL:(NSURL *)url;

#pragma mark - 获取缓存url
/**
 从缓存中获取上一次的ImageURLString(XHLaunchAd 会默认缓存imageURLString)
 
 @return imageUrlString
 */
+(NSString *)cacheImageURLString;

/**
 从缓存中获取上一次的videoURLString(XHLaunchAd 会默认缓存VideoURLString)
 
 @return videoUrlString
 */
+(NSString *)cacheVideoURLString;

#pragma mark - 缓存清除及大小
/**
 *  清除XHLaunch本地缓存
 */
+(void)clearDiskCache;

/**
 *  获取XHLaunch本地缓存大小(M)
 */
+(float)diskCacheSize;

/**
 *  缓存路径
 */
+(NSString *)xhLaunchAdCachePath;

@end
NS_ASSUME_NONNULL_END
