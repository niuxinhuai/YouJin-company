//
//  MasksView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MasksView.h"
#import "SignInsModel.h"

@implementation MasksView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.35];
        [self latelyEightTime];
        _aFewDaysImage = [[UIImageView alloc]initWithFrame:CGRectMake(54*BOScreenW/750, 170*BOScreenH/1334, 642*BOScreenW/750, 674*BOScreenH/1334)];
        _aFewDaysImage.userInteractionEnabled = YES;
        _aFewDaysImage.image = [UIImage imageNamed:@"img_qiandaobox"];
        [self addSubview:_aFewDaysImage];
        
        //第n天
        _tWoLabel = [[UILabel alloc]initWithFrame:CGRectMake(196*BOScreenW/750, 160*BOScreenH/1334, 250*BOScreenW/750, 40*BOScreenH/1334)];
//        tWoLabel.text = @"第2天";
        _tWoLabel.textAlignment = NSTextAlignmentCenter;
        _tWoLabel.font = [UIFont systemFontOfSize:18];
        _tWoLabel.textColor = [UIColor whiteColor];
        [_aFewDaysImage addSubview:_tWoLabel];
//        //第n天
//        _tWosLabel = [[UILabel alloc]initWithFrame:CGRectMake(241*BOScreenW/750, 141*BOScreenH/1334, 160*BOScreenW/750, 60*BOScreenH/1334)];
////        _tWosLabel.text = @"2";
//        _tWosLabel.textAlignment = NSTextAlignmentCenter;
//        [_tWosLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:36]];
//        _tWosLabel.textColor = [UIColor colorWithHexString:@"#ffeda2" alpha:1];
//        [_aFewDaysImage addSubview:_tWosLabel];
//        if (iPhone5)
//        {
//            tWoLabel.frame = CGRectMake(171*BOScreenW/750, 160*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334);
//            tWoLabel.text = @"第         天";
//            _tWosLabel.frame = CGRectMake(241*BOScreenW/750, 138*BOScreenH/1334, 160*BOScreenW/750, 65*BOScreenH/1334);
//        }
        
//        //好友帮你额外获得 100 U币
//        UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(71*BOScreenW/750, 256*BOScreenH/1334, 500*BOScreenW/750, 40*BOScreenH/1334)];
//        helpLabel.text = @"好友帮你额外获得 100 U币";
//        helpLabel.textAlignment = NSTextAlignmentCenter;
//        [helpLabel setFont:[UIFont systemFontOfSize:15]];
//        helpLabel.textColor = [UIColor whiteColor];
//        [_aFewDaysImage addSubview:helpLabel];
//        // 改变颜色和大小
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"好友帮你额外获得 100 U币"]];
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff7e15" alpha:1] range:NSMakeRange(9, 3)];
//        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(9,3)];
//        helpLabel.attributedText = str;
        
        //下面的图片和文字
//        NSArray *arr = @[@"0",@"50",@"100",@"150",@"200",@"300"];
//        NSArray *dataArr = @[@"昨天",@"今天",@"12.21",@"12.22",@"12.23",@"12.24"];
        _timeArr = [[NSMutableArray alloc]initWithObjects:@"昨天",@"今天", nil];
        [_timeArr addObjectsFromArray:_fourArr];
        for (int i = 0; i < 6; i ++)
        {
//            UIButton *biButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            biButton.frame = CGRectMake(46*BOScreenW/750 + i*(60*BOScreenW/750+38*BOScreenW/750), 372*BOScreenH/1334, 60*BOScreenW/750, 76*BOScreenH/1334);
//            [biButton setTitle:arr[i] forState:UIControlStateNormal];
//            biButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
//            [biButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.7] forState:UIControlStateNormal];
//            [biButton setBackgroundImage:[UIImage imageNamed:@"icon_qiandao_nor"] forState:UIControlStateNormal];
//            biButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, -10, 0);
//            [_aFewDaysImage addSubview:biButton];
            
            //日期
            UILabel *dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(41*BOScreenW/750 + i*(60*BOScreenW/750+38*BOScreenW/750), 463*BOScreenH/1334, 70*BOScreenW/750, 30*BOScreenH/1334)];
            dataLabel.text = _timeArr[i];
            dataLabel.textAlignment = NSTextAlignmentCenter;
            [dataLabel setFont:[UIFont systemFontOfSize:11]];
            dataLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.5];
            [_aFewDaysImage addSubview:dataLabel];
            
            //叉号的button
            _crossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _crossBtn.frame = CGRectMake(0, 0, 66*BOScreenW/750, 66*BOScreenW/750);
            [_aFewDaysImage addSubview:_crossBtn];
            //签到规则的按钮
            _theRulesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _theRulesBtn.frame = CGRectMake(466*BOScreenW/750, 0, 176*BOScreenW/750, 113*BOScreenW/750);
            [_aFewDaysImage addSubview:_theRulesBtn];
        }
    }
    return self;
}
-(void)setItem:(SignInsModel *)item
{
    _item = item;
//    _tWosLabel.text = item.serial_days;
    _tWoLabel.text = [NSString stringWithFormat:@"第 %@ 天",item.serial_days];
    [self messageAction:_tWoLabel startString:@"第" endString:@"天" andAllColor:[UIColor whiteColor] andMarkColor:[UIColor colorWithHexString:@"#ffeda2" alpha:1] andMarkFondSize:36];
    //签到前一天
    if ([item.serial_days integerValue] > 4)
    {
        _ubiNumberStr = [NSString stringWithFormat:@"%d",[item.slice intValue]-100];
        _threeStr = item.slice;
        _fourStr = item.slice;
        _fiveStr = item.slice;
        _sixStr = item.slice;
    }else if ([item.serial_days integerValue] == 1)
    {
        _ubiNumberStr = [NSString stringWithFormat:@"%d",[item.slice intValue]-50];
        _threeStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+50];
        _fourStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
        _fiveStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+150];
        _sixStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+250];
    }else if ([item.serial_days integerValue] == 2)
    {
        _ubiNumberStr = [NSString stringWithFormat:@"%d",[item.slice intValue]-50];
        _threeStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+50];
        _fourStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
        _fiveStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+200];
        _sixStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+200];
    }else if ([item.serial_days integerValue] == 3)
    {
        _ubiNumberStr = [NSString stringWithFormat:@"%d",[item.slice intValue]-50];
        _threeStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+50];
        _fourStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+150];
        _fiveStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+150];
        _sixStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+150];
    }else if ([item.serial_days integerValue] == 4)
    {
        _ubiNumberStr = [NSString stringWithFormat:@"%d",[item.slice intValue]-50];
        _threeStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
        _fourStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
        _fiveStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
        _sixStr = [NSString stringWithFormat:@"%ld",(long)[item.slice integerValue]+100];
    }else
    {
        
    }
    //    NSArray *arr = @[@"0",@"50",@"100",@"150",@"200",@"300"];
    NSArray *arr = @[_ubiNumberStr,item.slice,_threeStr,_fourStr,_fiveStr,_sixStr];
