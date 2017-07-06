//
//  ContentPublishModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentPartModel.h"

@interface ContentPublishModel : NSObject


@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSNumber *mid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray<ContentPartModel *> *content;
@property (nonatomic, retain) NSArray *image_array;
@property (nonatomic, retain) NSNumber *is_myself;



@end
