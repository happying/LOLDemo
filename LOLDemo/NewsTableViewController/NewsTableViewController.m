//
//  NewsTableViewController.m
//  LOLDemo
//
//  Created by yufu on 15/3/14.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "NewsTableViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "contentsViewController.h"

@interface NewsTableViewController ()

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic) NSInteger cellNumber;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *imagesArray;


@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = self.tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self setUpRefresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"壁纸1.jpg"], [UIImage imageNamed:@"壁纸2.jpg"], [UIImage imageNamed:@"壁纸3.jpg"], [UIImage imageNamed:@"壁纸4.jpg"], nil];
    }
    return _imagesArray;
}

-(NSInteger)numberOfItems{
    return self.imagesArray.count;
}

#pragma mark - MJRefresh
//集成刷新空间
- (void)setUpRefresh{
    //下拉刷新，刷新时会调用self的headerRefreshing
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    NSArray *headerReady = @[[UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    NSArray *headerNornal = @[[UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    NSArray *headerGif = @[[UIImage imageNamed:@"common_loading_anne_1@2x.png"], [UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    // 设置普通状态的动画图片
    [self.tableView.gifHeader setImages:headerNornal forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableView.gifHeader setImages:headerReady forState:MJRefreshHeaderStatePulling];
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:headerGif forState:MJRefreshHeaderStateRefreshing];
    
    //同上
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    // 设置正在刷新状态的动画图片
    NSArray *footerGif = @[[UIImage imageNamed:@"timo(new).png"], [UIImage imageNamed:@"timo(new)2.png"]];
    self.tableView.gifFooter.refreshingImages = footerGif;
    //一进入程序就开始刷新
    //    [self.tableView.header beginRefreshing];
    self.tableView.footer.automaticallyRefresh = NO;
    
    //设置文字
    [self.tableView.header setTitle:@"下拉刷新..." forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"释放刷新..." forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"加载中..." forState:MJRefreshHeaderStateRefreshing];
    
    [self.tableView.footer setTitle:@"上拉加载" forState:MJRefreshFooterStateIdle];
    [self.tableView.footer setTitle:@"释放加载" forState:MJRefreshFooterStateRefreshing];
    [self.tableView.footer setTitle:@"加载中" forState:MJRefreshFooterStateNoMoreData];
    
}

//下拉刷新触发方法
- (void)headerRefreshing{
    //添加数据
    for (int i = 0; i < 13; i++) {
        NSString *imageName = [NSString stringWithFormat:@"LOL%d.jpg" , i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [_imageArray addObject:image];
        imageName = @"";
    }
    
    //利用gcd造成一个两秒的时差以观察效果并重新加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
        //加载完之后结束
        [self.tableView.header endRefreshing];
    });
}

//上拉加载触发方法
- (void)footerRefreshing{
    //添加数据
    for (int i = 0; i < 13; i++) {
        NSString *imageName = [NSString stringWithFormat:@"LOL%d.jpg" , i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [_imageArray addObject:image];
        imageName = @"";
    }
    
    //利用gcd造成一个两秒的时差以观察效果并重新加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
        //加载完之后结束
        [self.tableView.footer endRefreshing];
    });
}

#pragma mark - recored the getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSInteger)cellNumber{
    _cellNumber = self.cellNumber + 13;
    return _cellNumber;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 13; i++) {
            NSString *imageName = [NSString stringWithFormat:@"LOL%d.jpg" , i+1];
            NSLog(@"%@",imageName);
            UIImage *image = [UIImage imageNamed:imageName];
            [_imageArray addObject:image];
            imageName = @"";
        }
    }
    
    NSLog(@"%@",_imageArray);
    return _imageArray;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UITableViewCell *)imagePlayerCellWithIndex:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"identifier";
    NSString *date = @"03-13";
    UILabel *dateLable = [[UILabel alloc] init];
    dateLable.text = date;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    self.newsContentImagePlayer = [[ImagePlayerView alloc] init];
    self.newsContentImagePlayer.imagePlayerViewDelegate = self;
    self.newsContentImagePlayer.scrollInterval = 5.0f;
    self.newsContentImagePlayer.pageControlPosition = ICPageControlPosition_BottomRight;
    self.newsContentImagePlayer.hidePageControl = NO;
    [cell.contentView addSubview:self.newsContentImagePlayer];
    
    [_newsContentImagePlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView);
        make.top.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(cell.contentView);
        make.height.mas_equalTo(165);
    }];

    return cell;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index{
    imageView.image = [self.imagesArray objectAtIndex:index];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"identifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *date = @"03-13";
    UILabel *dateLable = [[UILabel alloc] init];
    dateLable.text = date;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        if (indexPath.row == 0) {
                cell = [self imagePlayerCellWithIndex:indexPath];
                return cell;
        }
        NSInteger index = indexPath.row;
        dateLable.font = [UIFont fontWithName:@"Helvetica" size:10];
        dateLable.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        [cell.contentView addSubview:dateLable];
        [dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cell.contentView).offset(-11);
            make.right.mas_equalTo(cell.contentView).offset(-11);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.imageArray objectAtIndex:index]];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).offset(14);
            make.top.mas_equalTo(cell.contentView).offset(11);
            make.size.mas_equalTo(CGSizeMake(0.25 * cell.frame.size.width, 0.75 * 0.16 * tableView.frame.size.height));
        }];
        NSLog(@"%lf",cell.frame.size.height);
        
        NSString *titleString = @"每日一笑，提莫你别种蘑菇了";
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = titleString;
        titleLable.font = [UIFont fontWithName:@"Helvetica" size:15];
        [cell.contentView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(8);
            make.top.mas_equalTo(imageView);
        }];
        
        NSString *detailString = @"英雄联盟全体英雄祝大家新春快乐，万事如意";
        UILabel *detailLable = [[UILabel alloc] init];
        detailLable.text = detailString;
        detailLable.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        detailLable.lineBreakMode = NSLineBreakByWordWrapping;
        detailLable.numberOfLines = 0;
        detailLable.font = [UIFont fontWithName:@"Helvetica" size:14];
        [cell.contentView addSubview:detailLable];
        [detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLable);
            make.top.mas_equalTo(titleLable.mas_bottom).offset(5);
            make.width.mas_equalTo(0.65 * [UIScreen mainScreen].bounds.size.width);
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

@end
