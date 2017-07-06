//
//  CommentModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/2.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *time_w;
@property (nonatomic, strong) NSString *time_h;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSNumber *zid;
@property (nonatomic, strong) NSNumber *out_id;
@property (nonatomic, strong) NSNumber *out_type;

@property (nonatomic, assign) CGFloat height;


- (CGFloat)getCellHeight;


@end
