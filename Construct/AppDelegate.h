//
//  AppDelegate.h
//  Construct
//
//  Created by lisa on 2016/12/7.
//  Copyright © 2016年 lisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) TabBarViewController * tabView; //暴露出来  方面其他地方用

@end

