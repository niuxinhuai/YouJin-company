//
//  FileManager.h
//  FileManager
//
//  Created by Joe on 13-4-12.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
{
    
}


+ (instancetype)shareFileManager;
+ (NSObject *)loadDataFromPath:(NSString *)path ;
+ (BOOL)asyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback;
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path;
+ (void)asyncSaveData:(NSObject *)data withPath:(NSString *)path callback:(void(^)(BOOL succeed))callback;
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path fileName:(NSString *)fileName;
+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback;
+ (BOOL)removeFileAtPath:(NSString *)path;
+ (void)removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
+ (void)asyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
+ (BOOL)fileExistsAtPath:(NSString *)path;

- (float)readCacheSize;
- (void)clearFile;
@end
