//
//  ContentPartCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ContentPartCell.h"

@interface ContentPartCell ()<UITextViewDelegate>

@end

@implementation ContentPartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.maskView.hidden = YES;
}


#pragma mark - configureCell

- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textView.delegate = self;
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    NSMutableParagraphStyle *paraphStyle = [[NSMutableParagraphStyle alloc]init];
    paraphStyle.lineSpacing = 1;
    UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *attributDictionary = @{
                                         NSFontAttributeName:font,
                                         NSParagraphStyleAttributeName:paraphStyle,
                                         NSForegroundColorAttributeName:[UIColor greenColor],
                                         };
    self.textView.attributedText = [[NSAttributedString alloc]initWithString:@" " attributes:attributDictionary];
    if (![self.textView.text isEqualToString:@""]) {
        self.textView.attributedText = [[NSAttributedString alloc]initWithString:self.textView.text attributes:attributDictionary];
    }
    else {
        self.textView.attributedText = [[NSAttributedString alloc]initWithString:@" " attributes:attributDictionary];
    }
    self.textView.userInteractionEnabled = YES;
}

#pragma mark - reget && reset

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    //    if ([self.delegate respondsToSelector:@selector(cell:textViewBeginEditing:)]) {
    //        [self.delegate cell:self textViewBeginEditing:textView];
    //    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(cell:textViewBeginEditing:)]) {
        [self.delegate cell:self textViewBeginEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    [textView scrollRangeToVisible:NSMakeRange(0, 1)];
    NSLog(@"2");
    if ([self.delegate respondsToSelector:@selector(cell:textViewChange:)]) {
        [self.delegate cell:self textViewChange:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(cell:textViewEndEditing:)]) {
        [self.delegate cell:self textViewEndEditing:textView];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"1");
    return YES;
//    if ([text isEqualToString:@"\n"] && [self.delegate respondsToSelector:@selector(cell:textViewReturnTicked:)]) {
//        [self.delegate cell:self textViewReturnTicked:textView];
//        return NO;
//    }
//    return YES;
}

- (void)textViewDidDeleteBackward:(UITextView *)textView {
    
}

#pragma mark - actionMethod

- (IBAction)deleteImageAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cellDeleteImageEnd:)]) {
        [self.delegate cellDeleteImageEnd:self];
    }
}
- (IBAction)reuploadAction:(UIButton *)sender {
    self.model.status = ImageUploading;
    [self handleWhenImageUploading];
    if ([self.delegate respondsToSelector:@selector(cellReuploadImage:)]) {
        [self.delegate cellReuploadImage:self];
    }
}


#pragma mark - publicMethod

- (void)updateContentModel:(ContentPartModel *)model {
    if (!model) {
        self.imageContainer.hidden = YES;
        self.textContainer.hidden = YES;
        self.userInteractionEnabled = NO;
        return;
    }
    self.userInteractionEnabled = YES;
    self.model = model;
    self.type = [model.type intValue];
    [self subViewHidden];
    switch (self.type) {
        case ContentPartTypeText:
            [self handleContentToolTextWithTool:model];
            break;
        case ContentPartTypeImage:
            [self handleContentToolImageWithTool:model];
            break;
        default:
            break;
    }
}

#pragma mark - helpMethod

- (void)subViewHidden {
    self.imageContainer.hidden = self.type != ContentPartTypeImage;
    self.textContainer.hidden = self.type != ContentPartTypeText;
}


- (void)handleContentToolTextWithTool:(ContentPartModel *)tool {
    self.textView.text = tool.word;
}

- (void)handleContentToolImageWithTool:(ContentPartModel *)tool {
    self.contentImageView.image = tool.cardImage;
    switch (tool.status) {
        case ImageUploading:
            [self handleWhenImageUploading];
            break;
        case ImageUploadSuccess:
            [self handleWhenImageSuccess];
            break;
        case ImageUploadFail:
            [self handleWhenImageFail];
            break;
        default:
            break;
    }
}


- (void)handleWhenImageUploading {
    self.maskView.hidden = NO;
    [self indicateViewHidden:NO];
}

- (void)handleWhenImageSuccess {
    self.maskView.hidden = YES;
}

- (void)handleWhenImageFail {
    self.maskView.hidden = NO;
    [self indicateViewHidden:YES];
}

- (void)indicateViewHidden:(BOOL)hidden {
    self.indicateView.hidden = hidden;
    hidden ? [self.indicateView stopAnimating] : [self.indicateView startAnimating];
    self.reuploadButton.hidden = !hidden;
}

@end
