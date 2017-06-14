//
//  TaskListModel.m
//  Construct
//
//  Created by lisa on 2017/5/2.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "TaskListModel.h"

@implementation TaskListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
              @"ID":@"id"
             
             };
}
- (instancetype)initModelWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.ID = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
        self.openedBy = [dictionary objectForKey:@"openedBy"];
        self.openedDate = [dictionary objectForKey:@"openedDate"];
        self.repeat = [dictionary objectForKey:@"repeat"];
        self.status = [dictionary objectForKey:@"status"];
        self.projectID = [dictionary objectForKey:@"projectID"];
        self.projectName = [dictionary objectForKey:@"projectName"];
        self.accid = [dictionary objectForKey:@"accid"];
        self.tag_name = [dictionary objectForKey:@"tag_name"];
        self.tag_color = [dictionary objectForKey:@"tag_color"];
        self.alert = [dictionary objectForKey:@"alert"];
        self.nowtime = [dictionary objectForKey:@"nowtime"];
        self.count = [dictionary objectForKey:@"count"];
    }
    
    return self;
    
}
@end
