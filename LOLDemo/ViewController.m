//
//  ViewController.m
//  LOLDemo
//
//  Created by yufu on 15/1/21.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "NewsTableViewController.h"
#import "contentsViewController.h"

@interface ViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic) NSUInteger numberOfTabs;
@property (strong, nonatomic) NewsTableViewController *testviewController;
@property (strong, nonatomic) contentsViewController *contentViewController;
@property (nonatomic, readwrite)BOOL ifTabChange;

@end

@implementation ViewController

- (NSMutableArray *)tabsArray{
    if (!_tabsArray) {
        _tabsArray = [NSMutableArray arrayWithArray:[self setContentForTabs]];
    }
    return _tabsArray;
}

- (NSArray*)setContentForTabs{
    NSArray *tmpArray = @[@"最新", @"活动", @"赛事", @"视频", @"官方", @"美女", @"搞笑", @"攻略"];
    return tmpArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = self;
    self.delegate = self;
    self.ifTabChange = TRUE;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setContentForTabs];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:0.0];
}

- (void)loadContent{
    self.numberOfTabs = 8;
}

- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    // Reload data
    [self reloadData];
}


//data source
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    return self.numberOfTabs;
}

- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:5];
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    
     NSArray *tmpArray = self.tabsArray;

        UILabel *tabsLable = [UILabel new];
        tabsLable.backgroundColor = [UIColor clearColor];
        tabsLable.textColor = [UIColor blackColor];
        tabsLable.text = tmpArray[index];
        tabsLable.font = [UIFont boldSystemFontOfSize:15];
        [tabsLable sizeToFit];
        return tabsLable;
}

-(void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index fromIndex:(NSUInteger)previousIndex{
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
//    _testviewController = [[NewsTableViewController alloc] init];
    _contentViewController = [[contentsViewController alloc] init];
    return _contentViewController;
    
}


#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 45.0;
        case ViewPagerOptionTabOffset:
            return 4.0;
        case ViewPagerOptionTabWidth:
            return 70.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 0.0;
        default:
            return value;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [UIColor clearColor];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
