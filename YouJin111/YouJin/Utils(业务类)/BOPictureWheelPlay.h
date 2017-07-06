//
//  BOPictureWheelPlay.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDCycleScrollView;
@interface BOPictureWheelPlay : NSObject

/**加载本地图片轮播 
 1.展示图片frame
 2.图片数组 
 3.自动轮播时间间隔
 */
+ (SDCycleScrollView *)PictureWheelPlayWithFrame:(CGRect)pictureFrame WithImageArray:(NSArray *)images WithTimeInterval:(CGFloat)timeInterval;
/**加载网络图片轮播
 1.展示图片frame
 2.占位图片
 3.图片数组
 4.自动轮播时间间隔
 */
+ (SDCycleScrollView *)PictureWheelPlayWithFrame:(CGRect)pictureFrame WithPlaceholderImage:(UIImage *)placeholdImage WithUrlImageArray:(NSArray *)urlImages WithTimeIntervarl:(CGFloat)timeInterval;
@end
