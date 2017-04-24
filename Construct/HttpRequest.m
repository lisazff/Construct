//
//  HttpRequest.m
//  Construct
//
//  Created by lisa on 2017/4/20.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
@implementation HttpRequest

+ (void)getWithManager:(id)requestOperationManager
            parameters:(NSMutableDictionary *)parameters
               success:(HttpRequestSuccessBlock)success
               failure:(HttpRequestFailureBlock)failure
       businessFailure:(HttpRequestBusinessFailureBlock)businessFailure
{
    //安全celue  https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES;
    
// AFNetworking 3.0 开始 用AFHTTPSessionManager 替换了  AFHTTPRequestOperationManager
    if (requestOperationManager == nil) { //请求操作管理者 不存在时   就初始化一个
        requestOperationManager = [AFHTTPSessionManager manager];
    }
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
        manage.requestSerializer = [AFJSONRequestSerializer serializer]; //请求设置成json格式
        manage.responseSerializer = [AFHTTPResponseSerializer serializer]; //响应数据  是 二进制 格式
        manage.requestSerializer.timeoutInterval = 10.0f;  //请求 时间超时间隔 10秒
        
        // 下面 get 方法是 AFHTTPSessionManager  框架里面  封装好的
        [manage GET:HttpServerNormalUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"网络请求的URL为:  %@",task.currentRequest.URL);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败");
        }];
   
}
@end
