//
//  BJNewsAnalyticsClick.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsClick.h"
#import "BJNewsAnalyticsNewsModel.h"
#import "BJNewsAnalyticsCache.h"

@implementation BJNewsAnalyticsClick

- (NSMutableArray *)clickedArray{
    if(_clickedArray == nil){
        _clickedArray = [[NSMutableArray alloc]init];
    }
    return _clickedArray;
}

- (NSMutableArray *)sharedArray{
    if(_sharedArray == nil){
        _sharedArray = [[NSMutableArray alloc]init];
    }
    return _sharedArray;
}

- (void)addClickNewsModel:(BJNewsAnalyticsNewsModel *)newsModel{
    BOOL isExist = NO;
    NSMutableArray * deleteArray = [[NSMutableArray alloc]init];
    for (BJNewsAnalyticsNewsModel * object in self.clickedArray) {
        if([object.newsID isEqualToString:newsModel.newsID]){
            isExist = YES;
            [deleteArray addObject:object];
        }
    }
    for (BJNewsAnalyticsNewsModel * object in deleteArray) {
        [self.clickedArray removeObject:object];
    }
    [self.clickedArray addObject:newsModel];
}

- (void)removeClickNewsModel:(BJNewsAnalyticsNewsModel *)newsModel{
    if(!newsModel){
        return;
    }
    [[BJNewsAnalyticsCache defaultManager] synchronizeClickRateWithList:@[[newsModel clickDictionary]]];
    [self.clickedArray removeObject:newsModel];
}

- (void)addSharedNewsModel:(BJNewsAnalyticsNewsModel *)newsModel{
    
}

/**
 清空缓存
 */
- (void)cleanCache{
    [[BJNewsAnalyticsCache defaultManager] cleanCahce];
}

/**
 开始统计文章点击量、每篇稿子阅读时长
 需要在viewDidDisappear方法中调用endEventWithNewsID
 
 @param newsID 文章ID
 @param title 文章标题
 */
- (void)beginEventWithNewsID:(NSString *)newsID title:(NSString *)title{
    BJNewsAnalyticsNewsModel * model = [[BJNewsAnalyticsNewsModel alloc]init];
    model.newsID = [NSString stringWithFormat:@"%@",newsID];
    model.title = [NSString stringWithFormat:@"%@",title];
    model.beginDate = [NSDate date];
    [self addClickNewsModel:model];
}

/**
 结束统计事件
 
 @param newsID 文章ID
 */
- (void)endEventWithNewsID:(NSString *)newsID{
    @try {
        BJNewsAnalyticsNewsModel * model = nil;
        for (BJNewsAnalyticsNewsModel * object in self.clickedArray) {
            if([object.newsID isEqualToString:[NSString stringWithFormat:@"%@",newsID]]){
                model = object;
            }
        }
        if(model == nil){
            NSLog(@"model == nil return");
            return;
        }
        model.endDate = [NSDate date];
        NSTimeInterval t = [model.endDate timeIntervalSinceDate:model.beginDate];
        int duration = (int)(t+1);
        model.duration = @(duration);
        [self removeClickNewsModel:model];
    } @catch (NSException *exception) {

    } @finally {
        
    }
    NSLog(@"count:%ld",self.clickedArray.count);
}

/**
 分享某一篇文章后统计事件
 
 @param newsID 文章ID
 @param title 文章标题
 */
- (void)sharedWithNewsID:(NSString *)newsID title:(NSString *)title{
    
}

@end
