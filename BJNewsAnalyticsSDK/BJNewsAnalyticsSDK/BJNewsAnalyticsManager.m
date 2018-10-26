//
//  BJNewsAnalyticsManager.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsManager.h"
#import "BJNewsAnalyticsNetwork.h"

static BJNewsAnalyticsManager * analyticsManager = nil;

@interface BJNewsAnalyticsManager ()

@property (nonatomic,assign) BOOL isUploading;

@end

@implementation BJNewsAnalyticsManager

+ (void)init{
    [BJNewsAnalyticsManager defaultManager];
    [[BJNewsAnalyticsManager defaultManager] upLoadDataCompleted:^{
        
    } failed:^{
        
    }];
}

/**
 统计分析管理类
 
 @return return value description
 */
+ (BJNewsAnalyticsManager *)defaultManager{
    if(analyticsManager == nil){
        analyticsManager = [[BJNewsAnalyticsManager alloc]init];
        [analyticsManager initNoticationCenter];
    }
    return analyticsManager;
}

/**
 监听App动作
 */
- (void)initNoticationCenter{
    self.isUploading = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analyticsApplicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analyticsApplicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark - App 动作

/**
 App进入后台运行
 */
- (void)analyticsApplicationDidEnterBackground{
    NSLog(@"App进入后台");
    [self comeToBackgroundMode];
    [self upLoadDataCompleted:^{
        
    } failed:^{
        
    }];
}

/**
 App恢复前台运行
 */
- (void)analyticsApplicationWillEnterForeground{
    NSLog(@"App恢复运行");
}

-(void)comeToBackgroundMode{
    //初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前app在后台有任务处理，需要时间
    UIApplication*  app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:self.bgTask];
        self.bgTask = UIBackgroundTaskInvalid;
    }];
}

#pragma mark - 上传数据

/**
 上传数据，其中只有一个请求在进行，不会重复上传

 @param completed 上传成功回调
 @param failed 上传失败回调
 */
- (void)upLoadDataCompleted:(void (^) (void))completed failed:(void (^) (void))failed{
    NSLog(@"log准备上传");
    if(self.isUploading == YES){
        return;
    }
    self.isUploading = YES;
#warning 测试
    BJNewsAnalyticsNetwork * manager = [[BJNewsAnalyticsNetwork alloc]init];
    [manager postWithHost:@"https://www.baidu.com" headers:nil parameters:nil completed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData, NSInteger statusCode) {
        NSLog(@"成功");
        self.isUploading = NO;
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData, NSInteger statusCode) {
        NSLog(@"失败");
        self.isUploading = NO;
    }];
   
}

@end
