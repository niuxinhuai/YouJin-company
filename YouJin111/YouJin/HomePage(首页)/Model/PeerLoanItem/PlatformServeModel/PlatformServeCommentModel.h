//
//  PlatformServeCommentModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformServeCommentModel : NSObject

/**用户头像*/
@property (nonatomic, copy) NSString *head_image;
/**用户昵称*/
@property (nonatomic, copy) NSString *uname;
/**评分*/
@property (nonatomic, copy) NSString *score;
/**点评内容*/
@property (nonatomic, copy) NSString *content;
/**点评的对象*/
@property (nonatomic, copy) NSString *object;
/**评分细则*/
@property (nonatomic, copy) NSString *reply_child;
/**对应评分细则里第1个的值*/
@property (nonatomic, copy) NSString *v1;
/**对应评分细则里第2个的值*/
@property (nonatomic, copy) NSString *v2;
/**对应评分细则里第3个的值*/
@property (nonatomic, copy) NSString *v3;
/**对应评分细则里第4个的值*/
@property (nonatomic, copy) NSString *v4;
/**logo*/
@property (nonatomic, copy) NSString *logo;
/**点评编号*/
@property (nonatomic ,copy)NSString *pid;
/**时间*/
@property (nonatomic, copy) NSString *before;

@property (nonatomic ,copy) NSString *out_id;
@property (nonatomic ,copy) NSString *out_type;
@property (nonatomic ,copy) NSString *fid;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,copy) NSString *zid;
@end
