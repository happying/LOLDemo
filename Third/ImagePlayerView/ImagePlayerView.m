//
//  ImagePlayerView.m
//  ImagePlayerView
//
//  Created by 陈颜俊 on 14-6-5.
//  Copyright (c) 2014年 Chenyanjun. All rights reserved.
//

#import "ImagePlayerView.h"
#import "Masonry.h"
#import "SMPageControl.h"

#define kStartTag   1000
#define kDefaultScrollInterval  2

@interface ImagePlayerView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic, strong) SMPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageControlConstraints;
@property (nonatomic, strong) NSMutableArray *scrollViewConstraints;
@property (nonatomic, strong) NSMutableArray *newsTitles; //自己添加的，用于记录广告语的数组
@property (nonatomic, strong) UILabel *newsLable; //自己添加的，用于在广告条中显示广告
@end

@implementation ImagePlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithDelegate:(id<ImagePlayerViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.imagePlayerViewDelegate = delegate;
        [self _init];
    }
    return self;
}

- (void)_init
{
    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.scrollViewConstraints = [NSMutableArray array];
    
    self.scrollInterval = kDefaultScrollInterval;
    
    // scrollview
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self addSubview:self.scrollView];
    }
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    self.scrollView.delegate = self;
    
    

    
    //
//    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|"
//                                                                               options:kNilOptions
//                                                                               metrics:nil
//                                                                                 views:@{@"pageControl": self.pageControl}];
//    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
//                                                                               options:kNilOptions
//                                                                               metrics:nil
//                                                                                 views:@{@"pageControl": self.pageControl}];
//    self.pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
//    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
//    [self addConstraints:self.pageControlConstraints];

    self.edgeInsets = UIEdgeInsetsZero;
    
    [self reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bounds"]) {
        [self reloadData];
    }
}

- (void)reloadData
{
    // remove subview from scrollview first
    for (UIView *subView in self.scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    self.count = [self.imagePlayerViewDelegate numberOfItems];
    
    //构建的临时方法用于设置广告语，将来应该暴露除一个set方法
    _newsTitles = [[NSMutableArray alloc] init];
    for (int num = 0; num < self.count; num++) {
        NSString *tmp = [NSString stringWithFormat:@"第%d个广告语言",num];
        [_newsTitles addObject:tmp];
    }
    
    if (self.count == 0) {
        return;
    }
    
    CGFloat width = self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat height = self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
    
    //这里要在原有的基础上增加一个imageview以实现循环滚动
//    for (int i = 0; i < self.count; i++) {
    for (int i = 0; i <= self.count; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = kStartTag + i;
        imageView.userInteractionEnabled = YES;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        [self.scrollView addSubview:imageView];
        
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
        //这里将原有的添加图片多加了一个判断，在最后面添加一个图片，和第一张一样，再在后面关闭跳转动画，以实现循环滚动。
//        [self.imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:i];

        if (i < self.count) {
            [self.imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:i];
        } else {
            [self.imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:0];
        }
    }
    
    // constraint
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *imageViewNames = [NSMutableArray array];
    //由于上面添加图片的时候多了一个，这里相应也应该多一个
//    for (int i = kStartTag; i < kStartTag + self.count; i++) {
    for (int i = kStartTag; i <= kStartTag + self.count; i++) {
        if (i < kStartTag + self.count) {
            NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i - kStartTag];
            [imageViewNames addObject:imageViewName];
            
            UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i];
            [viewsDictionary setObject:imageView forKey:imageViewName];
        } else {
            NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i - kStartTag];
            [imageViewNames addObject:imageViewName];
            
            UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i];
            [viewsDictionary setObject:imageView forKey:imageViewName];
        }
        
    }
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", [imageViewNames objectAtIndex:0]]
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    NSMutableString *hConstraintString = [NSMutableString string];
    [hConstraintString appendString:@"H:|-0"];
    for (NSString *imageViewName in imageViewNames) {
        [hConstraintString appendFormat:@"-[%@]-0", imageViewName];
    }
    [hConstraintString appendString:@"-|"];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hConstraintString
                                                                            options:NSLayoutFormatAlignAllTop
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.count, self.scrollView.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
    //这里在下方增加了一个黑色条带
    UIView *titleBack = [[UIView alloc] init];
    titleBack.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    [self.scrollView addSubview:titleBack];
    [titleBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.scrollView);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(26);
    }];
    
    // UIPageControl 这里将原来在_init的关于UIPageControl搬到这里，以规避那些原有的自动布局
    if (!self.pageControl) {
        self.pageControl = [[SMPageControl alloc] init];
    }
    [self.pageControl setPageIndicatorImage:[UIImage imageNamed:@"list_news_tab_image_background@2x"]];
    [self.pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"list_news_tab_image_select@2x.png"]];
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.userInteractionEnabled = YES;
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.numberOfPages = self.count;
    self.pageControl.currentPage = 0;
