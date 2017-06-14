//
//  HWAlertView.h
//  Construct
//
//  Created by lisa on 2017/5/10.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 自定义view  只是一个view  在各种场景下 可以服用  具体的业务 要根据具体ViewController业务  所有 在此 声明一个 protocal  
 
 设置一个代理
 
 代理方法中 要带着该 自定义view对象  所以要用 @class  声明一下
 */

@class HWAlertView;
@protocol HWAlertViewDelegate <NSObject>

- (void)alertView:(HWAlertView *)alertView  didSelectOptionButtonWithTag:(NSInteger)tag; //把点击的按钮的tag值传进来

@end
@interface HWAlertView : UIWindow

@property (nonatomic, weak) id<HWAlertViewDelegate> delegate;

- (void)show;  //view 显示方法
- (void)dismiss; //view 消失方法

@end
