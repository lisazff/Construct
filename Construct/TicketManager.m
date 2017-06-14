//
//  TicketManager.m
//  Construct
//
//  Created by lisa on 2017/6/11.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "TicketManager.h"
#define Total 50
@interface TicketManager ()

@property int tickets;  //剩余票数
@property int saleCount; //卖出票数

//下面两个线程 模拟两个买票终端
@property (nonatomic, strong) NSThread *threadBJ;
@property (nonatomic, strong) NSThread *threadSH;

@property (nonatomic, strong) NSCondition *ticketCondition;

@end
@implementation TicketManager

- (instancetype)init{
    if (self = [super init]) {
      
        self.ticketCondition = [[NSCondition alloc]init];
        self.tickets = Total;
        self.threadBJ = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
        [self.threadBJ setName:@"threadBJ"];
        self.threadSH = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
        [self.threadSH setName:@"threadSH"];
    }
    return self;
}

- (void)run{
    while (true) {
    
//        @synchronized (self) {
        
        [self.ticketCondition lock];
            // tickets > 0  说明 还有票可以卖
            if (self.tickets > 0 ) {
                
                [NSThread sleepForTimeInterval:0.5];
                self.tickets --;
                self.saleCount = Total - self.tickets;
                
                NSLog(@"%@   当前余票： %d  卖出票数：%d",[NSThread currentThread].name,self.tickets,self.saleCount);
            }

//        }
        
        [self.ticketCondition unlock];
    }
}

- (void)startToSale
{
    [self.threadBJ start];
    [self.threadSH start];
}









@end
