//
//  HWAlertView.m
//  Construct
//
//  Created by lisa on 2017/5/10.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "HWAlertView.h"

@implementation HWAlertView

/**
 view的初始化方法  并设置其frame 大小
 */
- (id)initWithFrame:(CGRect)frame  //重写view的基类方法
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    
    return self;
}


// 初始化子视图
- (void)setupChildView
{
    //背景view
    UIView *bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    [self addSubview:bgView];
    
    //背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    imageView.frame = CGRectMake(0, 0, 280, 120);
    imageView.center = CGPointMake(self.center.x, self.center.y);
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageView];
    
    //弹窗标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 280, 40)];
    label.text = @"是否进入HERO博客";
    label.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:label];
    
    //选项按钮
    NSArray *titleArray = @[@"取消",@"确定"];
    NSArray *imageArray = @[@"",@""];
    for (int i = 0; i < imageArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40 + 1120 * i, 70, 80, 30)];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        btn.tag = i;
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
    }
}

- (void)btnOnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:didSelectOptionButtonWithTag:)]) {
        
        [_delegate alertView:self didSelectOptionButtonWithTag:btn.tag];
    }
}
- (void)show
{
    [self makeKeyAndVisible];
}

- (void)dismiss
{
    [self resignKeyWindow];
    [self removeFromSuperview];
}



@end
