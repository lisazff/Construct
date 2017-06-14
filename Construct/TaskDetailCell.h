//
//  TaskDetailCell.h
//  Construct
//
//  Created by lisa on 2017/5/2.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewModel.h"
@interface TaskDetailCell : UITableViewCell

@property (nonatomic, strong) TaskViewModel *viewModel;

+ (instancetype) cellWithTableView:(UITableView *)tableView;
@end
