//
//  CustomOperation.m
//  Construct
//
//  Created by lisa on 2017/6/10.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()

@property (nonatomic, copy) NSString *operName;

@property (nonatomic, assign) BOOL over; //设一个标志位 over

@end
@implementation CustomOperation

- (instancetype)initWithName:(NSString *)operName
{
    if (self = [super init]) {
        self.operName = operName;
    }
    return self;
}

/**
 我们想要执行一个 并发的 异步的操作 我们要重写 main方法
 */
- (void)main{  //这里面存放耗时操作  有时是网络请求等 异步操作
   
//    for (int i = 0; i<3; i++) {
//       
//        NSLog(@"%@    %d",self.operName,i);
//        [NSThread sleepForTimeInterval:1];  //让线程休眠 模拟耗时任务
//    }
    
  //下面模拟一下 异步操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
       [NSThread sleepForTimeInterval:1];
        if (self.cancelled) {
            return ;
        }
        
        NSLog(@"%@",self.operName);  //异步操作 这句代码先执行 很快执行完毕
        
        self.over = YES;
    });
    
    
    //runLoop循环监听状态
    //while 会不停的循环 除非你手动的设置状态位 over  或者 cancle
    while (!self.over && !self.cancelled) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    
}
















@end
