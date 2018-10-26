//
//  BJNewsAnalyticsManager.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJNewsAnalyticsManager : NSObject

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;

/**
 依赖库：AFNetworking 版本：3.2.1
 初始化统计分析管理类，在APPDelete中使用，使用方法：
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [BJNewsAnalyticsManager init];
 }
 如果报[] nw_parameters_set_source_application Failed to convert from PID (0) to UUID. This could lead to wrong data usage accounting.
 请前往 系统偏好设置-->网络-->高级-->代理，然后关闭自动代理
 */
+ (void)init;

/**
 统计分析管理类

 @return return value description
 */
+ (BJNewsAnalyticsManager *)defaultManager;

/**
 上传数据，其中只有一个请求在进行，不会重复上传
 
 @param completed 上传成功回调
 @param failed 上传失败回调
 */
- (void)upLoadDataCompleted:(void (^) (void))completed failed:(void (^) (void))failed;

@end
