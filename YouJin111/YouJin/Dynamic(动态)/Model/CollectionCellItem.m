//
//  CollectionCellItem.m
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import "CollectionCellItem.h"

@implementation CollectionCellItem

- (instancetype)initWithPic:(NSString *)picName title:(NSString *)title height:(float)height width:(float)width {
    self = [super init];
    if (self) {
        self.picName = picName;
        self.title = title;
        self.cellHeight = height;
        self.cellWidth = width;
    }
    return self;
}

@end
