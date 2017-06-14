//
//  TestSingle.m
//  Construct
//
//  Created by lisa on 2017/6/11.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "TestSingle.h"

@implementation TestSingle

/**
 单例 是在整个程序的生命周期中 只执行一次  执行完之后 如果你不去销毁  它会一直存在内存中
 
 一般做一些 全局的数据存储  活着一些变量 及代码控制
 
 */
+ (instancetype)instance
{
    static dispatch_once_t onceToken;
    static TestSingle *ins = nil;
    dispatch_once(&onceToken, ^{
        
        NSLog(@"init the TestSingle ");
        ins = [[TestSingle alloc]init];
    });
    return ins;
}
@end
