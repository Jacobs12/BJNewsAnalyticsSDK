//
//  BJNewsAnalyticsAppInfo.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJNewsAnalyticsAppInfo : NSObject

/**
 应用版本号
 */
@property (nonatomic,copy) NSString * appVersion;

/**
 应用名称
 */
@property (nonatomic,copy) NSString * appName;

/**
 应用识别标识
 */
@property (nonatomic,copy) NSString * appKey;

/**
 静态库版本号
 */
@property (nonatomic,copy) NSString * libVersion;

- (NSDictionary *)dictionary;

@end
