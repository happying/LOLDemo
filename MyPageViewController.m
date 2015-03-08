//
//  MyPageViewController.m
//  广告循环滚动效果
//
//  Created by yufu on 15/3/3.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController (private)  // 声明一个私有方法, 该方法不允许对象直接使用
@end
@implementation MyPageViewController


- (id)initWithFrame:(CGRect)frame { // 初始化
    self = [super initWithFrame:frame];
    return self;
}

- (void)setImagePageStateNormal:(UIImage *)image {  // 设置正常状态点按钮的图片
    _imagePageStateHighlighted = image ;
    [self updateDots];
}

- (void)setImagePageStateHighlighted:(UIImage *)image { // 设置高亮状态点按钮图片
    _imagePageStateNormal = image ;
    [self updateDots];
}
-(void)setImagePageForStateNormal:(UIImage *)normalImage StateHighlighted:(UIImage *)highLightedImage{
    _imagePageStateHighlighted = normalImage;
    _imagePageStateNormal = highLightedImage;
    [self updateDots];

}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
//    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}

- (void)updateDots { // 更新显示所有的点按钮
    if (_imagePageStateNormal || _imagePageStateHighlighted)
    {
        NSArray *subview = self.subviews;  // 获取所有子视图
        for (NSInteger i = 0; i < [subview count]; i++)
        {
            UIImageView *dot = [self imageViewForSubview:[subview  objectAtIndex:i]];
            dot.image = self.currentPage == i ? self.imagePageStateNormal : self.imagePageStateHighlighted;
        }
    }
    
}

- (void)dealloc { // 释放内存

}

- (UIImageView *) imageViewForSubview: (UIView *) view
{
    UIImageView * dot = nil;
    if ([view isKindOfClass: [UIView class]])
    {
        for (UIView* subview in view.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }
    else
    {
        dot = (UIImageView *) view;
    }
    
    return dot;
}

@end
