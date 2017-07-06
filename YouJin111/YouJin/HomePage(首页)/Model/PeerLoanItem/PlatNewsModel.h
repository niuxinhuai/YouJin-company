//
//  PlatNewsModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/30.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatNewsModel : NSObject

/**新闻编号*/
@property (nonatomic, copy) NSString *pnid;

/**新闻标题*/
@property (nonatomic, copy) NSString *title;

/**时间*/
@property (nonatomic, copy) NSString *time_h;
@end
