//
//  TabBarViewController.m
//  Construct
//
//  Created by lisa on 2017/4/12.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "TabBarViewController.h"

#import "ZFTabbar.h"
#import "ZFBarButton.h"
#import "BaseViewController.h"
#import "BaseNavigationViewController.h"
@interface TabBarViewController ()

@property (nonatomic, strong) ZFTabbar *myTabbar; //自己定义的tabbar  与系统的区分
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTabbar];
    [self initControllers];
}


/**
 主要2个工作  设置tabbar、  设置各子控制器
 */

- (void)initTabbar
{
    _myTabbar = [[ZFTabbar alloc]initWithFrame:self.tabBar.bounds];

    //初始化 tabbar上的各个按钮
    CGFloat buttonWidth =  ScreenSizeWidth/4;
    CGFloat buttonHeight = self.tabBar.frame.size.height;
    
    //分别创建各个tab button
    ZFBarButton *homeButton = [self tabbarButtonWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight) title:@"首页" normalImageName:@"homeIcon" selectedImageName:@"homeIconSelected" tabbarButtonType:LLTabBarItemNormal];
    ZFBarButton *chatButton = [self tabbarButtonWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight) title:@"聊天" normalImageName:@"chatIcon" selectedImageName:@"chatIconSelected" tabbarButtonType:LLTabBarItemNormal];
    ZFBarButton *findButton = [self tabbarButtonWithFrame:CGRectMake(buttonWidth*2, 0, buttonWidth, buttonHeight) title:@"发现" normalImageName:@"briefcaseIcon" selectedImageName:@"briefcaseIconSelected" tabbarButtonType:LLTabBarItemNormal];
    ZFBarButton *meButton = [self tabbarButtonWithFrame:CGRectMake(buttonWidth*3, 0, buttonWidth, buttonHeight) title:@"我的" normalImageName:@"meIcon" selectedImageName:@"meIconSelected" tabbarButtonType:LLTabBarItemNormal];
    
    _myTabbar.tabBarItems = @[homeButton,chatButton,findButton,meButton];
    _myTabbar.userInteractionEnabled = YES;
    
    [self.tabBar addSubview:self.myTabbar];
    
}

- (ZFBarButton *)tabbarButtonWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabbarButtonType:(LLTabBarItemType)tabbarButtonType
{
    ZFBarButton *button = [[ZFBarButton alloc]initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];  //设置标题
    [button setTitle:title forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:8.0];  //设置标题字体大小
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage  = [UIImage imageNamed:selectedImageName];
    [button setImage:normalImage forState:UIControlStateNormal];  //设置图片
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    
    [button setTitleColor:[Utils colorConvertFromString:@"#a3a3a3"] forState:UIControlStateNormal]; //设置标题颜色
    [button setTitleColor:[Utils colorConvertFromString:@"#3f3f3f"] forState:UIControlStateSelected];
    
    return button;
}

//初始化子控制器
- (void)initControllers
{
    NSMutableArray *controllersArray = [[NSMutableArray alloc]init];
    NSArray *classNameArray = @[@"HomeViewController",@"ChatViewController",@"FindViewController",@"MeViewController"];
    for (int i = 0; i< classNameArray.count; i++) {
        Class class = NSClassFromString(classNameArray[i]);
        
        BaseViewController *root = [[class alloc]init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:root];
        [controllersArray addObject:nav];
    }
    self.viewControllers = controllersArray;
    
}

























@end
