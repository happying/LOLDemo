//
//  ViewController.m
//  MySelfDataForLOLDemo
//
//  Created by yufu on 15/3/15.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "MySelfDataForLOLDemoViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"


@interface MySelfDataForLOLDemoViewController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) UIImageView *topImageView;
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, strong) UIButton *firstWinButton;

@property(nonatomic, strong) UIView *informationView;
@property(nonatomic, strong) UIView *zuAnView;
@property(nonatomic, strong) UIButton *playerHeadBotton;
@property(nonatomic, strong) UIButton *gameDatabutton;
@property(nonatomic, strong) UIImageView *playerHeadImageView;
@property(nonatomic, strong) UIButton *usuallyUseHeroView;
@property(nonatomic, strong) UIView *recentlyRecordView;
@property(nonatomic, strong) UIView *recentlyRecordDataView;

@end

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation MySelfDataForLOLDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView.backgroundColor = [UIColor colorWithRed:212/255.0 green:209/255.0 blue:211/255.0 alpha:1];
    
    CGSize newSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 50);
    [self.scrollView setContentSize:newSize];
    [self.view addSubview:self.scrollView];

    NSLog(@"%f",self.scrollView.contentSize.height);
    NSLog(@"%f",self.scrollView.frame.size.height);
    [self scrollViewSetter];
    [self setUpRefresh];
    
}

- (void)scrollViewSetter{
    [self topImageViewSetter];
    [self informationViewSetter];
}

#pragma mark - MJRefresh
//集成刷新空间
- (void)setUpRefresh{
    //下拉刷新，刷新时会调用self的headerRefreshing
    [self.scrollView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    NSArray *headerReady = @[[UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    NSArray *headerNornal = @[[UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    NSArray *headerGif = @[[UIImage imageNamed:@"common_loading_anne_1@2x.png"], [UIImage imageNamed:@"common_loading_anne_0@2x.png"]];
    // 设置普通状态的动画图片
    [self.scrollView.gifHeader setImages:headerNornal forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.scrollView.gifHeader setImages:headerReady forState:MJRefreshHeaderStatePulling];
    // 设置正在刷新状态的动画图片
    [self.scrollView.gifHeader setImages:headerGif forState:MJRefreshHeaderStateRefreshing];
    //设置文字
    [self.scrollView.header setTitle:@"下拉刷新..." forState:MJRefreshHeaderStateIdle];
    [self.scrollView.header setTitle:@"释放刷新..." forState:MJRefreshHeaderStatePulling];
    [self.scrollView.header setTitle:@"加载中..." forState:MJRefreshHeaderStateRefreshing];
}

//下拉刷新触发方法
- (void)headerRefreshing{
    //利用gcd造成一个两秒的时差以观察效果并重新加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //加载完之后结束
        [self.scrollView.header endRefreshing];
    });
}

//////////////////////////////////////////////////////////////////////////////
- (void)topImageViewSetter{
    self.topImageView = [[UIImageView alloc] init];
    _topImageView.image = [UIImage imageNamed:@"default_personal_bg@2x.png"];
    [self.scrollView addSubview:_topImageView];
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(0.3 * SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.image = [UIImage imageNamed:@"default_head@2x.png"];
    [_topImageView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topImageView).offset(0.028 * SCREEN_WIDTH);
        make.bottom.mas_equalTo(_topImageView).offset(-0.028 * SCREEN_WIDTH);
        make.height.mas_equalTo(0.2 * SCREEN_WIDTH);
        make.width.mas_equalTo(0.2 * SCREEN_WIDTH);
    }];
    
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.text = @"新晴余快";
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont fontWithName:@"" size:15];
    [_topImageView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_headImageView);
    }];
    
    UIImageView *sexImageView = [[UIImageView alloc] init];
    sexImageView.image = [UIImage imageNamed:@"friend_sex_male@2x.png"];
    [_topImageView addSubview:sexImageView];
    [sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLable.mas_right).offset(5);
        make.top.mas_equalTo(nameLable);
        make.height.mas_equalTo(nameLable);
        make.width.mas_equalTo(nameLable.mas_height);
    }];
    
    _firstWinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_firstWinButton setBackgroundImage:[UIImage imageNamed:@"first_win_calendar_btn_normal@2x.png"] forState:UIControlStateNormal];
    [_firstWinButton setBackgroundImage:[UIImage imageNamed:@"first_win_calendar_btn_press@2x.png"] forState: UIControlStateSelected];
    _firstWinButton.backgroundColor = [UIColor clearColor];
    [_firstWinButton setTitle:@"首胜可用 " forState:UIControlStateNormal];
    _firstWinButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [_firstWinButton addTarget:self action:@selector(firstButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.scrollView addSubview:_firstWinButton];
    [_firstWinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_topImageView).offset(-15);
        make.width.mas_equalTo(0.242 * SCREEN_WIDTH);
        make.height.mas_equalTo(0.4 * 0.2 * SCREEN_WIDTH + 5);
        make.centerY.mas_equalTo(_headImageView);
    }];
    
    UIImageView *firstWinButtonRightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first_win_calendar_arrow@2x.png"]];
    [_firstWinButton addSubview:firstWinButtonRightArrow];
    [firstWinButtonRightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_firstWinButton);
        make.left.mas_equalTo(_firstWinButton.titleLabel.mas_right);
        make.height.mas_equalTo(0.24 * 0.1 * SCREEN_WIDTH);
    }];
    
    UIButton *setButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [setButon setBackgroundImage:[UIImage imageNamed:@"set_btn_normal.png"] forState:UIControlStateNormal];
    [setButon setBackgroundImage:[UIImage imageNamed:@"set_btn_press.png"] forState: UIControlStateSelected];
    setButon.backgroundColor = [UIColor clearColor];
    [setButon setTitle:@"设置" forState:UIControlStateNormal];
    setButon.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [self.scrollView addSubview:setButon];
    [setButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView).offset(40);
        make.right.mas_equalTo(_firstWinButton.mas_right);
        make.height.mas_equalTo(0.4 * 0.2 * SCREEN_WIDTH + 5);
        make.width.mas_equalTo(0.242 * 0.8 * SCREEN_WIDTH);
    }];
}
///////////////////////////////////////////////////////////////////

