//
//  ShowAnimationView.m
//  Construct
//
//  Created by lisa on 2017/5/10.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "ShowAnimationView.h"

@interface ShowAnimationView ()

@property (nonatomic, strong) UIView *contentView;  //内容view
@end
@implementation ShowAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self layoutAllSubviews];
    }
    return self;
}

- (void)layoutAllSubviews
{
    //创建灰色背景
    UIView *bgView = [[UIView alloc]initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    [self addSubview:bgView];
    
    //创建内容view
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-80, 180)];
    _contentView.center = CGPointMake(self.center.x, self.center.y);
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    [self addSubview:_contentView];
    
    //点击背景图 要消失的  所以 要在背景图上  添加手势  隐藏视图事件
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissContentView:)];
    [bgView addGestureRecognizer:tap];

}


- (void)dismissContentView:(UITapGestureRecognizer *)gesture
{
    [self dismissView];
}

- (void)dismissView
{
  
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}













@end
