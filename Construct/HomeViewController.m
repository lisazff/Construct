//
//  HomeViewController.m
//  Construct
//
//  Created by lisa on 2017/4/12.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "TaskListModel.h"
#import "TaskDetailCell.h"

#import "HWAlertView.h"  //自定义alertView
#import "ShowAnimationView.h"  //自定义加蒙版view

#import "StockData.h"

#import "HomeListViewController.h"

#import "CustomOperation.h"
#import <pthread.h>

#import "TicketManager.h"
#import "TestSingle.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HWAlertViewDelegate>
{
    StockData *stockForKVO;
    UILabel *myLabel;
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HWAlertView *alertView;

@property (nonatomic, strong) ShowAnimationView *showView;

@property (nonatomic, strong) NSOperationQueue *operQueue;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
    
//    int arrayName[4] = {10,20,30,40};
//    int *p = (int *)(&arrayName +1);
//    NSLog(@"%d",*(p-1));
    
    
    
    
//    [self setTitleName:@"主页" andFont:18.f];
    
//    [self loadData];
    
//    [self loadLocalRequest];  //加载本地服务器
    
//    self.dataSource = [[NSMutableArray alloc]init];
    
//    [self loadTaskList];
    
  //  [self initUI];
    
//    [self KVOtest];
    
//    UIButton * b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    b.frame = CGRectMake(0, 350, 100, 30);
//    b.backgroundColor = [UIColor yellowColor];
//    [b addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:b];
    
    
//    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i<3; i++) {
//            NSLog(@"invocation  %d",i);
//            [NSThread sleepForTimeInterval:1];
//        }
//        
//    }];
    
    
//    [self NSTreadTest];
    
//    [self saleTicket];
    
//    [self GCDTest];
    
//    [self dispatchGroup];

//    [self singleTest];
    
//    [self timeTest];
    
//    [self operationTest];
    
    
}

//自定义 operation 测试

- (void)CustomOperationTest
{
    NSLog(@"主线程");
    
    if (!self.operQueue) {
        self.operQueue = [[NSOperationQueue alloc]init];
    }
    
    //    [self.operQueue setMaxConcurrentOperationCount:1];
    
    //    [self.operQueue addOperation:blockOper];
    //
    //    NSLog(@"end");
    
    CustomOperation *custA = [[CustomOperation alloc]initWithName:@"operA"];
    CustomOperation *custB = [[CustomOperation alloc]initWithName:@"operB"];
    CustomOperation *custC = [[CustomOperation alloc]initWithName:@"operC"];
    CustomOperation *custD = [[CustomOperation alloc]initWithName:@"operD"];
    
    // 线程之间相互依赖  不能循环依赖 发生死锁
    [custD addDependency:custA];
    [custA addDependency:custC];
    [custC addDependency:custB]; //最终执行顺序 是 BCAD
    
    [self.operQueue addOperation:custA];
    [self.operQueue addOperation:custB];
    [self.operQueue addOperation:custC];
    [self.operQueue addOperation:custD];
    
    NSLog(@"end");
  
}

- (void)operationTest
{
    NSLog(@"主线程");
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        NSInvocationOperation *invocationOpe = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationAction) object:nil];
//        
//        //创建完 之后 怎么执行
//        // 1.
//        
//        [invocationOpe start];
//
//        NSLog(@"end");
//    });
    
    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"invocation  %d",i);
            [NSThread sleepForTimeInterval:1];
        }

    }];
    [blockOper start];
    
}

- (void)invocationAction
{
    for (int i = 0; i<3; i++) {
        NSLog(@"invocation  %d",i);
        [NSThread sleepForTimeInterval:1];
    }
}




- (void)timeTest
{
    NSLog(@"主线程");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        NSLog(@"delay excute");
    });
}
//gcd 单例测试
- (void)singleTest
{
    TestSingle *single = [TestSingle instance];
    NSLog(@"%@",single);
}


//接下来 模拟两个http 异步请求 ,每个请求 我们给一个回调
- (void)sendRequest1:(void(^)())block
{
   //http 其实就是个异步请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
        NSLog(@"end task 1");

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"task1完毕 回到主线程");
            if (block) {
                block(); //回调到上一层
            }
        });
    });
    
}

