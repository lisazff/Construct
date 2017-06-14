//
//  TaskDetailCell.m
//  Construct
//
//  Created by lisa on 2017/5/2.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "TaskDetailCell.h"

@interface TaskDetailCell ()
@property (nonatomic, strong)UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *subContentLabel;
@property (nonatomic, strong) UILabel *remarkLabel;


@end

@implementation TaskDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TaskDetailCellIdentifier";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupAllChildView
{
    
}















@end
