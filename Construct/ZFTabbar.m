//
//  ZFTabbar.m
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "ZFTabbar.h"
#import "ZFBarButton.h"
//#import "Config.h"
#import "BaseNavigationViewController.h"
#import "TabBarViewController.h"

#import "HomeViewController.h"
#import "ChatViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"


@interface ZFTabbar ()

@property (nonatomic,assign) NSInteger index; //tabbar上 的 索引序列

@end
@implementation ZFTabbar

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        self.index = 0;  //默认为第一个
    }
    return self;
}

#pragma mark - Private Method    tabbar的配置  设置颜色等

- (void)config {
    self.backgroundColor = KCOLOR(@"#fdfdfd");
    
//    self.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Touch Event  选项button的点击事件

- (void)itemSelected:(ZFBarButton *)sender {
    
    [self setSelectedIndex:sender.tag];  //根据点击的tag值  进行相关的业务处理
}

- (void)setSelectedIndex:(NSInteger)index {
    if(self.index == index)
    {
        BaseNavigationViewController *nav = zf_App.tabView.viewControllers[index];
        if(index == 0)
        {
            HomeViewController * home = (HomeViewController*)nav.topViewController;
        }
    }
    self.index = index;
    for (ZFBarButton *item in _tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
    }
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    TabBarViewController * tabBarController =(TabBarViewController*)keyWindow.rootViewController;
    if (tabBarController) {
        tabBarController.selectedIndex = index;
    }
}

#pragma mark - Setter   设置tabbar上的各按钮

- (void)setTabBarItems:(NSArray *)tabBarItems {
    _tabBarItems = tabBarItems;
    NSInteger itemTag = 0;
    for (id item in tabBarItems) {
        if ([item isKindOfClass:[ZFBarButton class]]) {
            if (itemTag == 0) {
                ((ZFBarButton *)item).selected = YES;
            }
            ((ZFBarButton *)item).tag = itemTag;
            [((ZFBarButton *)item) addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:item];
            itemTag++;
        }
    }
}

@end
