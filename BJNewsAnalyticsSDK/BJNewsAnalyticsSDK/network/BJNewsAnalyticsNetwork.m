 //
//  BJNewsAnalyticsNetwork.m
//  BJNewsAnalyticsSDK
//
//  Created by wolffy on 2018/10/26.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "BJNewsAnalyticsNetwork.h"
#import "AFNetworking.h"

@interface BJNewsAnalyticsNetwork () <NSURLSessionTaskDelegate>

@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) NSURLSessionDataTask * dataTask;

@end

@implementation BJNewsAnalyticsNetwork

#pragma mark - GET

/**
 GET请求
 
 @param host 主机地址
 @param headers 请求头
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)getWithHost:(NSString *)host headers:(NSDictionary *)headers completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    [self startRequestWithMethod:FTRequestMethodGet host:host headers:headers parameters:nil completed:completed failed:failed];
}

#pragma mark - POST

/**
 POST请求
 
 @param host 主机地址
 @param headers 请求头
 @param parameters 请求体
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)postWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    [self startRequestWithMethod:FTRequestMethodPost host:host headers:headers parameters:parameters completed:completed failed:failed];
}

/**
 POST请求，带文件
 
 @param host 主机地址
 @param headers 请求头
 @param parameters 请求体
 @param files key+file value，file会被base64处理
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)postWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters files:(NSDictionary *)files completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    NSDictionary * newParameters = [self newParametersWithParameters:parameters files:files];
    [self postWithHost:host headers:headers parameters:newParameters completed:completed failed:failed];
}

#pragma mark - PUT

/**
 PUT请求，不带文件
 
 @param host 主机地址
 @param headers 请求头
 @param parameters 请求体
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)putWithHost :(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    [self startRequestWithMethod:FTRequestMethodPut host:host headers:headers parameters:parameters completed:completed failed:failed];
}

/**
 PUT请求，带文件
 
 @param host 主机地址
 @param headers 请求头
 @param parameters 请求体
 @param files key+file value，file会被base64处理
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)putWithHost :(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters files:(NSDictionary *)files completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    NSDictionary * newParameters = [self newParametersWithParameters:parameters files:files];
    [self putWithHost:host headers:headers parameters:newParameters completed:completed failed:failed];
}

#pragma mark - DELETE

/**
 DELETE请求
 
 @param host 主机地址
 @param headers 请求头
 @param completed 请求成功回调
 @param failed 请求失败回调
 */
- (void)deleteWithHost:(NSString *)host headers:(NSDictionary *)headers completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    [self deleteWithHost:host headers:headers completed:completed failed:failed];
}

#pragma mark - 添加文件
/**
 body体中添加文件
 
 @param parameters parameters description
 @param files files description
 @return return value description
 */
- (NSDictionary *)newParametersWithParameters:(NSDictionary *)parameters files:(NSDictionary *)files{
    NSMutableDictionary * newParameters = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    for (NSString * key in files.allKeys) {
        id value = files[key];
        NSData * data = nil;
        if([value isKindOfClass:[NSData class]]){
            data = value;
        }else if ([value isKindOfClass:[UIImage class]]){
            UIImage * image = (UIImage *)value;
            data = UIImageJPEGRepresentation(image, 1.0);
        }else{
            continue;
        }
        NSString * encodeString = [data base64EncodedStringWithOptions:0];
        [newParameters setValue:encodeString forKey:key];
    }
    return newParameters;
}

- (void)startRequestWithMethod:(FTRequestMethod)method host:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters completed:(BJNewsAnalyticsCompleted)completed failed:(BJNewsAnalyticsFailed)failed{
    NSString * methodString = [self descriptionForMethod:method];
    AFHTTPSessionManager * manager = self.manager;
    NSMutableURLRequest * request = [[AFJSONRequestSerializer serializer] requestWithMethod:methodString URLString:host parameters:nil error:nil];
    //    设置headers
    if(headers && [headers isKindOfClass:[NSDictionary class]]){
        for (NSString * key in headers.allKeys) {
            NSString * value = [NSString stringWithFormat:@"%@",headers[key]];
            [request setValue:value forHTTPHeaderField:key];
        }
    }
    //    设置body
    if(parameters && [parameters isKindOfClass:[NSDictionary class]]){
        NSMutableString * bodyString = [[NSMutableString alloc]init];
        for(NSInteger i=0;i<parameters.allKeys.count;i++){
            NSString * key = parameters.allKeys[i];
            NSString * value = [NSString stringWithFormat:@"%@",parameters[key]];
            if(i != 0){
                [bodyString appendString:@"&"];
            }
            [bodyString appendFormat:@"%@=%@",key,value];
        }
        NSData * body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:body];
    }
    //    创建网络任务
    self.dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = 0;
        if([response isKindOfClass:[NSHTTPURLResponse class]]){
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            statusCode = httpResponse.statusCode;
        }
        if(error){
            if(failed){
                failed(response, responseObject, statusCode);
            }
        }else{
            if(completed){
                completed(response, responseObject, statusCode);
            }
        }
//        NSLog(@"122121");
//        [self.manager invalidateSessionCancelingTasks:YES];
//        self.dataTask = nil;
//        self.manager = nil;
    }];
    //    发起请求
    [self.dataTask resume];
}

#pragma mark -

- (AFHTTPSessionManager *)manager{
    if(_manager == nil){
        _manager = [AFHTTPSessionManager manager];
//        NSURLSessionConfiguration * cfg = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"downInBackground"];
//        _manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:cfg];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return _manager;
}

/**
 获取method字符串
 
 @param method method description
 @return return value description
 */
- (NSString *)descriptionForMethod:(FTRequestMethod)method{
    NSString * MethodStr = @"GET";
    if(method == FTRequestMethodGet){
        MethodStr = @"GET";
    }else if (method == FTRequestMethodPost){
        MethodStr = @"POST";
    }else if (method == FTRequestMethodPut){
        MethodStr = @"PUT";
    }else if (method == FTRequestMethodDelete){
        MethodStr = @"DELETE";
    }
    return MethodStr;
}

@end
