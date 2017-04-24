//
//  ZFAlertViewController.h
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(ZFAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;

@end

@interface ZFAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<ZFAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)addAction:(ZFAlertAction *)action;

@end