//    [self.pageControl addTarget:self action:@selector(handleClickPageControl:) forControlEvents:UIControlEventTouchUpInside];
    [titleBack addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.scrollView);
        make.right.equalTo(self).offset(230);
        make.top.equalTo(titleBack);
    }];
    
    //这里添加广告语lable
    _newsLable = [[UILabel alloc] init];
    [titleBack addSubview:_newsLable];
    _newsLable.text = [_newsTitles objectAtIndex:0];
    [_newsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(titleBack);
        make.height.mas_equalTo(titleBack);
    }];

}

#pragma mark - actions
- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture
{
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag - kStartTag;
    
    if (self.imagePlayerViewDelegate && [self.imagePlayerViewDelegate respondsToSelector:@selector(imagePlayerView:didTapAtIndex:)]) {
        [self.imagePlayerViewDelegate imagePlayerView:self didTapAtIndex:index];
    }
}

//- (void)handleClickPageControl:(UIPageControl *)sender
//{
//    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
//        [self.autoScrollTimer invalidate];
//    }
//    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
//    
//    UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:(sender.currentPage + kStartTag)];
//    [self.scrollView scrollRectToVisible:imageView.frame animated:YES];
//}

#pragma mark - auto scroll
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        if (!self.autoScrollTimer || !self.autoScrollTimer.isValid) {
            self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
        }
    } else {
        if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
            [self.autoScrollTimer invalidate];
            self.autoScrollTimer = nil;
        }
    }
}

- (void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval = scrollInterval;
    
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
    
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
}

- (void)handleScrollTimer:(NSTimer *)timer
{
    if (self.count == 0) {
        return;
    }
    
    NSInteger currentPage = self.pageControl.currentPage;
    NSInteger nextPage = currentPage + 1;
    if (nextPage == self.count) {
        nextPage = 0;
    }
    
    BOOL animated = YES;
    if (nextPage == 0) {
        animated = NO;
    }
    
    UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:(nextPage + kStartTag)];
    [self.scrollView scrollRectToVisible:imageView.frame animated:animated];
     _newsLable.text = [_newsTitles objectAtIndex:nextPage];
    
    self.pageControl.currentPage = nextPage;
}

#pragma mark - scroll delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // disable v direction scroll
    if (scrollView.contentOffset.y > 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // when user scrolls manually, stop timer and start timer again to avoid next scroll immediatelly
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
    }
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
    
    // update UIPageControl
    CGRect visiableRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.bounds.size.width, scrollView.bounds.size.height);
    NSInteger currentIndex = 0;
    for (UIImageView *imageView in scrollView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            if (CGRectContainsRect(visiableRect, imageView.frame)) {
                currentIndex = imageView.tag - kStartTag;
                break;
            }
        }
    }
    //加一段代码以更新广告语
    
    if (currentIndex < self.count) {
         _newsLable.text = [_newsTitles objectAtIndex:currentIndex];
    }
    
    self.pageControl.currentPage = currentIndex;
    
    //这里多加一个判断，以实现末尾跳转
    if (1200 - scrollView.contentOffset.x  <=0.01) {
        CGPoint point=scrollView.contentOffset;
        NSLog(@"%f,%f",point.x,point.y);
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.pageControl.currentPage = 0;
        //跳转后，将广告语设为第一条
        _newsLable.text = [_newsTitles objectAtIndex:0];
        
    }
}

