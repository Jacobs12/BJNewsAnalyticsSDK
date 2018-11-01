//
//  BJNewsAnalyticsClick.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJNewsAnalyticsClick : NSObject

@property (nonatomic,strong) NSMutableArray * clickedArray;
@property (nonatomic,strong) NSMutableArray * sharedArray;

/**
 清空缓存
 */
- (void)cleanCache;

/**
 开始统计文章点击量、每篇稿子阅读时长
 需要在viewDidDisappear方法中调用endEventWithNewsID

 @param newsID 文章ID
 @param title 文章标题
 */
- (void)beginEventWithNewsID:(NSString *)newsID title:(NSString *)title;

/**
 结束统计事件

 @param newsID 文章ID
 */
- (void)endEventWithNewsID:(NSString *)newsID;

/**
 分享某一篇文章后统计事件

 @param newsID 文章ID
 @param title 文章标题
 */
- (void)sharedWithNewsID:(NSString *)newsID title:(NSString *)title;

@end
