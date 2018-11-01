//
//  BJNewsAnalyticsCache.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsCache.h"
#import "BJNewsAnalyticsConfig.h"

@implementation BJNewsAnalyticsCache

/**
 实例化缓存管理类
 
 @return 缓存管理类
 */
+ (BJNewsAnalyticsCache *)defaultManager{
    BJNewsAnalyticsCache * manager = [[BJNewsAnalyticsCache alloc]init];
    return manager;
}

#pragma mark - base
- (NSString *)basePath{
    NSString * basePath = BJNEWS_ANALYTICS_PATH;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:basePath];
    if(isExist == NO){
        [[NSFileManager defaultManager] createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return basePath;
}

- (void)initFileWithPath:(NSString *)path{
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if(isExist){
        return;
    }
    [self writeFileWithArray:nil path:path];
}

- (void)writeFileWithArray:(NSArray *)list path:(NSString *)path{
    if(list == nil){
        list = @[];
    }
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    NSDictionary * dict = @{@"list":list};
    [dict writeToFile:path atomically:YES];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSLog(@"有");
    }else{
        NSLog(@"没有");
    }
}

- (NSArray *)cacheListWithPath:(NSString *)path{
    @try {
        [self initFileWithPath:path];
        NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSArray * list = dict[@"list"];
        if(list == nil){
            list = @[];
        }
        return list;
    } @catch (NSException *exception) {
        return @[];
    } @finally {
        
    }
}

- (void)cleanCahce{
    NSString * path1 = [self clickRatePath];
    NSString * path2 = [self sharedRatePath];
    NSArray * paths = @[path1,path2];
    for(int i=0;i<paths.count;i++){
        NSString * path = paths[i];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]){
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        [self initFileWithPath:path];
    }
    NSLog(@"已清空");
    NSLog(@"%@",[self cacheListWithPath:path1]);
    NSLog(@"%@",[self cacheListWithPath:path2]);
}

#pragma mark - 点击量

- (NSString *)clickRatePath{
    NSString * filePath = [NSString stringWithFormat:@"%@clickrate.plist",[self basePath]];
    return filePath;
}

- (void)synchronizeClickRateWithList:(NSArray *)newsList{
    NSString * path = [self clickRatePath];
    NSMutableArray * array = [[NSMutableArray alloc]initWithArray:[self cacheListWithPath:path]];
    @try {
        for (NSDictionary * item in newsList) {
            BOOL isExist = NO;
            NSMutableArray * deleteArray = [[NSMutableArray alloc]init];
            for (NSDictionary * oldItem in array) {
                if([item[@"news_id"] isEqualToString:oldItem[@"news_id"]]){
                    if([item[@"duration"] integerValue] > [oldItem[@"duration"] integerValue]){
                        [deleteArray addObject:oldItem];
                    }else{
                        isExist = YES;
                    }
                }
            }
            for (NSDictionary * item in deleteArray) {
                [array removeObject:item];
            }
            if(isExist){
                continue;
            }else{
                [array addObject:item];
            }
        }
        [self writeFileWithArray:array path:path];
        NSLog(@"同步本地:%@",[self cacheListWithPath:path]);
    } @catch (NSException *exception) {

    } @finally {
        
    }
}

- (void)synchronizeSharedRateWithList:(NSArray *)newsList{
    
}

#pragma mark - 分享量

- (NSString *)sharedRatePath{
    NSString * filePath = [NSString stringWithFormat:@"%@sharedrate.plist",[self basePath]];
    return filePath;
}

@end
