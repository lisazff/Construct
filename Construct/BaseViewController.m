//
//  BaseViewController.m
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark--设置导航栏名字
-(void)setTitleName:(NSString *)name andFont:(CGFloat)fontH
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 140, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:fontH];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = name;
    titleLabel.userInteractionEnabled = YES;
    self.navigationItem.titleView=titleLabel;
}

@end
