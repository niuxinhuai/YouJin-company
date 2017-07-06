//
//  CustomButton.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kCustomButtonNone,
    kCustomButtonImageToText,
    kCustomButtonTextToImage
}CustomButtonType;

@interface CustomButton : UIButton


@property (nonatomic, assign) CustomButtonType type;


@end
