//
//  HomeViewController.m
//  Construct
//
//  Created by lisa on 2017/4/12.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
//    [self setTitleName:@"主页" andFont:18.f];
    
   
//     //    1.设置请求路径
//    NSString *urlStr=[NSString stringWithFormat:@"http://192.168.1.53:8080/MJServer/login?username=%@&pwd=%@",@"123",@"1233"];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //    2.创建请求对象
//      NSURLRequest *request=[NSURLRequest requestWithURL:url];
//   
//    //    3.发送请求

    [self loadData];
    
}

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
