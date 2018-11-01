//
//  BJNewsAnalyticsNewsModel.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsNewsModel.h"

@implementation BJNewsAnalyticsNewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSDictionary *)clickDictionary{
    NSDictionary * dict = @{
                            @"news_id":self.newsID,
                            @"duration":self.duration,
                            @"title":self.title
                            };
    return dict;
}

- (NSDictionary *)sharedDictionary{
    NSDictionary * dict = @{
                            @"news_id":self.newsID,
                            @"shared_platform":self.sharedPlatform,
                            @"title":self.title
                            };
    return dict;
}

@end