//    NSLog(@"kkklklklklkl%@",arr);
    for (int i = 0; i < 6; i ++)
    {
        UIButton *biButton = [UIButton buttonWithType:UIButtonTypeCustom];
        biButton.frame = CGRectMake(46*BOScreenW/750 + i*(60*BOScreenW/750+38*BOScreenW/750), 372*BOScreenH/1334, 60*BOScreenW/750, 76*BOScreenH/1334);
        [biButton setTitle:arr[i] forState:UIControlStateNormal];
        biButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [biButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.7] forState:UIControlStateNormal];
        [biButton setBackgroundImage:[UIImage imageNamed:@"icon_qiandao_nor"] forState:UIControlStateNormal];
        biButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, -10, 0);
        [_aFewDaysImage addSubview:biButton];
        
        if ([item.slice isEqualToString:@"50"])
        {
            if (i == 0)
            {
                [biButton setTitle:@"" forState:UIControlStateNormal];
                [biButton setBackgroundImage:[UIImage imageNamed:@"icon_qiandao_d"] forState:UIControlStateNormal];
            }
        }
        if (i == 1)
        {
            [biButton setBackgroundImage:[UIImage imageNamed:@"icon_qiandao_h"] forState:UIControlStateNormal];
            [biButton setTitleColor:[UIColor colorWithHexString:@"#2bc1f0" alpha:0.7] forState:UIControlStateNormal];
        }
    }
}
//获取最近4天时间 数组
-(void)latelyEightTime
{
    _fourArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++)
    {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = (i+1)*24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M.d"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [_fourArr addObject:strTime];
    }
}

//改变字符start 和 end 之间的字符的颜色 和 字体大小
- (void)messageAction:(UILabel *)theLab startString:(NSString *)start endString:(NSString *)end andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize
{
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    // 'x''y'字符的范围
    NSRange tempRange = NSMakeRange(0, 0);
    if ([self judgeStringIsNull:start]) {
        tempRange = [tempStr rangeOfString:start];
    }
    NSRange tempRangeOne = NSMakeRange([strAtt length], 0);
    if ([self judgeStringIsNull:end]) {
        tempRangeOne =  [tempStr rangeOfString:end];
    }
    // 更改字符颜色
    NSRange markRange = NSMakeRange(tempRange.location+tempRange.length, tempRangeOne.location-(tempRange.location+tempRange.length));
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    // 更改字体
    // [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] range:NSMakeRange(0, [strAtt length])];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}
//判断字符串是否不全为空
- (BOOL)judgeStringIsNull:(NSString *)string {
    if ([[string class] isSubclassOfClass:[NSNumber class]]) {
        return YES;
    }
    BOOL result = NO;
    if (string != nil && string.length > 0) {
        for (int i = 0; i < string.length; i ++) {
            NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
            if (![subStr isEqualToString:@" "] && ![subStr isEqualToString:@""]) {
                result = YES;
            }
        }
    }
    return result;
}
@end
