//
//  PlatformServeDetailCommentModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformServeDetailCommentModel : NSObject
/**用户头像*/
@property (nonatomic, copy) NSString *head_image;
/**用户昵称*/
@property (nonatomic, copy) NSString *uname;
/**评分*/
@property (nonatomic, copy) NSString *score;
/**点评内容*/
@property (nonatomic, copy) NSString *content;
/**点赞数*/
@property (nonatomic, copy) NSString *star;
/**回复数*/
@property (nonatomic, copy) NSString *reply_nums;
/**点评时间*/
@property (nonatomic, copy) NSString *time_h;
/**对应评分细则里第2个的值*/
@property (nonatomic, strong) NSArray *img_url;

@end
