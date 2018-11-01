//
//  BJNewsAnalyticsAppInfo.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsAppInfo.h"
#import "BJNewsAnalyticsConfig.h"

@implementation BJNewsAnalyticsAppInfo

- (NSString *)appVersion{
    @try {
        NSString * appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if(!appVersion){
            return @"";
        }
        return appVersion;
    } @catch (NSException *exception) {
        return @"";
    } @finally {
        
    }
}

- (NSString *)appName{
    @try {
        NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        if(!appName){
            appName = @"";
        }
        return appName;
    } @catch (NSException *exception) {
        return @"";
    } @finally {
        
    }
}

- (NSString *)appKey{
    NSString * appKey = BJNEWS_ANALYTICS_APPKEY;
    return appKey;
}

- (NSString *)libVersion{
    NSString * libVersion = BJNEWS_ANALYTICS_VERSION;
    return libVersion;
}

- (NSDictionary *)dictionary{
    NSDictionary * dict = @{
                            @"app_version":self.appVersion,
                            @"app_name":self.appName,
                            @"app_key":self.appKey,
                            @"lib_version":self.libVersion
                            };
    return dict;
}

@end
