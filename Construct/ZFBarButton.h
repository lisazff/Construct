//
//  ZFBarButton.h
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LLTabBarItemType) {
    LLTabBarItemNormal = 0,
    LLTabBarItemRise,
};

@interface ZFBarButton : UIButton

@property (nonatomic, assign) LLTabBarItemType tabBarItemType;

@end