- (void)informationViewSetter{
    _informationView = [[UIView alloc] init];
    _informationView.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:_informationView];
    
    if (!_topImageView) {
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scrollView).offset(10);
            make.top.mas_equalTo(self.scrollView).offset(10);
            make.right.mas_equalTo(self.scrollView).offset(-10);
            make.height.mas_equalTo(0.66 * SCREEN_HEIGHT);
        }];

    }
    else{
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.top.mas_equalTo(self.topImageView.mas_bottom).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.height.mas_equalTo(0.66 * SCREEN_HEIGHT);
        }];
    }
    _zuAnView = [[UIView alloc] init];
    _zuAnView.backgroundColor = [UIColor colorWithRed:77/255.0 green:81/255.0 blue:91/255.0 alpha:1];
    [_informationView addSubview:_zuAnView];
    [_zuAnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_informationView);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(0.1 * 0.66 * SCREEN_HEIGHT);
    }];
    
    UILabel *zuAnLable = [[UILabel alloc] init];
    zuAnLable.text = @"祖安";
    zuAnLable.textColor = [UIColor whiteColor];
    zuAnLable.font = [UIFont systemFontOfSize:20];
    [_zuAnView addSubview:zuAnLable];
    [zuAnLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_zuAnView);
    }];
    
    UIImageView *doubleKnifeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_dark_region_icon.png"]];
    [_zuAnView addSubview:doubleKnifeImageView];
    [doubleKnifeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zuAnView);
        make.right.mas_equalTo(zuAnLable.mas_left).offset(-3);
        make.height.mas_equalTo(20 * 0.6);
        make.width.mas_equalTo(20 * 0.6);
    }];
    
    UIImageView *dropDownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friend_header_down@2x.png"]];
    [_zuAnView addSubview:dropDownImageView];
    [dropDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zuAnView);
        make.left.mas_equalTo(zuAnLable.mas_right).offset(3);
        make.height.mas_equalTo(20 * 0.6);
        make.width.mas_equalTo(20 * 0.6);
    }];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"person_card_share_press@2x.png"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"person_card_share_press@2x.png"] forState:UIControlStateHighlighted];
    [_zuAnView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_zuAnView).offset(-15);
        make.centerY.mas_equalTo(_zuAnView);
        make.height.mas_equalTo(20 * 0.7);
        make.width.mas_equalTo(20 * 0.6 * 1.2);
    }];
    
    //分割线
    UIImageView *dividingLine1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quiz_seperate_line@2x.png"]];
    [_zuAnView addSubview:dividingLine1];
    [dividingLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_zuAnView);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(1);
    }];

    _playerHeadBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playerHeadBotton.backgroundColor = [UIColor whiteColor];
    [_informationView addSubview:_playerHeadBotton];
    [_playerHeadBotton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_zuAnView.mas_bottom);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(0.14 * 0.66 * SCREEN_HEIGHT);
    }];
    
    _playerHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head@2x.png"]];
    [_playerHeadBotton addSubview:_playerHeadImageView];
    [_playerHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_playerHeadBotton).offset(0.056 * SCREEN_WIDTH);
        make.centerY.mas_equalTo(_playerHeadBotton);
        make.height.mas_equalTo(0.13 * SCREEN_WIDTH);
        make.width.mas_equalTo(0.13 * SCREEN_WIDTH);
    }];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friend_state_offline@2x.png"]];
    [_playerHeadBotton addSubview:dotImageView];
    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_playerHeadImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_playerHeadImageView).offset(10);
        make.height.mas_equalTo(0.2 * 0.116 * SCREEN_WIDTH);
        make.width.mas_equalTo(0.2 * 0.116 * SCREEN_WIDTH);
    }];
    
    UILabel *playerNameLable = [[UILabel alloc] init];
    playerNameLable.text = @"那家伙帅到";
    playerNameLable.font = [UIFont systemFontOfSize:14];
    [_playerHeadBotton addSubview:playerNameLable];
    [playerNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotImageView);
        make.centerY.mas_equalTo(_playerHeadImageView).offset(-10);
    }];
    
    
    NSMutableAttributedString *playerStateString = [[NSMutableAttributedString alloc] initWithString:@"游戏离线 LV3"];
    [playerStateString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 5)];
    [playerStateString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, 3)];
    UILabel *playerState = [[UILabel alloc] init];
    playerState.attributedText = playerStateString;
    playerState.font = [UIFont systemFontOfSize:13];
    [_playerHeadBotton addSubview:playerState];
    [playerState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_playerHeadImageView).offset(10);
    }];
    
    //分割线
    UIImageView *dividingLine3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quiz_seperate_line@2x.png"]];
    [_playerHeadBotton addSubview:dividingLine3];
    [dividingLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_playerHeadBotton);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(1);
    }];
    
    _gameDatabutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _gameDatabutton.backgroundColor = [UIColor colorWithRed:239/250.0 green:239/250.0 blue:239/250.0 alpha:1];
    [_informationView addSubview:_gameDatabutton];
    [_gameDatabutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_playerHeadBotton.mas_bottom);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(0.128 * SCREEN_HEIGHT);
    }];

    //两个临时的view，用于布局
    UIView *tmp1 = [[UIView alloc] init];
    tmp1.backgroundColor = [UIColor clearColor];
    [_gameDatabutton addSubview:tmp1];
    [tmp1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gameDatabutton);
        make.top.mas_equalTo(_gameDatabutton);
        make.height.mas_equalTo(0.5 * 0.128 * SCREEN_HEIGHT);
        make.width.mas_equalTo((SCREEN_WIDTH - 20)/2);
    }];
    
    UIView *tmp2 = [[UIView alloc] init];
    tmp2.backgroundColor = [UIColor clearColor];
    [_gameDatabutton addSubview:tmp2];
    [tmp2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gameDatabutton);
        make.top.mas_equalTo(tmp1.mas_bottom);
        make.height.mas_equalTo(0.5 * 0.128 * SCREEN_HEIGHT);
        make.width.mas_equalTo((SCREEN_WIDTH - 20)/2);
    }];
    
    NSMutableAttributedString *gameNumberString = [[NSMutableAttributedString alloc] initWithString:@"场数 3 胜率 100%"];
    [gameNumberString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
    [gameNumberString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, 1)];
    [gameNumberString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(5, 2)];
    [gameNumberString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(8, 4)];
    UILabel *gameNumberLable = [[UILabel alloc] init];
    gameNumberLable.attributedText = gameNumberString;
    gameNumberLable.font = [UIFont systemFontOfSize:16];
    [_gameDatabutton addSubview:gameNumberLable];
    [gameNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tmp1);
        make.left.mas_equalTo(_playerHeadImageView);
    }];
    
    NSMutableAttributedString *playGoodAtString = [[NSMutableAttributedString alloc] initWithString:@"擅长位置：未设置"];
    [playGoodAtString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
    [playGoodAtString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, 3)];
    UILabel *playGoodAtLable = [[UILabel alloc] init];
    playGoodAtLable.attributedText = playGoodAtString;
    playGoodAtLable.font = [UIFont systemFontOfSize:16];
    [_gameDatabutton addSubview:playGoodAtLable];
    [playGoodAtLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tmp2);
        make.left.mas_equalTo(_playerHeadImageView);
    }];
    
    UIImage *gameEditGoodAtImage = [UIImage imageNamed:@"player_position_edit@2x.png"];
    UIImageView *gameEditGoodAtImageView = [[UIImageView alloc] initWithImage:gameEditGoodAtImage];
    [_gameDatabutton addSubview:gameEditGoodAtImageView];
    [gameEditGoodAtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(playGoodAtLable.mas_right);
        make.centerY.mas_equalTo(playGoodAtLable);
    }];
    
    UIImageView *gameDataViewRightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_card_arrow_normal@2x.png"]];
    [_gameDatabutton addSubview:gameDataViewRightArrowImageView];
    [gameDataViewRightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_gameDatabutton);
        make.right.mas_equalTo(_gameDatabutton).offset(2);
    }];
    
    UIImage *medalImage = [UIImage imageNamed:@"stage_0@2x.png"];
    UIImageView *medalImageView = [[UIImageView alloc] initWithImage:medalImage];
    [_gameDatabutton addSubview:medalImageView];
    [medalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_gameDatabutton).offset(-10);
        make.right.mas_equalTo(gameDataViewRightArrowImageView.mas_left).offset(-20);
    }];
    
    UILabel *medalTitle = [[UILabel alloc] init];
    medalTitle.text = @"暂无段位";
    medalTitle.font = [UIFont systemFontOfSize:15];
    [_gameDatabutton addSubview:medalTitle];
    [medalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(medalImageView);
        make.top.mas_equalTo(medalImageView.mas_bottom);
    }];
    
    //分割线
    UIImageView *dividingLine2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quiz_seperate_line@2x.png"]];
    dividingLine2.backgroundColor = [UIColor whiteColor];
    [_gameDatabutton addSubview:dividingLine2];
    [dividingLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_gameDatabutton);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(1);
    }];
    
    _usuallyUseHeroView = [[UIButton alloc] init];
    _usuallyUseHeroView.backgroundColor = [UIColor colorWithRed:239/250.0 green:239/250.0 blue:239/250.0 alpha:1];
    [_informationView addSubview:_usuallyUseHeroView];
    [_usuallyUseHeroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_gameDatabutton.mas_bottom);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(0.135 * SCREEN_HEIGHT);
    }];
    
    UIView *tmpViewForUsuallyHeroView1 = [[UIView alloc] init];
    [_usuallyUseHeroView addSubview:tmpViewForUsuallyHeroView1];
    [tmpViewForUsuallyHeroView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_usuallyUseHeroView);
        make.top.mas_equalTo(_usuallyUseHeroView);
        make.right.mas_equalTo(_usuallyUseHeroView);
        make.height.mas_equalTo(0.135 * SCREEN_HEIGHT * 0.4);
    }];
    
    UILabel *usuallyUseHeroLable = [[UILabel alloc] init];
    usuallyUseHeroLable.text = @"常用英雄:";
    [_usuallyUseHeroView addSubview:usuallyUseHeroLable];
    [usuallyUseHeroLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_playerHeadImageView);
        make.centerY.mas_equalTo(tmpViewForUsuallyHeroView1);
    }];
    
    UIView *tmpViewForUsuallyHeroView2 = [[UIView alloc] init];
    [_usuallyUseHeroView addSubview:tmpViewForUsuallyHeroView2];
    [tmpViewForUsuallyHeroView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_usuallyUseHeroView);
        make.top.mas_equalTo(tmpViewForUsuallyHeroView1.mas_bottom);
        make.right.mas_equalTo(_usuallyUseHeroView);
        make.height.mas_equalTo(0.135 * SCREEN_HEIGHT * 0.4);
    }];
    
    UILabel *usuallyUseHeroDataLable = [[UILabel alloc] init];
    usuallyUseHeroDataLable.text = @"暂无常用英雄";
    usuallyUseHeroDataLable.textColor = [UIColor darkGrayColor];
    usuallyUseHeroDataLable.font = [UIFont systemFontOfSize:25];
    [_usuallyUseHeroView addSubview:usuallyUseHeroDataLable];
    [usuallyUseHeroDataLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(tmpViewForUsuallyHeroView2);
    }];
    
    //分割线
    UIImageView *dividingLine4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quiz_seperate_line@2x.png"]];
    dividingLine4.backgroundColor = [UIColor whiteColor];
    [_usuallyUseHeroView addSubview:dividingLine4];
    [dividingLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_usuallyUseHeroView);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(1);
    }];
    
    _recentlyRecordView = [[UIView alloc] init];
    _recentlyRecordView.backgroundColor = [UIColor whiteColor];
    [_informationView addSubview:_recentlyRecordView];
    [_recentlyRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_usuallyUseHeroView.mas_bottom);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(0.09 * SCREEN_HEIGHT);
    }];
    
    UILabel *recentlyRecordLable = [[UILabel alloc] init];
    recentlyRecordLable.text = @"最近战绩";
    recentlyRecordLable.font = [UIFont systemFontOfSize:20];
    [_recentlyRecordView addSubview:recentlyRecordLable];
    [recentlyRecordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_playerHeadImageView);
        make.centerY.mas_equalTo(_recentlyRecordView);
    }];
    
    //分割线
    UIImageView *dividingLine5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quiz_seperate_line@2x.png"]];
    dividingLine5.backgroundColor = [UIColor whiteColor];
    [_usuallyUseHeroView addSubview:dividingLine5];
    [dividingLine5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_recentlyRecordView);
        make.right.mas_equalTo(_informationView);
        make.height.mas_equalTo(1);
    }];
    
    _recentlyRecordDataView = [[UIView alloc] init];
    _recentlyRecordDataView.backgroundColor = [UIColor colorWithRed:239/250.0 green:239/250.0 blue:239/250.0 alpha:1];
    [_informationView addSubview:_recentlyRecordDataView];
    [_recentlyRecordDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informationView);
        make.top.mas_equalTo(_recentlyRecordView.mas_bottom);
        make.right.mas_equalTo(_informationView);
        make.bottom.mas_equalTo(_informationView);
    }];
    
    UILabel *recentlyRecordDataLable = [[UILabel alloc] init];
    recentlyRecordDataLable.text = @"最近3个月都没有查到你的数据哦，赶快去打一局游戏吧!";
    recentlyRecordDataLable.textAlignment = NSTextAlignmentCenter;
    recentlyRecordDataLable.lineBreakMode = NSLineBreakByWordWrapping;
    recentlyRecordDataLable.numberOfLines = 0;
    recentlyRecordDataLable.textColor = [UIColor darkGrayColor];
    [_recentlyRecordDataView addSubview:recentlyRecordDataLable];
    [recentlyRecordDataLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_recentlyRecordDataView);
        make.width.mas_equalTo(0.66 * SCREEN_WIDTH);
    }];
}

- (void)firstButtonAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - reWrite the getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _scrollView;
}

@end
