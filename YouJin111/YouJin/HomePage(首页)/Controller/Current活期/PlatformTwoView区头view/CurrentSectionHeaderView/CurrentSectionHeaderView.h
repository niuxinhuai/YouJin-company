//
//  CurrentSectionHeaderView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTitleModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL isNeedImage;

@end

typedef enum{
    kEachGoldCurrent = 1,
    kMoneyFund
}SectionHeaderType;

@interface CurrentSectionHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fouthButton;

@property (nonatomic, assign) SectionHeaderType type;

+ (instancetype)create;

- (void)updateSectionHeaderType:(SectionHeaderType)type;

@end
