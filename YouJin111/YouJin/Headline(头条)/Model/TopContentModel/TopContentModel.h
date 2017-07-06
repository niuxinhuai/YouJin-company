//
//  TopContentModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TopContentText,
    TopContentOneImage,
    TopContentThreeImage
}TopContentType;

@interface TopContentModel : NSObject

@property (nonatomic, retain) NSString *time_h;
@property (nonatomic, retain) NSNumber *is_myself;
@property (nonatomic, retain) NSNumber *tid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *click;
@property (nonatomic, retain) NSNumber *mid;
@property (nonatomic, retain) NSString *time_end;
@property (nonatomic, retain) NSString *uname;
@property (nonatomic, retain) NSNumber *lines;
@property (nonatomic, retain) NSNumber *share;
@property (nonatomic, retain) NSNumber *get_gift_ubi;
@property (nonatomic, retain) NSNumber *is_open;
@property (nonatomic, retain) NSArray *cover;
@property (nonatomic, retain) NSNumber *is_stick;
@property (nonatomic, retain) NSNumber *gift_nums;
@property (nonatomic, retain) NSNumber *is_del;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSNumber *star;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSNumber *company_vip;
@property (nonatomic, retain) NSNumber *person_vip;
@property (nonatomic, retain) NSNumber *is_friend;
@property (nonatomic, retain) NSNumber *is_star;
@property (nonatomic, retain) NSNumber *is_collect;
@property (nonatomic, retain) NSString *head_image;
@property (nonatomic, retain) NSString *no_tag;

@property (nonatomic, assign) TopContentType contentType;

- (CGFloat)cellHeight;

@end
