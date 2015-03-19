//
//  NewsTableViewController.h
//  LOLDemo
//
//  Created by yufu on 15/3/14.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"


@interface NewsTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ImagePlayerViewDelegate>

@property (nonatomic,strong) ImagePlayerView *newsContentImagePlayer;

@end
