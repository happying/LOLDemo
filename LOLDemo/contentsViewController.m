//
//  contentsViewController.m
//  LOLDemo
//
//  Created by yufu on 15/2/12.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "contentsViewController.h"
#import "Masonry.h"

@interface contentsViewController ()<ImagePlayerViewDelegate>
@property (nonatomic,strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *imageURLs;

@end
@implementation contentsViewController

- (NSString *)lableString{
    if (!_lableString) {
        _lableString = @"没有内容";
    }
    _testLable.text = _lableString;
    return _lableString;
}


- (UILabel *)testLable{
    if (!_testLable) {
        _testLable = [[UILabel alloc] init];
    }
    return _testLable;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    
    
    //CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.newsContentImagePlayer = [[ImagePlayerView alloc] init];
    self.newsContentImagePlayer.imagePlayerViewDelegate = self;
    self.newsContentImagePlayer.scrollInterval = 5.0f;
    self.newsContentImagePlayer.pageControlPosition = ICPageControlPosition_BottomRight;
    self.newsContentImagePlayer.hidePageControl = NO;
    //self.newsContentImagePlayer.edgeInsets = UIEdgeInsetsMake(0, 0, screenWidth, 200);
//    self.newsContentImagePlayer.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.newsContentImagePlayer];

    [_newsContentImagePlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(165);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index{
    imageView.image = [self.imagesArray objectAtIndex:index];
}

-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index{
    
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
