//
//  ContentPartCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentPartModel.h"

@protocol ContentPartCellDelegate;

@interface ContentPartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIView *textContainer;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicateView;
@property (weak, nonatomic) IBOutlet UIButton *reuploadButton;



@property (nonatomic, retain) ContentPartModel *model;
@property (nonatomic, assign) id<ContentPartCellDelegate> delegate;


- (void)updateContentModel:(ContentPartModel *)model;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) ContentPartType type;



@end


@protocol ContentPartCellDelegate <NSObject>

@optional
- (void)cell:(ContentPartCell *)cell textViewBeginEditing:(UITextView *)textView;
- (void)cell:(ContentPartCell *)cell textViewChange:(UITextView *)textView;
- (void)cell:(ContentPartCell *)cell textViewEndEditing:(UITextView *)textView;
- (void)cell:(ContentPartCell *)cell textViewReturnTicked:(UITextView *)textView;
- (void)cellDeleteImageEnd:(ContentPartCell *)cell;
- (void)cellReuploadImage:(ContentPartCell *)cell;

@end

