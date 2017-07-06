//
//  NSString+Utilities.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NSString+Utilities.h"
#import "HotCommentModle.h"

@implementation NSString (Utilities)


+ (NSString *)version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)stringWithNumber:(NSNumber *)count add:(BOOL)isAdd {
    NSString *string = isAdd ? @"+" : @"";
    return [string stringByAppendingString:[NSString stringWithFormat:@"%@",count]];
}

+ (NSString *)commentTagetStringWithTarget:(NSString *)targetName {
    NSString *string = @"点评了";
    return [string stringByAppendingString:targetName];
}

+ (NSString *)favourCountString:(NSInteger)favourCount {
    NSString *string = @"";
    string = [NSString stringWithCount:favourCount];
    string = [string stringByAppendingString:@" 赞"];
    return string;
}

+ (NSString *)commentCountString:(NSInteger)commentCount {
    NSString *string = @"";
    string = [NSString stringWithCount:commentCount];
    string = [string stringByAppendingString:@" 评论"];
    return string;
}

+ (NSString *)stringWithCount:(NSInteger)count {
    if (count < 0) {
        return @"0";
    }
    if (count < 1000) {
        return [NSString stringWithFormat:@"%@", @(count)];
    } else {
        CGFloat kCount = count / 1000.0;
        return [NSString stringWithFormat:@"%.1fk", kCount];
    }
}

+ (NSString *)stringWithCount:(NSInteger)count stringWhenZero:(NSString *)zeroString {
    if (count <= 0) {
        return zeroString;
    }
    if (count < 1000) {
        return [NSString stringWithFormat:@"%@", @(count)];
    } else {
        CGFloat kCount = count / 1000.0;
        return [NSString stringWithFormat:@"%.1fk", kCount];
    }
}

+ (NSString *)balanceStringWithBalance:(NSInteger)count {
    if (count < 0) {
        return @"0";
    }
    if (count < 10000) {
        return [NSString stringWithFormat:@"%@", @(count)];
    } else {
        CGFloat kCount = floorf(count / 10000.0);
        return [NSString stringWithFormat:@"%.0f万", kCount];
    }
}

+ (NSString *)commentTargetEvaluateWithHotCommentModel:(HotCommentModle *)model {
    NSString *string = @"";
    if (model && model.reply_child && model.reply_child.count == 4) {
        for (NSInteger i = 0; i < model.reply_child.count; i ++) {
            ReplyChildModel *childModel = model.reply_child[i];
            string = [string stringByAppendingString:childModel.desc];
            switch (i) {
                case 0:
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%.1f",[model.v1 floatValue]]];
                    break;
                case 1:
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%.1f",[model.v2 floatValue]]];
                    break;
                case 2:
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%.1f",[model.v3 floatValue]]];
                    break;
                case 3:
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%.1f",[model.v4 floatValue]]];
                    break;
                default:
                    break;
            }
            if (i != 3) string = [string stringByAppendingFormat:@" · "];
        }
    }
    return string;
}

+ (NSString *)evaluateStringWithObjects:(NSArray <NSString *> *)objects scores:(NSArray <NSNumber *> *)scores {
    if (objects.count != scores.count) return @"";
    NSString *string = @"";
    for (NSInteger i = 0; i < objects.count; i++) {
        string = [string stringByAppendingString:objects[i]];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%.1f",[scores[i] floatValue]]];
        if (i != objects.count - 1) {
            string = [string stringByAppendingFormat:@" · "];
        }
    }
    return string;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSString *)portStringWithFirstCount:(NSInteger)firstCount firstSuffix:(NSString *)firstSuffix secoundCount:(NSInteger)secoundCount secountSuffix:(NSString *)secountSuffix {
    NSString *countString = [NSString stringWithCount:firstCount];
    countString = [countString stringByAppendingString:firstSuffix];
    countString = [countString stringByAppendingString:@" · "];
    countString = [countString stringByAppendingString:[NSString stringWithCount:secoundCount]];
    countString = [countString stringByAppendingString:secountSuffix];
    return countString;
}


+ (NSString *)cacheSize:(float)size {
    NSString *sizeString = @"";
    if ((int)(size / 1024) > 0) {
        size = size / 1024.0;
        if ((int)(size / 1024) > 0) {
            sizeString = [NSString stringWithFormat:@"%.2fM",size / 1024.0];
        }else {
            sizeString = [NSString stringWithFormat:@"%.2fK",size];
        }
    }else {
        sizeString = [NSString stringWithFormat:@"%.2fB",size];
    }
    return sizeString;
}


- (CGSize)getSizeWithFont:(CGFloat)fontsize constrainedToSize:(CGSize)size andlineSpacing:(CGFloat)lineSpacing
{
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    return [self getSizeFont:font constrainedToSize:size andlineSpacing:lineSpacing];
}


- (CGSize)getSizeFont:(UIFont *)font constrainedToSize:(CGSize)size andlineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (lineSpacing>0) {
        [mutableParagraphStyle setLineSpacing:lineSpacing];
    }
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font,NSParagraphStyleAttributeName:mutableParagraphStyle}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height))+2);
    return resultSize;
}

- (CGSize)getSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:attribute
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height))+2);
    return resultSize;
}

- (BOOL)isUrl
{
    if(self == nil)
        return NO;
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = self;
    }
    NSString *urlRegex = @"(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

- (NSInteger)caculateStringLength {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    if (enc != kCFStringEncodingInvalidId) {
        NSData *stringData = [self dataUsingEncoding:enc];
        return [stringData length];
    }
    return 0;
}

- (NSString *)trimmingCharacterWhenWhiteSpace {
    NSString *repalceString = self;
    repalceString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (repalceString.length == 0) {
        repalceString = @"";
    }
    return repalceString;
}

- (BOOL)isNum {
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)judgeLegalCharacter{
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [emailTest evaluateWithObject:self];
}

@end
