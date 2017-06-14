//
//  TaskListModel.h
//  Construct
//
//  Created by lisa on 2017/5/2.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *openedBy;
@property (nonatomic, copy) NSString *openedDate;
@property (nonatomic, copy) NSString *repeat;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *projectID;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *accid;
@property (nonatomic, copy) NSString *tag_name;
@property (nonatomic, copy) NSString *tag_color;
@property (nonatomic, copy) NSString *alert;
@property (nonatomic, copy) NSString *nowtime;
@property (nonatomic, copy) NSString *count;

// 手动 人工 字典转model

- (instancetype)initModelWithDictionary:(NSDictionary *)dictionary;

@end
