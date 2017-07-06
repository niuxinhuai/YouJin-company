//
//  BOSettingGroupItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOSettingGroupItem : NSObject
@property (nonatomic, copy) NSString *HeaderT;
@property (nonatomic, copy) NSString *footerT;

/**
 *  一组当中有多少行
 */
@property (nonatomic, strong) NSArray *rowItemArray;

+ (instancetype)ItemWithRowItemArray:(NSArray *)rowItemArray;

@end
