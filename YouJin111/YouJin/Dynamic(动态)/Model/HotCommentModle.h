//
//  HotCommentModle.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyChildModel : NSObject

@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSNumber *out_type;

@end

@interface HotCommentModle : NSObject

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *before;
@property (nonatomic, retain) NSArray<ReplyChildModel *> *reply_child;
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSNumber *out_type;
@property (nonatomic, retain) NSNumber *fid;
@property (nonatomic, retain) NSNumber *zid;
@property (nonatomic, retain) NSNumber *v1;
@property (nonatomic, retain) NSNumber *v2;
@property (nonatomic, retain) NSNumber *v3;
@property (nonatomic, retain) NSNumber *v4;
@property (nonatomic, retain) NSString *head_image;
@property (nonatomic, retain) NSString *uname;
@property (nonatomic, retain) NSString *object;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *time_h;
@property (nonatomic, retain) NSNumber *out_id;
@property (nonatomic, retain) NSNumber *pid;
@property (nonatomic, retain) NSNumber *score;
@property (nonatomic, retain) NSNumber *company_vip;
@property (nonatomic, retain) NSNumber *person_vip;

@property (nonatomic, assign) CGFloat height;

- (CGFloat)getCellHeight;


@end
