//
//  UMoneyRankMeItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMoneyRankMeItem : NSObject

/**用户排名 */
@property (nonatomic, copy) NSString *paiming;
/**用户头像 */
@property (nonatomic, copy) NSString *head_image;
/**用户昵称 */
@property (nonatomic, copy) NSString *uname;
/**用户U币总数 */
@property (nonatomic, copy) NSString *v_tot_get_ubi;
@end
