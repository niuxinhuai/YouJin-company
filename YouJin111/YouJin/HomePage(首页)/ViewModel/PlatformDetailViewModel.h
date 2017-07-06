//
//  PlatformDetailViewModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BODynamicItem;
@interface PlatformDetailViewModel : NSObject
@property (nonatomic, strong) BODynamicItem *item;
@property (nonatomic, assign) CGRect topFrame;
@property (nonatomic, assign) CGRect pictureViewFrame;
@property (nonatomic, assign) CGRect bottomFrame;
@property (nonatomic, assign) CGFloat cellH;
@end
