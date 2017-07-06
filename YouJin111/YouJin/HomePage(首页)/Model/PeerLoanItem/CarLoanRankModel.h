//
//  CarLoanRankModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLoanRankModel : NSObject

/**公司logourl*/
@property (nonatomic, copy) NSString *logo;

/**平台名称*/
@property (nonatomic, copy) NSString *apr;

/**交易量*/
@property (nonatomic, copy) NSString *trade;

/**借款人数*/
@property (nonatomic, copy) NSString *borrower_num;
/**投资人数*/
@property (nonatomic, copy) NSString *tender_num;
@end
