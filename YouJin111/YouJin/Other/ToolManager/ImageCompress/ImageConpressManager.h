//
//  ImageConpressManager.h
//  renyan
//
//  Created by guoshencheng on 12/27/15.
//  Copyright © 2015 zixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageConpressManager : NSObject

+ (NSData *)generateProfileSmallImageDataWithImage:(UIImage *)image;
+ (NSData *)generateYanjiImageDataWithImage:(UIImage *)image;
+ (NSData *)generateMidImageDataWithImage:(UIImage *)image;
+ (NSData *)generateProfileBigImageDataWithImage:(UIImage *)image;
+ (NSData *)generateSmallImageDataWithImage:(UIImage *)image;
+ (NSData *)generateBigImageDataWithImage:(UIImage *)image;
+ (NSData *)generateCoverImageDataWithImage:(UIImage *)image;
+ (NSData *)compressImage:(UIImage*)originImage PixelCompress:(BOOL)pc MaxPixel:(CGFloat)maxPixel JPEGCompress:(BOOL)jc MaxSize_KB: (CGFloat)maxKB;

@end
