//
//  PublishDatasource.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentPartCell.h"

typedef void(^ConfigureContentPartCell)(ContentPartCell *cell, NSIndexPath *indexPath);


@interface PublishDatasource : NSObject<UITableViewDataSource>



@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, copy) ConfigureContentPartCell configureContentPartCell;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;


- (ContentPartModel *)createCardContentToolWithType:(ContentPartType)type image:(UIImage *)image text:(NSString *)text;
- (CGFloat)cellHeightWithContentTool:(ContentPartModel *)tool;
- (void)insertContents:(NSArray *)array atIndex:(NSInteger *)index;


@end
