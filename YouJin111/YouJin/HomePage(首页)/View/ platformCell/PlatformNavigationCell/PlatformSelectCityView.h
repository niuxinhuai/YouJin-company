//
//  PlatformSelectCityView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlatformSelectCityViewDelegate <NSObject>

@optional
- (void)platformSelectCityViewSelectCity:(NSString *)selectCIty cityNumber:(NSString *)cityNumber;
@end
@interface PlatformSelectCityView : UIView

@property (nonatomic, weak) id<PlatformSelectCityViewDelegate> delegate;
@end
