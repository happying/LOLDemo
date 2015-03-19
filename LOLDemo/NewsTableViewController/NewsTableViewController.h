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

- (UITableViewCell *)imagePlayerCellWithIndex:(NSIndexPath *)indexPath;

@property (nonatomic,strong) ImagePlayerView *newsContentImagePlayer;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic) NSInteger cellNumber;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSString *cellIdentifier;

@end
