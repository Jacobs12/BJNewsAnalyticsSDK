//
//  ViewController.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import "BJNewsAnalyticsDeviceModel.h"
#import "BJNewsAnalyticsConfig.h"
#import "BJNewsAnalyticsAppInfo.h"
#import "BJNewsAnalyticsManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BJNewsAnalyticsDeviceModel * model = [[BJNewsAnalyticsDeviceModel alloc]init];
    BJNewsAnalyticsAppInfo * appInfo = [[BJNewsAnalyticsAppInfo alloc]init];
//    NSLog(@"=====================%@",model.dictionary);
    NSDictionary * dict = @{@"device_info":model.dictionary,
                            @"app_info":appInfo.dictionary,
                            @"time":@"2018-10-29",
                            @"click_rate":@[
                                    @{
                                        @"news_id":@"100101",
                                        @"duration":@(12),
                                        @"title":@"这是测试标题1"
                                        },
                                    @{
                                        @"news_id":@"202022",
                                        @"duration":@(6),
                                        @"title":@"这是测试标题2"
                                        }
                                    ],
                            @"shares":@[
                                    @{
                                        @"news_id":@"100101",
                                        @"shared_platform":@"wechat_session",
                                        @"title":@"这是测试标题1"
                                        },
                                    @{
                                        @"news_id":@"100101",
                                        @"shared_platform":@"sina",
                                        @"title":@"这是测试标题1"
                                        }
                                    ],
                            @"sign":@"adafafsdfsdgsfgdf"
                            };
//    NSLog(@"%@",dict);
//    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    [[BJNewsAnalyticsManager defaultManager] beginEventWithNewsID:@"12312212" title:@"test1"];
    [[BJNewsAnalyticsManager defaultManager] beginEventWithNewsID:@"111111" title:@"test2"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[BJNewsAnalyticsManager defaultManager] endEventWithNewsID:@"12312212"];
        [[BJNewsAnalyticsManager defaultManager] beginEventWithNewsID:@"12312212" title:@"test3"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[BJNewsAnalyticsManager defaultManager] endEventWithNewsID:@"111111"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[BJNewsAnalyticsManager defaultManager] endEventWithNewsID:@"12312212"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[BJNewsAnalyticsManager defaultManager] cleanCache];
                });
            });
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
