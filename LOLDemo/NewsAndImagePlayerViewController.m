//
//  NewsAndImagePlayerViewController.m
//  LOLDemo
//
//  Created by yufu on 15/3/19.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "NewsAndImagePlayerViewController.h"
#import "Masonry.h"

@interface NewsAndImagePlayerViewController ()
@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation NewsAndImagePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"identifier";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)imagePlayerCellWithIndex:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:self.newsContentImagePlayer];
        [self.newsContentImagePlayer  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView);
            make.top.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(165);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 165;
    }
    return 0.16 * tableView.frame.size.height;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
