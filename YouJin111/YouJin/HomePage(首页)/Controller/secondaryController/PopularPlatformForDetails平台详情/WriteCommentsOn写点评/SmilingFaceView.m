//
//  SmilingFaceView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SmilingFaceView.h"
#import "WriteCommentsModel.h"

@interface SmilingFaceView()

@property (nonatomic, retain) NSMutableArray *titleLabels;
@property (nonatomic, retain) NSArray *titles;

@end

@implementation SmilingFaceView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _operatingArr = [NSMutableArray array];
        _riskControlArr = [NSMutableArray array];
        _serviceArr = [NSMutableArray array];
        _transparentArr = [NSMutableArray array];
        _chooseArr = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *linesView = [[UIView alloc]initWithFrame:CGRectMake(0, 339*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        linesView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self addSubview:linesView];
        
        for (int i = 0; i < self.titles.count; i ++)
        {
            UILabel *markLabel = [[UILabel alloc]init];
            markLabel.text = [self.titles objectAtIndex:i];
            markLabel.font = [UIFont systemFontOfSize:15];
            markLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
            _size=[markLabel.text sizeWithAttributes:attrs];
            [markLabel setFrame:CGRectMake(30*BOScreenW/750, 36*BOScreenH/1334+i*(28*BOScreenH/1334+52*BOScreenH/1334), _size.width, 28*BOScreenH/1334)];
            [self addSubview:markLabel];
            [self.titleLabels addObject:markLabel];
        }
        
        for (int i = 0; i < 5; i++)
        {
            //运营的笑脸
            UIButton *operatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
            operatingButton.frame  =CGRectMake(30*BOScreenW/750+_size.width+40*BOScreenW/750+i*(50*BOScreenW/750+32*BOScreenW/750), 26*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
            operatingButton.tag = i + 1;
            [operatingButton setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
            [operatingButton addTarget:self action:@selector(operatingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:operatingButton];
            [_operatingArr addObject:operatingButton];
            //风控的笑脸
            UIButton *riskControlButton = [UIButton buttonWithType:UIButtonTypeCustom];
            riskControlButton.frame  =CGRectMake(30*BOScreenW/750+_size.width+40*BOScreenW/750+i*(50*BOScreenW/750+32*BOScreenW/750), 106*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
            riskControlButton.tag = i + 1;
            [riskControlButton setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
            [riskControlButton addTarget:self action:@selector(riskControlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:riskControlButton];
            [_riskControlArr addObject:riskControlButton];
            //服务的笑脸
            UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            serviceButton.frame  =CGRectMake(30*BOScreenW/750+_size.width+40*BOScreenW/750+i*(50*BOScreenW/750+32*BOScreenW/750), 186*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
            serviceButton.tag = i + 1;
            [serviceButton setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
            [serviceButton addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:serviceButton];
            [_serviceArr addObject:serviceButton];
            //透明的笑脸
            UIButton *transparentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            transparentButton.frame  =CGRectMake(30*BOScreenW/750+_size.width+40*BOScreenW/750+i*(50*BOScreenW/750+32*BOScreenW/750), 266*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
            transparentButton.tag = i + 1;
            [transparentButton setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
            [transparentButton addTarget:self action:@selector(transparentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:transparentButton];
            [_transparentArr addObject:transparentButton];
        }
}
    return self;
}

#pragma mark - reget

- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"运营",@"风控",@"服务",@"透明"];
    }
    return _titles;
}

#pragma mark---运营笑脸点击事件处理---
- (void)operatingButtonClick:(UIButton *)sender
{
    _xiaolianone = (int)sender.tag;
    [self operatingSetCount:_xiaolianone];
}
#pragma mark---风控笑脸点击事件处理---
- (void)riskControlButtonClick:(UIButton *)sender
{
    _xiaoliantwo = (int)sender.tag;
    [self riskControlSetCount:_xiaoliantwo];
}
#pragma mark---服务笑脸点击事件处理---
- (void)serviceButtonClick:(UIButton *)sender
{
    _xiaolianthree = (int)sender.tag;
    [self serviceSetCount:_xiaolianthree];
}
#pragma mark---透明笑脸点击事件处理---
- (void)transparentButtonClick:(UIButton *)sender
{
    _xiaolianfour = (int)sender.tag;
    [self transparentSetCount:_xiaolianfour];
}
- (void)operatingSetCount:(int)count
{
    int xingxCounts = (int)_operatingArr.count;
    for (int i = 0; i < xingxCounts; i++)
    {
        UIButton *round = _operatingArr[i];
        if (i < count)
        {
            if (count < 3)
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_d"] forState:UIControlStateNormal];
            }else
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_h"] forState:UIControlStateNormal];
            }
        } else
        {
            [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
        }
    }
}
- (void)riskControlSetCount:(int)count
{
    int xingxCounts = (int)_riskControlArr.count;
    for (int i = 0; i < xingxCounts; i++)
    {
        UIButton *round = _riskControlArr[i];
        if (i < count)
        {
            if (count < 3)
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_d"] forState:UIControlStateNormal];
            }else
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_h"] forState:UIControlStateNormal];
            }
        } else
        {
            [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
        }
    }
}
- (void)serviceSetCount:(int)count
{
    int xingxCounts = (int)_serviceArr.count;
    for (int i = 0; i < xingxCounts; i++)
    {
        UIButton *round = _serviceArr[i];
        if (i < count)
        {
            if (count < 3)
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_d"] forState:UIControlStateNormal];
            }else
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_h"] forState:UIControlStateNormal];
            }
        } else
        {
            [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
        }
    }
}
- (void)transparentSetCount:(int)count
{
    int xingxCounts = (int)_transparentArr.count;
    for (int i = 0; i < xingxCounts; i++)
    {
        UIButton *round = _transparentArr[i];
        if (i < count)
        {
            if (count < 3)
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_d"] forState:UIControlStateNormal];
            }else
            {
                [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_h"] forState:UIControlStateNormal];
            }
        } else
        {
            [round setBackgroundImage:[UIImage imageNamed:@"icon_smile_nor"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark -helpMethod

- (void)updateTitles:(NSArray *)titles {
    self.titles = titles;
    if (self.titleLabels.count > 0 && self.titleLabels.count == self.titles.count) {
        for (NSInteger i = 0; i < self.titles.count; i ++) {
            UILabel *label = [self.titleLabels objectAtIndex:i];
            label.text = [self.titles objectAtIndex:i];
        }
    }
}

@end
