//
//  ContentPartModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ContentPartType) {
    ContentPartTypeText = 1,
    ContentPartTypeImage,
};

typedef NS_ENUM(NSInteger, ImageUploadStatus) {
    ImageUploading,
    ImageUploadSuccess,
    ImageUploadFail,
};


@interface ContentPartModel : NSObject

@property (strong, nonatomic) NSNumber *type;
@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSNumber *ratio;

@property (strong, nonatomic) UIImage *cardImage;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) ImageUploadStatus status;


@end