- (void)sendRequest2:(void(^)())block
{
    //http 其实就是个异步请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
        NSLog(@"end task 2");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"task2完毕 回到主线程");
            if (block) {
                block(); //回调到上一层
            }
        });
    });
    
}

- (void)dispatchGroup
{
    NSLog(@"主线程");
    dispatch_queue_t  queue = dispatch_queue_create("com.test.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
//解决办法
    dispatch_group_enter(group); //enter 表示 是不是 要把什么东西放到group 当中  让什么继续持有
    [self sendRequest1:^{
        NSLog(@"task1 done");
        dispatch_group_leave(group);  //enter 与 leave 成对出现
    }];
    
    dispatch_group_enter(group); //enter 表示 是不是 要把什么东西放到group 当中  让什么继续持有
    [self sendRequest2:^{
        NSLog(@"task2 done");
        dispatch_group_leave(group);  //enter 与 leave 成对出现
    }];

    
//    dispatch_group_async(group, queue, ^{ //相当于 把队列 放在 group中
////                    //执行耗时任务
////                    NSLog(@"start task 1");
////                    [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
////                    NSLog(@"end task 1");
//        
//        [self sendRequest1:^{
//            NSLog(@"task1 done");
//        }];
//        
//    });
//    
//    dispatch_group_async(group, queue, ^{ //相当于 把队列 放在 group中
////        //执行耗时任务
////        NSLog(@"start task 2");
////        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
////        NSLog(@"end task 2");
//        
//        [self sendRequest2:^{
//            NSLog(@"task2 done");
//        }];
//    });
    
//    dispatch_group_async(group, queue, ^{ //相当于 把队列 放在 group中
//        //执行耗时任务
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
//        NSLog(@"end task 3");
//    });
    
    //然后 拿它的回调通知
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"all tasks over");
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            NSLog(@"回到主线程刷新UI");
        });
    });
    
}




- (void)GCDTest
{
//    NSLog(@"执行GCD");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //执行耗时任务
//        
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:3];  //睡眠3秒 模拟耗时任务
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //回到主线程 刷新UI
//            NSLog(@"刷新UI");
//        });
//        
//    });
    
    //接下来 来验证一下 dispatch_get_global 是 全局并发的
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  //global_queue第一个参数 是设置优先级的
//        //执行耗时任务
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
//        NSLog(@"end task 1");
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        //执行耗时任务
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
//        NSLog(@"end task 2");
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //执行耗时任务
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
//        NSLog(@"end task 3");
//    });

    //创建串行queue保证任务 结束顺序
  dispatch_queue_t queue=  dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_CONCURRENT);  //_t 表示 thread

    dispatch_async(queue, ^{  //把任务1放在串行队列里
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
        NSLog(@"end task 1");
    });
    
    dispatch_async(queue, ^{  //把任务1放在串行队列里
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
        NSLog(@"end task 2");
    });
    
    dispatch_async(queue, ^{  //把任务1放在串行队列里
        NSLog(@"start task 3");
        [NSThread sleepForTimeInterval:2];  //睡眠2秒 模拟耗时任务
        NSLog(@"end task 3");
    });
}



- (void)saleTicket
{
    TicketManager *ticketManager = [[TicketManager alloc]init];
    [ticketManager startToSale];
}

- (void)NSTreadTest
{
   NSLog(@"主线程");
    //初始化一个NSTread对象 3种方法
    
    // 1.通过alloc  init 方式创建并执行 线程
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [thread1 setName:@"thread1"];  //设置线程名字   便于调试
    [thread1 setThreadPriority:0.2];//设置优先级
    [thread1 start];  //启动该线程
    
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [thread2 setName:@"thread2"];
    [thread2 setThreadPriority:0.5]; //线程2的优先级高于 线程1
    [thread2 start];  //启动该线程
    
    
   // 第一种方式 可以设置线程名字
    
    
    
//    //2.通过 detachNewThreadSelector  创建  这是一个类方法
//    
//    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    //3.performSelector:
    
//    [self performSelector:@selector(run) withObject:nil];
//    [self performSelectorInBackground:@selector(run) withObject:nil]; //即在 后台开启一个子线程

    
   
}

