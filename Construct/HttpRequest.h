//
//  HttpRequest.h
//  Construct
//
//  Created by lisa on 2017/4/20.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义几个请求相关的block


/**
 网络请求成功block

 @param responseObject 服务器响应数据
 */
typedef void (^HttpRequestSuccessBlock)(id responseObject);

typedef void (^HttpRequestFailureBlock)(NSOperation *operatio, NSError *error);
//网络请求成功，但是业务逻辑返回失败信息
typedef void (^HttpRequestBusinessFailureBlock)(id responseObject);

@interface HttpRequest : NSObject
/**
 *  @brief  发起请求的参数键值对
 */
//@property (strong, nonatomic) NSMutableDictionary *parameters;

/**
 @brief  基本的 Get请求方法
 */
+ (void)getWithManager:(id)requestOperationManager
            parameters:(NSMutableDictionary *)parameters
               success:(HttpRequestSuccessBlock)success
               failure:(HttpRequestFailureBlock)failure
       businessFailure:(HttpRequestBusinessFailureBlock)failure;

/**
 @brief  基本的 Post请求方法
 */
- (void)postWithManager:(id)requestOperationManager
                        success:(HttpRequestSuccessBlock)success
                        failure:(HttpRequestFailureBlock)failure
                businessFailure:(HttpRequestBusinessFailureBlock)businessFailure;



@end
