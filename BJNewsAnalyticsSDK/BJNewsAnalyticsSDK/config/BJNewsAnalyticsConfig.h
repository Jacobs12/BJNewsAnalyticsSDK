//
//  BJNewsAnalyticsConfig.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#ifndef BJNewsAnalyticsConfig_h
#define BJNewsAnalyticsConfig_h

/**
 静态库版本号

 @return 静态库版本号
 */
#define BJNEWS_ANALYTICS_VERSION @"1.0.0"

/**
 定义AppKey，方便后台识别应用

 @return return value description
 */
#define BJNEWS_ANALYTICS_APPKEY @"bjnewsapp"

/**
 统计分析日志本地缓存路径

 @return 统计分析日志本地缓存路径
 */
#define BJNEWS_ANALYTICS_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/cn.com.bjnews.analyticslog/"];

#endif /* BJNewsAnalyticsConfig_h */
