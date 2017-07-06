//
//  BOPictureWheelPlay.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOPictureWheelPlay.h"
#import "SDCycleScrollView.h"
@implementation BOPictureWheelPlay
+ (SDCycleScrollView *)PictureWheelPlayWithFrame:(CGRect)pictureFrame WithImageArray:(NSArray *)images WithTimeInterval:(CGFloat)timeInterval {
  
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:pictureFrame imageNamesGroup:images];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"img_loadingb"];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.autoScrollTimeInterval = timeInterval;
    return cycleScrollView;
}
+ (SDCycleScrollView *)PictureWheelPlayWithFrame:(CGRect)pictureFrame WithPlaceholderImage:(UIImage *)placeholdImage WithUrlImageArray:(NSArray *)urlImages WithTimeIntervarl:(CGFloat)timeInterval {
    // 网络加载图片的轮播器
//        SDCycleScrollView *cycleScrollView = [cycleScrollViewWithFrame:pictureFrame delegate:delegate placeholderImage:placeholderImage];
//        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
//
    // 本地加载图片的轮播器
  
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:pictureFrame imageNamesGroup:urlImages];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"img_loadingb"];
    cycleScrollView.autoScrollTimeInterval = timeInterval;
    cycleScrollView.placeholderImage = placeholdImage;
    return cycleScrollView;
}
@end