- (void)run
{
    NSLog(@"%@  子线程",[NSThread currentThread].name);
    for (int i = 1; i<=10; i++) {
        NSLog(@"%d",i);
        sleep(1); //每打印一下 睡眠1秒  否则 嗖的一下 10次全部打印完了
        
        if (i == 10) {
            [self performSelectorOnMainThread:@selector(runMainThread) withObject:nil waitUntilDone:YES]; //子线程执行完  回到主线程
        }
    }
}
- (void)runMainThread
{
    NSLog(@"回到主线程");
}

//- (void)pThreadTest
//{
//    NSLog(@"主线程");
//    pthread_t pthread;
//    pthread_create(&pthread, NULL, run, NULL);
// 
//}
//void *run(void *data){  //这是一个c语言的函数
//    
//    NSLog(@"子线程");
//    //我们要模拟一个任务的执行 所以 简单写一个for循环
//    for (int i = 1; i<10; i++) {
//        NSLog(@"%d",i);
//        sleep(1); //每打印一下 睡眠1秒  否则 嗖的一下 10次全部打印完了
//    }
//    
//    return NULL;
//}


- (void)buttonAction:(UIButton *)sender
{
    HomeListViewController *homeList = [[HomeListViewController alloc]init];
    [self.navigationController pushViewController:homeList animated:YES];
}

- (void)KVOtest
{
    stockForKVO = [[StockData alloc] init];
    [stockForKVO setValue:@"searph" forKey:@"stockName"];
    [stockForKVO setValue:@"10.0" forKey:@"price"];
    [stockForKVO addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30 )];
    myLabel.textColor = [UIColor redColor];
    myLabel.text = [stockForKVO valueForKey:@"price"];
    [self.view addSubview:myLabel];
    
    UIButton * b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(0, 200, 100, 30);
    b.backgroundColor = [UIColor yellowColor];
    [b addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

- (void)buttonAction
{
    [stockForKVO setValue:@"20.0" forKey:@"price"];
}

//实现回调方法

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"price"])
    {
        myLabel.text = [stockForKVO valueForKey:@"price"];
    }
}

- (void)dealloc
{
    [stockForKVO removeObserver:self forKeyPath:@"price"];
}
//测试弹出自定义view
- (void)initUI
{
    //创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"HERO博客" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnOnClick
{
//    _alertView = [[HWAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    _alertView.delegate = self;
//    [_alertView show];
    
    //自定义蒙版view
    
    _showView = [[ShowAnimationView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_showView showView];

}

- (void)alertView:(HWAlertView *)alertView didSelectOptionButtonWithTag:(NSInteger)tag
{
    if (tag == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"] options:nil completionHandler:^(BOOL success) {
        }];
    }
    _alertView.hidden = YES;
    _alertView = nil;
}

#pragma mark - 测试一个自己本地服务器的接口
- (void)loadLocalRequest
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setObject:@(1) forKey:@"type"];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
//    manage.requestSerializer = [AFJSONRequestSerializer serializer]; //请求设置成json格式
//   manage.responseSerializer = [AFJSONResponseSerializer serializer]; //响应数据  是 json 格式   这样接收的response数据 就是json字典数据
    
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manage.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
//    manage.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];  //设置相应内容类型
    
    manage.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/json", @"text/javascript", nil];  //设置相应内容类型
    manage.requestSerializer.timeoutInterval = 10.0f;  //请求 时间超时间隔 10秒
    
    // 下面 post 方法是 AFHTTPSessionManager  框架里面  封装好的
    [manage POST:@"http://127.0.0.1/cs/post.php" parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"网络请求的URL为:  %@",task.currentRequest.URL);
        NSData *data = responseObject;
        NSString *dataStr =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       
        NSLog(@"转化后的字符串为：%@", dataStr);
        //NSData 直接转化成  NSDictionary
        NSDictionary *tempDictQueryDiamond = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"转化后的数据为： %@",tempDictQueryDiamond);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
    }];
    
    
//    //换成get方法
//    [manage GET:@"http://127.0.0.1/cs/post.php" parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"网络请求的URL为:  %@",task.currentRequest.URL);
//        NSData *data = responseObject;
//        NSString *dataStr =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"转化后的字符串为：%@", dataStr);
//        //NSData 直接转化成  NSDictionary
//        NSDictionary *tempDictQueryDiamond = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"转化后的数据为： %@",tempDictQueryDiamond);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"请求失败");
//    }];

    

}

