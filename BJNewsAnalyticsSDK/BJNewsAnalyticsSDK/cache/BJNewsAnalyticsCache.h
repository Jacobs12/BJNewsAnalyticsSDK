//
//  BJNewsAnalyticsCache.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJNewsAnalyticsCache : NSObject

/**
 实例化缓存管理类
 
 @return 缓存管理类
 */
+ (BJNewsAnalyticsCache *)defaultManager;

- (void)cleanCahce;

- (void)synchronizeClickRateWithList:(NSArray *)newsList;

- (void)synchronizeSharedRateWithList:(NSArray *)newsList;

@end
