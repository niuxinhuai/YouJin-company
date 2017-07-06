//
//  NSString+Utilities.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HotCommentModle;

@interface NSString (Utilities)

+ (NSString *)version;
+ (NSString *)stringWithNumber:(NSNumber *)count add:(BOOL)isAdd;
+ (NSString *)commentTagetStringWithTarget:(NSString *)targetName;
+ (NSString *)commentTargetEvaluateWithHotCommentModel:(HotCommentModle *)model;
+ (NSString *)evaluateStringWithObjects:(NSArray <NSString *> *)objects scores:(NSArray <NSNumber *> *)scores;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)portStringWithFirstCount:(NSInteger)firstCount firstSuffix:(NSString *)firstSuffix secoundCount:(NSInteger)secoundCount secountSuffix:(NSString *)secountSuffix;

+ (NSString *)favourCountString:(NSInteger)favourCount;
+ (NSString *)commentCountString:(NSInteger)commentCount;
+ (NSString *)stringWithCount:(NSInteger)count;
+ (NSString *)stringWithCount:(NSInteger)count stringWhenZero:(NSString *)zeroString;
+ (NSString *)balanceStringWithBalance:(NSInteger)count;
+ (NSString *)cacheSize:(float)size;

- (CGSize)getSizeWithFont:(CGFloat)fontsize constrainedToSize:(CGSize)size andlineSpacing:(CGFloat)lineSpacing;
- (CGSize)getSizeFont:(UIFont *)font constrainedToSize:(CGSize)size andlineSpacing:(CGFloat)lineSpacing;
- (CGSize)getSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size;
- (BOOL)isUrl;
- (NSInteger)caculateStringLength;
- (NSString *)trimmingCharacterWhenWhiteSpace;
- (BOOL)isNum;
- (BOOL)judgeLegalCharacter;



@end
