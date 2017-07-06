//
//  PublishViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController+Delegate.h"
#import "PublishViewController+Configuration.h"
#import "PublishViewController+LogicalFlow.h"

@implementation PublishViewController (Delegate)

#pragma mark - <UITableViewDelegate>


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentPartModel *tool = self.datasource.contents[indexPath.row];
    return tool.cellHeight > 0 ? tool.cellHeight : [self.datasource cellHeightWithContentTool:tool];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)complishHandleImage:(UIImage *)image {
    [self addContensToDatasourceWithImage:image text:@"" cardType:ContentPartTypeImage];
}

- (void)imageEditComplishWithHandleImage:(UIImage *)image {
    [self complishHandleImage:image];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentPartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.type != ContentPartTypeText) {
        self.datasource.selectedIndexPath = indexPath;
        [self.view endEditing:YES];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

#pragma mark - <CardContentCellDelegate>

- (void)cell:(ContentPartCell *)cell textViewBeginEditing:(UITextView *)textView {
    self.datasource.selectedIndexPath = cell.indexPath;
    [self scrollToCursorForTextView:cell.textView];
}
- (void)cell:(ContentPartCell *)cell textViewChange:(UITextView *)textView {
    if (cell.type == ContentPartTypeText) {
        ContentPartModel *tool = self.datasource.contents[cell.indexPath.row];
        tool.word = textView.text;
        CGRect textFrame= [self contentSizeRectForTextView:textView];
        tool.cellHeight = textFrame.size.height > tool.cellHeight ? textFrame.size.height + 20 : tool.cellHeight;
        tool.cellHeight = textFrame.size.height + 20;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [cell layoutIfNeeded];
        [self scrollToCursorForTextView:textView];
    }
}

- (CGRect)contentSizeRectForTextView:(UITextView *)textView
{
    [textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
    [textView layoutIfNeeded];
    CGRect textBounds = [textView.layoutManager usedRectForTextContainer:textView.textContainer];
    CGFloat width =  (CGFloat)ceil(textBounds.size.width + textView.textContainerInset.left + textView.textContainerInset.right);
    CGFloat height = (CGFloat)ceil(textBounds.size.height + textView.textContainerInset.top + textView.textContainerInset.bottom);
    NSLog(@"textheight = %f",height);
    return CGRectMake(0, 0, width, height);
}

- (void)cell:(ContentPartCell *)cell textViewEndEditing:(UITextView *)textView {
    
}

- (void)cell:(ContentPartCell *)cell textViewReturnTicked:(UITextView *)textView {
    if (textView.text.length <= 0) {
        return;
    }
}

- (void)cellDeleteImageEnd:(ContentPartCell *)cell {
    if (cell.indexPath.row > 0 && cell.indexPath.row < self.datasource.contents.count) {
        [self.datasource.contents removeObjectAtIndex:cell.indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        CGFloat index = self.datasource.selectedIndexPath.row > 0 ? cell.indexPath.row - 1 : 0;
        self.datasource.selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    }
}

- (void)cellReuploadImage:(ContentPartCell *)cell {
    [self uploadImageContent:cell.model];
}

#pragma mark - <PublishTableHeaderViewDelegate>

- (void)publishTableHeaderViewSelectPlate:(PublishTableHeaderView *)view {
    [self.view endEditing:YES];
    [self platePickviewShow:YES];
}

#pragma mark - <UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  self.plates.count;
}

#pragma mark - <UIPickerViewDelegate>

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)componen {
    return self.plates[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.headerView.plateTextField.text = self.plates[row];
  //  [self platePickviewShow:NO];
}


#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self addContensToDatasourceWithImage:image text:@"" cardType:ContentPartTypeImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - helpMethod


- (void)addContensToDatasourceWithImage:(UIImage *)image text:(NSString *)content cardType:(ContentPartType)type {
    if (self.datasource.selectedIndexPath.row >= self.datasource.contents.count) {
        self.datasource.selectedIndexPath = [NSIndexPath indexPathForRow:self.datasource.contents.count - 1 inSection:0];
    }
    NSMutableArray *indexPathArray = [NSMutableArray array];
    
    if (self.datasource.selectedIndexPath.row == self.datasource.contents.count - 1) {
        ContentPartModel *tool = [self.datasource createCardContentToolWithType:type image:image text:content];
        [self.datasource.contents addObject:tool];
        [self uploadImageContent:tool];
        ContentPartModel *secTool = [self.datasource createCardContentToolWithType:ContentPartTypeText image:nil text:@""];
        [self.datasource.contents addObject:secTool];
        [indexPathArray addObject:[NSIndexPath indexPathForRow:self.datasource.contents.count - 2 inSection:0]];
        [indexPathArray addObject:[NSIndexPath indexPathForRow:self.datasource.contents.count - 1 inSection:0]];
        self.datasource.selectedIndexPath = [NSIndexPath indexPathForRow:self.datasource.contents.count - 1 inSection:0];
    }else {
        ContentPartModel *tool = [self.datasource createCardContentToolWithType:type image:image text:content];
        [self.datasource.contents insertObject:tool atIndex:self.datasource.selectedIndexPath.row + 1];
        [self uploadImageContent:tool];
        [indexPathArray addObject:[NSIndexPath indexPathForRow:self.datasource.selectedIndexPath.row + 1 inSection:0]];
        self.datasource.selectedIndexPath = [NSIndexPath indexPathForRow:self.datasource.selectedIndexPath.row + 1 inSection:0];
    }
    NSInteger updateNumberOfRows = [self.tableView numberOfRowsInSection:0] + indexPathArray.count;
    if (self.datasource.contents.count >= updateNumberOfRows) {
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationBottom];
    }
}


- (void)scrollToCursorForTextView: (UITextView*)textView {
    
    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    cursorRect = [self.tableView convertRect:cursorRect fromView:textView];
    if (![self rectVisible:cursorRect]) {
        cursorRect.size.height += 8;
        [self.tableView scrollRectToVisible:cursorRect animated:YES];
    }
}

- (void)scrollToEndForCell:(ContentPartCell *)cell {
    CGRect cursorRect = [cell.textView caretRectForPosition:cell.textView.selectedTextRange.start];
    cursorRect = [self.tableView convertRect:cursorRect fromView:cell.textView];
    if (![self rectVisible:cursorRect]) {
        [self.tableView scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (BOOL)rectVisible: (CGRect)rect {
    CGRect visibleRect;
    visibleRect.origin = self.tableView.contentOffset;
    visibleRect.origin.y += self.tableView.contentInset.top;
    visibleRect.size = self.tableView.bounds.size;
    visibleRect.size.height -= self.tableView.contentInset.top + self.tableView.contentInset.bottom;
    return CGRectContainsRect(visibleRect, rect);
}


- (void)handleCellTextViewUserEnable:(NSIndexPath *)indexPath {
    for (ContentPartCell *cell in self.tableView.visibleCells) {
        cell.textView.userInteractionEnabled = NO;
    }
    if ([self.tableView cellForRowAtIndexPath:indexPath]) {
        ContentPartCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.type == ContentPartTypeText) {
            cell.textView.userInteractionEnabled = YES;
        }
    }
}


@end
