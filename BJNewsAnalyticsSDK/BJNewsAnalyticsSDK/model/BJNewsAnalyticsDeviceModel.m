
//
//  BJNewsAnalyticsDeviceModel.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/29.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsDeviceModel.h"
#import <sys/utsname.h>
#import "BJNewsAnalyticsConfig.h"

@implementation BJNewsAnalyticsDeviceModel

- (NSString *)platform{
    return @"iOS";
}

- (NSString *)systemVersion{
    NSString * systemVersion = [UIDevice currentDevice].systemVersion;
    return systemVersion;
}

- (NSString *)resolution{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSString * resolution = [NSString stringWithFormat:@"%.f*%.f",rect.size.width * scale,rect.size.height * scale];
    return resolution;
}

- (NSString *)deviceName{
    struct utsname systemInfo;
    uname(&systemInfo);
    return  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *)modelName{
    NSString * modelName = [NSString stringWithFormat:@"%@",[UIDevice currentDevice].model];
    return modelName;
}

- (NSString *)UUID{
    NSString * key = @"bjnews_analytics_uuid";
    NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(uuid && uuid.length > 1){
        return uuid;
    }
    uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:key];
    return uuid;
}

- (NSString *)libVersion{
    NSString * libVersion = BJNEWS_ANALYTICS_VERSION;
    return libVersion;
}

#pragma mark - 整合到一起
- (NSDictionary *)dictionary{
    NSDictionary * dict = @{
                            @"platform":self.platform,
                            @"system_version":self.systemVersion,
                            @"resolution":self.resolution,
                            @"device_name":self.deviceName,
                            @"model_name":self.modelName,
                            @"uuid":self.UUID
                            };
    return dict;
}

@end
