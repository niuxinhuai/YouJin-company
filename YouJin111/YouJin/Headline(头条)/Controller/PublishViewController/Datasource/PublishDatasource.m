//
//  PublishDatasource.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishDatasource.h"
#import "NSString+Utilities.h"
static const int minHeight = 32;

@implementation PublishDatasource












#pragma mark - publicMethod

- (ContentPartModel *)createCardContentToolWithType:(ContentPartType)type image:(UIImage *)image text:(NSString *)text {
    ContentPartModel *tool = [[ContentPartModel alloc]init];
    tool.type = @(type);
    if (type == ContentPartTypeImage) {
        if (image) {
            tool.cardImage = image;
            tool.ratio = @(image.size.height / image.size.width);
        }
    }else {
        tool.word = text;
    }
    tool.cellHeight = [self cellHeightWithContentTool:tool];
    return tool;
}

- (CGFloat)cellHeightWithContentTool:(ContentPartModel *)tool {
    CGFloat cellheight = minHeight;
    switch ([tool.type intValue]) {
        case ContentPartTypeText: {
            cellheight = [tool.word getSizeFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake([UIScreen screenWidth] - 32, MAXFLOAT) andlineSpacing:1].height + 20;
        }
            break;
        case ContentPartTypeImage: {
            cellheight = ([UIScreen screenWidth] - 32) * [tool.ratio floatValue] + 16;
        }
            break;
        default:
            break;
    }
    tool.cellHeight = cellheight > minHeight ? cellheight : minHeight;
    return cellheight > minHeight ? cellheight : minHeight;
}

- (void)insertContents:(NSArray *)array atIndex:(NSInteger *)index {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSInteger i = 0; i < array.count; i ++) {
        [indexSet addIndex:(NSUInteger)(index + i)];
    }
    [self.contents insertObjects:array atIndexes:indexSet];
}

#pragma mark - reget

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentPartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContentPartCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.indexPath = indexPath;
    cell.textView.userInteractionEnabled = YES;
    if (indexPath.row >= self.contents.count) {
        [cell updateContentModel:nil];
    }else {
        [cell updateContentModel:self.contents[indexPath.row]];
    }
    if (self.configureContentPartCell) {
        self.configureContentPartCell(cell, indexPath);
    }
    return cell;
}



@end