- (void)initTable{
    _tableView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

//模拟测试 一个任务接口列表

- (void)loadTaskList
{
    
    
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setObject:@"send" forKey:@"actiontype"];
    [parametersDic setObject:@"tasklist" forKey:@"classtype"];
    
    
    [parametersDic setObject:@"50695729071" forKey:@"appkey"];
    [parametersDic setObject:@"3" forKey:@"cust_class"];
    [parametersDic setObject:@"15806" forKey:@"cust_id"];
    [parametersDic setObject:@"ba27e7e219356517471d8d7c87130c15" forKey:@"display_id"];
    [parametersDic setObject:@"" forKey:@"keyword"];
    [parametersDic setObject:@"zh-Hans-CN" forKey:@"language"];
    [parametersDic setObject:@"eliteall.newproject" forKey:@"method"];
    [parametersDic setObject:@"list" forKey:@"opearpage"];
    [parametersDic setObject:@"ios" forKey:@"os"];
    [parametersDic setObject:@"1" forKey:@"pagenum"];
    [parametersDic setObject:@"10" forKey:@"perpage"];
    [parametersDic setObject:@"1493705278880" forKey:@"timer"];
    [parametersDic setObject:@"d54ee7cc810d742347b4952bfbceaa84" forKey:@"token"];
    [parametersDic setObject:@"mytasknew" forKey:@"type"];
    [parametersDic setObject:@"15921696710" forKey:@"username"];
    [parametersDic setObject:@"AEDF93F1-1705-47D5-A4CB-2D3A6D6867D1" forKey:@"uuid"];
    [parametersDic setObject:@"2.1.3" forKey:@"version"];
    [parametersDic setObject:@"doing" forKey:@"statustype"];
    
    [HttpRequest getWithManager:self parameters:parametersDic success:^(id responseObject) {
        NSLog(@"任务列表请求成功：%@",responseObject);
        
        NSArray *arrayData = [[[responseObject objectForKey:@"data"]objectForKey:@"data"]objectForKey:@"tasks"];
        
        for (NSDictionary *dict in arrayData) {
           
//            TaskListModel *model = [[TaskListModel alloc]initModelWithDictionary:dict];
//            NSLog(@"手动转化的model为： %@",model);
            
            //通过MJ 转化成 model
            TaskListModel *model = [TaskListModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:model];
            
        }
        
    } failure:^(NSOperation *operatio, NSError *error) {
        
        NSLog(@"接口请求失败");
    } businessFailure:^(id responseObject) {
        
        NSLog(@"接口请求成功，业务逻辑请求失败");
    }];

}



#pragma mark - 模拟测试一个正式的公告接口
- (void) loadData
{
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setObject:@"49460408557" forKey:@"appkey"];
    [parametersDic setObject:@"3" forKey:@"cust_class"];
    [parametersDic setObject:@"15806" forKey:@"cust_id"];
    [parametersDic setObject:@"ba27e7e219356517471d8d7c87130c15" forKey:@"display_id"];
    [parametersDic setObject:@"" forKey:@"keyword"];
    [parametersDic setObject:@"zh-Hans-CN" forKey:@"language"];
    [parametersDic setObject:@"eliteall.newproject" forKey:@"method"];
    [parametersDic setObject:@"list" forKey:@"opearpage"];
    [parametersDic setObject:@"ios" forKey:@"os"];
    [parametersDic setObject:@"1" forKey:@"pagenum"];
    [parametersDic setObject:@"10" forKey:@"perpage"];
    [parametersDic setObject:@"1492752834322" forKey:@"timer"];
    [parametersDic setObject:@"d54ee7cc810d742347b4952bfbceaa84" forKey:@"token"];
    [parametersDic setObject:@"releasenotice" forKey:@"type"];
    [parametersDic setObject:@"15921696710" forKey:@"username"];
    [parametersDic setObject:@"2EACE66F-1A27-4237-803B-83AFD4A295E2" forKey:@"uuid"];
    [parametersDic setObject:@"2.1.2" forKey:@"version"];
    
    [HttpRequest getWithManager:self parameters:parametersDic success:^(id responseObject) {
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(NSOperation *operatio, NSError *error) {
        
        NSLog(@"接口请求失败");
    } businessFailure:^(id responseObject) {
        
        NSLog(@"接口请求成功，业务逻辑请求失败");
    }];
}












@end
