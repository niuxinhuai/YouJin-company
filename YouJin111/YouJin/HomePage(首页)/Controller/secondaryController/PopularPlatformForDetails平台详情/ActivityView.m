//
//  ActivityView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/2.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ActivityView.h"
#import "PlatformDetailsModel.h"

@implementation ActivityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        //新 图片
        UIImageView *newImage = [[UIImageView alloc]initWithFrame:CGRectMake(36*BOScreenW/750, 32*BOScreenH/1334, 26*BOScreenW/750, 26*BOScreenW/750)];
        newImage.image = [UIImage imageNamed:@"icon_xin"];
        [self addSubview:newImage];
        
        //新手活动
        _newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 560*BOScreenW/750, 40*BOScreenH/1334)];
//        _newLabel.text = @"新手活动，新手专属高收益投资项目";
        _newsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _newsLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_newsLabel];
        
        //箭头
        UIImageView *arrowsImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, 30*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [self addSubview:arrowsImage];
        
        //新手活动的按钮
        _newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _newsButton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
        [self addSubview:_newsButton];
        
        //16px分割线
        UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
        newView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:newView];
        
        //官网图片
        CGFloat newViewY = CGRectGetMaxY(newView.frame) + 25*BOScreenH/1334;
        UIImageView *websiteImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, newViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        websiteImage.image = [UIImage imageNamed:@"icon_guanwang"];
        [self addSubview:websiteImage];
        
        //官网
        UILabel *websiteLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, newViewY, 120*BOScreenW/750, 40*BOScreenH/1334)];
        websiteLabel.text = @"官网";
        websiteLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        websiteLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:websiteLabel];
        
        //官网的箭头
        UIImageView *websiteImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, newViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        websiteImages.image = [UIImage imageNamed:@"common_goto"];
        [self addSubview:websiteImages];
        
        //官网网址
        _websiteAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-565*BOScreenW/750, newViewY, 500*BOScreenW/750, 40*BOScreenH/1334)];
//        _websiteAddressLabel.text = @"www.qiandaiwang.com";
        _websiteAddressLabel.textAlignment = NSTextAlignmentRight;
        _websiteAddressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _websiteAddressLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_websiteAddressLabel];
        
        //官网button
        _websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _websiteButton.frame = CGRectMake(0, newViewY-25*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        [self addSubview:_websiteButton];
        
        //线view
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, newViewY+65*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [self addSubview:lineView];
        
        //平台app图片
        CGFloat lineViewY = CGRectGetMaxY(lineView.frame) + 25*BOScreenH/1334;
        UIImageView *terraceAppImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, lineViewY, 40*BOScreenW/750, 40*BOScreenW/750)];
        terraceAppImage.image = [UIImage imageNamed:@"icon_pingtai"];
        [self addSubview:terraceAppImage];
        
        //平台app
        UILabel *terraceAppLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, lineViewY, 320*BOScreenW/750, 40*BOScreenH/1334)];
        terraceAppLabel.text = @"平台APP";
        terraceAppLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        terraceAppLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:terraceAppLabel];
        
        //平台app的箭头
        UIImageView *websiteImagess = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, lineViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        websiteImagess.image = [UIImage imageNamed:@"common_goto"];
        [self addSubview:websiteImagess];
        
        //一键下载
        UILabel *terraceAppAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-365*BOScreenW/750, lineViewY, 300*BOScreenW/750, 40*BOScreenH/1334)];
        terraceAppAddressLabel.text = @"一键下载";
        terraceAppAddressLabel.textAlignment = NSTextAlignmentRight;
        terraceAppAddressLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        terraceAppAddressLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:terraceAppAddressLabel];
        
        //平台app button
        _terraceAppButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _terraceAppButton.frame = CGRectMake(0, lineViewY-25*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        [self addSubview:_terraceAppButton];
        
        //16px分割线
        UIView *newsView = [[UIView alloc]initWithFrame:CGRectMake(0, 286*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
        newsView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:newsView];
        
        //平台信息
        CGFloat newsViewY = CGRectGetMaxY(newsView.frame) + 25*BOScreenH/1334;
        UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, newsViewY, 140*BOScreenW/750, 40*BOScreenH/1334)];
        informationLabel.text = @"平台信息";
        informationLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        informationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:informationLabel];
        
//        //平台信息的箭头
//        UIImageView *informationImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, newsViewY+5*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
//        informationImages.image = [UIImage imageNamed:@"common_goto"];
//        [self addSubview:informationImages];
//        
//        //更多信息平台
//        UILabel *informationsLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-365*BOScreenW/750, newsViewY, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        informationsLabel.text = @"更多信息平台";
//        informationsLabel.textAlignment = NSTextAlignmentRight;
//        informationsLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
//        informationsLabel.font = [UIFont systemFontOfSize:12];
//        [self addSubview:informationsLabel];
       
        //更多信息平台
        UIImageView *informationsImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-200*BOScreenW/750, newsViewY, 170*BOScreenW/750, 40*BOScreenH/1334)];
        informationsImage.image = [UIImage imageNamed:@"btn_gdptxx"];
        [self addSubview:informationsImage];
        
        //平台信息 button
        _informationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _informationButton.frame = CGRectMake(0, newsViewY-25*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334);
        [self addSubview:_informationButton];
        
        //线view
        UIView *linesView = [[UIView alloc]initWithFrame:CGRectMake(0, newsViewY+65*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        linesView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [self addSubview:linesView];
        
        
        //融资情况的view
        CGFloat linesViewY = CGRectGetMaxY(linesView.frame);
        _financingSituationView = [[UIView alloc]initWithFrame:CGRectMake(0, linesViewY, BOScreenW, 90*BOScreenH/1334)];
        _financingSituationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_financingSituationView];
        //融资情况图片
        UIImageView *financingsImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        financingsImage.image = [UIImage imageNamed:@"icon_rongzi"];
        [_financingSituationView addSubview:financingsImage];
        //融资情况
        UILabel *conditionLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 40*BOScreenH/1334)];
        conditionLabel.text = @"融资情况";
        conditionLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        conditionLabel.font = [UIFont systemFontOfSize:14];
        [_financingSituationView addSubview:conditionLabel];
        //线view
        UIView *linesssView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 88*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        linesssView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [_financingSituationView addSubview:linesssView];

    }
    return self;
}
-(void)setItem:(PlatformDetailsModel *)item
{
    _item = item;
    if (item.reg_url.length > 0)
    {
        //分隔字符串
        NSArray *newArray = [item.reg_url componentsSeparatedByString:@"|"];
        if (newArray.count > 0)
        {
            if (newArray.count == 1)
            {
                self.newsLabel.text = @"暂无最新活动";
            }else
            {
                self.newsLabel.text = newArray[0];
            }
        }else
        {
            self.newsLabel.text = @"暂无数据";
        }
    }else
    {
        self.newsLabel.text = @"暂无数据";
    }

    if (item.url > 0)
    {
        self.websiteAddressLabel.text = item.url;
    } else
    {
        self.websiteAddressLabel.text = @"暂无官网";
    }
}
@end
