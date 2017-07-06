//
//  BODynamicViewModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BODynamicItem;
@interface BODynamicViewModel : NSObject
@property (nonatomic, strong) BODynamicItem *item;
@property (nonatomic, assign) CGRect nameTextFrame;
@property (nonatomic, assign) CGRect pictureViewFrame;
@property (nonatomic, assign) CGRect praiseNumberFrame;
@property (nonatomic, assign) CGFloat cellH;
@end
