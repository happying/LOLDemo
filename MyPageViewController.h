//
//  MyPageViewController.h
//  广告循环滚动效果
//
//  Created by yufu on 15/3/3.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageViewController : UIPageControl

- (id)initWithFrame:(CGRect)frame;
- (void)updateDots;
- (void)setImagePageForStateNormal:(UIImage *)normalImage StateHighlighted:(UIImage *)highLightedImage;  // 设置按钮的图片
@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHighlighted;
@end