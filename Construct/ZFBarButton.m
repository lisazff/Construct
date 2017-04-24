//
//  ZFBarButton.m
//  Construct
//
//  Created by lisa on 2017/4/3.
//  Copyright © 2017年 lisa. All rights reserved.
//

#import "ZFBarButton.h"

@implementation ZFBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.backgroundColor = [UIColor redColor];
}

/**
 1、init初始化不会触发layoutSubviews
 
 但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
 
 2、addSubview会触发layoutSubviews
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */

- (void)layoutSubviews {  //改变button上   title、 imageView的中心位置
    [super layoutSubviews];
    
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.titleLabel sizeToFit];
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    if (imageSize.width != 0 && imageSize.height != 0) {
        CGPoint imageViewCenter = self.imageView.center;
        imageViewCenter.x = CGRectGetWidth(self.frame) / 2;
        imageViewCenter.y = (CGRectGetHeight(self.frame) - titleSize.height) / 2-2;
        self.imageView.center = imageViewCenter;
    }
    
    CGPoint labelCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 3 - titleSize.height / 2-2);
    self.titleLabel.center = labelCenter;
}


/**
 *  复写系统的高亮实现，禁止按钮高亮
 *  此函数里不用写任何代码
 */
- (void)setHighlighted:(BOOL)highlighted{
    // do not anything
}

@end
