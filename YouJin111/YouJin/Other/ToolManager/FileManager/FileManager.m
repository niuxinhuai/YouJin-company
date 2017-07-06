//
//  FileManager.m
//  FileManager
//
//  Created by Joe on 13-4-12.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "FileManager.h"
#import "PathHelper.h"
@implementation FileManager
static dispatch_queue_t _dispathQueue;
+ (dispatch_queue_t)defaultQueue
{
    if (!_dispathQueue) {
        _dispathQueue = dispatch_queue_create("JX.FileManager", NULL);
    }
    return _dispathQueue;
}
#pragma mark - 读取文件

+ (instancetype)shareFileManager {
    static FileManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[FileManager alloc]init];
    });
    return manager;
}

+ (NSObject *)loadDataFromPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];;
}

+ (BOOL)asyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback
{
    BOOL fileExist = [self fileExistsAtPath:path];
    dispatch_async([self defaultQueue], ^{
        NSObject *data = [self loadDataFromPath:path];
        callback(data);
    });
    return fileExist;
}

#pragma mark - 存储数据
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path
{
    if ([PathHelper createPathIfNecessary:[path stringByDeletingLastPathComponent]])
    {
        return [NSKeyedArchiver archiveRootObject:data toFile:path];
    }
    return NO;
}

+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             callback:(void(^)(BOOL succeed))callback
{
    dispatch_async([self defaultQueue], ^{
        BOOL succeed = [self saveData:data withPath:path];
        callback(succeed);
    });
}

+ (BOOL)saveData:(NSObject *)data
        withPath:(NSString *)path
        fileName:(NSString *)fileName
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    return [self saveData:data withPath:fullPath];
}

+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    [self asyncSaveData:data withPath:fullPath callback:callback];
}

#pragma mark - 删除
+ (BOOL)removeFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL succeed = [fileManager removeItemAtPath:path error:&error];
    return succeed;
}

+ (void)removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerate = [fm enumeratorAtPath:path];
	for (NSString *fileName in enumerate)
    {
		NSString *filePath = [path stringByAppendingPathComponent:fileName];
		NSDictionary *fileInfo = [fm attributesOfItemAtPath:filePath error:nil];
        if (condition(fileInfo)) {
            [fm removeItemAtPath:filePath error:nil];
        }
	}
}

+ (void)asyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    dispatch_async([self defaultQueue], ^{
        [self removeFileAtPath:path condition:condition];
    });
}

+ (BOOL)fileExistsAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}



- (float)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}


- (float) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize;
    
}

- (long long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
}

@end
