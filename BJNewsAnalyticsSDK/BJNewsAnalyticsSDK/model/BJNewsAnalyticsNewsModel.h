//
//  BJNewsAnalyticsNewsModel.h
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/30.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJNewsAnalyticsNewsModel : NSObject

@property (nonatomic,copy) NSString * newsID;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) NSDate * beginDate;
@property (nonatomic,strong) NSDate * endDate;
@property (nonatomic,strong) NSNumber * duration;
@property (nonatomic,strong) NSString * sharedPlatform;

- (NSDictionary *)clickDictionary;

- (NSDictionary *)sharedDictionary;

@end
