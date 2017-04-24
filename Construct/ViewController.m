//
//  ViewController.m
//  Construct
//
//  Created by lisa on 2016/12/7.
//  Copyright © 2016年 lisa. All rights reserved.
//

#import "ViewController.h"
#import "ZFAlertViewController.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    ZFAlertViewController *alertVC = [ZFAlertViewController alertControllerWithTitle:@"发现新版本" message:@"v2.1.2"];
//    alertVC.messageAlignment = NSTextAlignmentLeft;
//    ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"我知道了" handler:^(ZFAlertAction *action) {
//    }];
//    ZFAlertAction *update = [ZFAlertAction actionWithTitle:@"立即更新" handler:^(ZFAlertAction *action) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/dian-jingfun-for-lol-ying/id1070851966?mt=8&uo=4"]];
//    }];
//    
//    [alertVC addAction:cancel];
//    [alertVC addAction:update];
//    [self presentViewController:alertVC animated:NO completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}





























@end
