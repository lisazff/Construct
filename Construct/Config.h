//
//  Config.h
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//


#import "Utils.h"
#ifndef Config_h
#import "AppDelegate.h"
#define Config_h

#define KCOLOR(str) [Utils colorConvertFromString:str];
#define ScreenSizeWidth     ([UIScreen mainScreen].bounds.size.width)
#define ScreenSizeHeight    ([UIScreen mainScreen].bounds.size.height)

#define zf_App               ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#endif /* Config_h */
