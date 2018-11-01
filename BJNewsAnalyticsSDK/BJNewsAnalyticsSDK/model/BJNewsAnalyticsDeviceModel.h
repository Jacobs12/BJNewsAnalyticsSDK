//
//  BJNewsAnalyticsDeviceModel.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/29.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 获取设备的信息
 */
@interface BJNewsAnalyticsDeviceModel : NSObject

/**
 平台
 */
@property (nonatomic,copy) NSString * platform;

/**
 系统版本
 */
@property (nonatomic,copy) NSString * systemVersion;

/**
 分辨率
 */
@property (nonatomic,copy) NSString * resolution;

/**
 设备名称
 */
@property (nonatomic,copy) NSString * deviceName;

/**
 识别iPad、iPod还是iPhone
 */
@property (nonatomic,copy) NSString * modelName;

/**
 UUID
 */
@property (nonatomic,copy) NSString * UUID;

/**
 静态库版本号
 */
@property (nonatomic,copy) NSString * libVersion;

- (NSDictionary *)dictionary;

@end
