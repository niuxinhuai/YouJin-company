//
//  PublishTableHeaderView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PublishTableHeaderViewDelegate;

@interface PublishTableHeaderView : UIView
@property (weak, nonatomic) IBOutlet UITextField *plateTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;


@property (nonatomic, assign) id<PublishTableHeaderViewDelegate> delegate;

+ (instancetype)create;

@end



@protocol PublishTableHeaderViewDelegate <NSObject>

@optional

- (void)publishTableHeaderViewSelectPlate:(PublishTableHeaderView *)view;

@end
