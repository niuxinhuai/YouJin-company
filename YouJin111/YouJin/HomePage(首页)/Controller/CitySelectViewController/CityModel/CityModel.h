//
//  CityModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDetailModel : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;

@end

@interface CityModel : NSObject


@property (nonatomic, strong) NSString *alifName;
@property (nonatomic, strong) NSArray<CityDetailModel *> *addressList;


@end