#pragma mark - settings
- (void)setPageControlPosition:(ICPageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case ICPageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ICPageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case ICPageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ICPageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        default:
            break;
    }
    
    [self removeConstraints:self.pageControlConstraints];
    
//    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
//                                                                               options:kNilOptions
//                                                                               metrics:nil
//                                                                                 views:@{@"pageControl": self.pageControl}];
//    
//    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
//                                                                               options:kNilOptions
//                                                                               metrics:nil
//                                                                                 views:@{@"pageControl": self.pageControl}];
//    
//    [self.pageControlConstraints removeAllObjects];
//    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
//    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
//    [self addConstraints:self.pageControlConstraints];
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    
    [self removeConstraints:self.scrollViewConstraints];
    
    NSArray *scrollViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[scrollView]-bottom-|"
                                                                              options:kNilOptions
                                                                              metrics:@{@"top": @(self.edgeInsets.top),
                                                                                        @"bottom": @(self.edgeInsets.bottom)}
                                                                                views:@{@"scrollView": self.scrollView}];
    NSArray *scrollViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[scrollView]-right-|"
                                                                              options:kNilOptions
                                                                              metrics:@{@"left": @(self.edgeInsets.left),
                                                                                        @"right": @(self.edgeInsets.right)}
                                                                                views:@{@"scrollView": self.scrollView}];
    
    [self.scrollViewConstraints removeAllObjects];
    [self.scrollViewConstraints addObjectsFromArray:scrollViewHConstraints];
    [self.scrollViewConstraints addObjectsFromArray:scrollViewVConstraints];
    
    [self addConstraints:self.scrollViewConstraints];
    
    // update imageview constraints
    CGFloat width = self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat height = self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
    
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)subView;
            for (NSLayoutConstraint *constraint in imageView.constraints) {
                if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = width;
                } else if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                    constraint.constant = height;
                }
            }
        }
    }
}

- (void)stopTimer
{
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
}

#pragma mark - deprecated methods
// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:edgeInsets];
}

// @deprecated implement ImagePlayerViewDelegate
- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

// @deprecated implement ImagePlayerViewDelegate
- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    self.count = count;
    self.imagePlayerViewDelegate = delegate;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[scrollView]-%d-|", (int)edgeInsets.top, (int)edgeInsets.bottom]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": self.scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%d-[scrollView]-%d-|", (int)edgeInsets.left, (int)edgeInsets.right]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": self.scrollView}]];
    
    if (count == 0) {
        return;
    }
    
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = 0;
    
    CGFloat startX = self.scrollView.bounds.origin.x;
    CGFloat width = self.bounds.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat height = self.bounds.size.height - edgeInsets.top - edgeInsets.bottom;
    
    for (int i = 0; i < count; i++) {
        startX = i * width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = kStartTag + i;
        imageView.userInteractionEnabled = YES;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
        
        [self.imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:i];
        
        [self.scrollView addSubview:imageView];
    }
    
    // constraint
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *imageViewNames = [NSMutableArray array];
    for (int i = kStartTag; i < kStartTag + count; i++) {
        NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i - kStartTag];
        [imageViewNames addObject:imageViewName];
        
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i];
        [viewsDictionary setObject:imageView forKey:imageViewName];
    }
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", [imageViewNames objectAtIndex:0]]
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    NSMutableString *hConstraintString = [NSMutableString string];
    [hConstraintString appendString:@"H:|-0"];
    for (NSString *imageViewName in imageViewNames) {
        [hConstraintString appendFormat:@"-[%@]-0", imageViewName];
    }
    [hConstraintString appendString:@"-|"];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hConstraintString
                                                                            options:NSLayoutFormatAlignAllTop
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * count, self.scrollView.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
}
@end
