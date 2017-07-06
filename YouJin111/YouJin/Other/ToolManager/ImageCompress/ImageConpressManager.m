//
//  ImageConpressManager.m
//  renyan
//
//  Created by guoshencheng on 12/27/15.
//  Copyright © 2015 zixin. All rights reserved.
//

#import "ImageConpressManager.h"
#import "EncodeUtil.h"

@implementation ImageConpressManager

+ (NSData *)generateSmallImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:120 JPEGCompress:YES MaxSize_KB:20];
}

+ (NSData *)generateYanjiImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:280 JPEGCompress:YES MaxSize_KB:30];
}

+ (NSData *)generateMidImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:750 JPEGCompress:YES MaxSize_KB:75];
}

+ (NSData *)generateBigImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:960 JPEGCompress:YES MaxSize_KB:200];
}

+ (NSData *)generateProfileSmallImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:240 JPEGCompress:YES MaxSize_KB:15];
}

+ (NSData *)generateProfileBigImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:750 JPEGCompress:YES MaxSize_KB:60];
}

+ (NSData *)generateCoverImageDataWithImage:(UIImage *)image {
    return [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:750 JPEGCompress:YES MaxSize_KB:30];
}

/*
 压缩策略： 支持最多921600个像素点
 像素压缩：（调整像素点个数）
 当图片长宽比小于3:1 or 1:3时，图片长和宽最多为maxPixel像素；
 当图片长宽比在3:1 和 1:3之间时，会保证图片像素压缩到921600像素以内；
 JPEG压缩：（调整每个像素点的存储体积）
 默认压缩比0.99;
 如果压缩后的数据仍大于IMAGE_MAX_BYTES，那么将调整压缩比将图片压缩至IMAGE_MAX_BYTES以下。
 策略调整：
 不进行像素压缩，或者增大maxPixel，像素损失越小。
 使用无损压缩，或者增大IMAGE_MAX_BYTES.
 注意：
 jepg压缩比为0.99时，图像体积就能压缩到原来的0.40倍了。
 */

+ (NSData *)compressImage:(UIImage*)originImage PixelCompress:(BOOL)pc MaxPixel:(CGFloat)maxPixel JPEGCompress:(BOOL)jc MaxSize_KB: (CGFloat)maxKB {
    UIImage * scopedImage = nil;
    NSData * data = nil;
    //CGFloat maxbytes = maxKB * 1024;
    if (originImage == nil) {
        return nil;
    }
    if ( pc == YES ) {    //像素压缩
        // 像素数最多为maxPixel*maxPixel个
        CGFloat photoRatio = originImage.size.height / originImage.size.width;
        if ( photoRatio < 0.3333f ) {  //解决宽长图的问题
            CGFloat FinalWidth = sqrt ( maxPixel*maxPixel/photoRatio );
            scopedImage = [EncodeUtil convertImage:originImage scope:MAX(FinalWidth, maxPixel)];
        }
        else if ( photoRatio <= 3.0f ) { //解决高长图问题
            scopedImage = [EncodeUtil convertImage:originImage scope: maxPixel];
        }
        else { //一般图片
            CGFloat FinalHeight = sqrt ( maxPixel*maxPixel*photoRatio );
            scopedImage = [EncodeUtil convertImage:originImage scope:MAX(FinalHeight, maxPixel)];
        }
    }
    else {          //不进行像素压缩
        scopedImage = originImage;
    }
    if ( jc == YES ) {     //JPEG压缩
        data = UIImagePNGRepresentation(scopedImage);
        if (data.length/1024 < maxKB) {
            return data;
        }
        for (float i = 9;i > 0;i --) {
            data = UIImageJPEGRepresentation(scopedImage, i/10);
            if (data.length/1024 < maxKB)
                break;
        }
    }
    else {
        data = UIImagePNGRepresentation(scopedImage);
    }
    return data;
}

@end
