//
//  MGPageScrollView.m
//  MGScrollViewDemo
//
//  Created by 穆良 on 16/6/21.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPageScrollView.h"

#define kPageControlHeight 37
#define kPageControlEachWidth 16
#define kDefaultInterval 2.0

@interface MGPageScrollView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView  *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *currentImageView;
@property (nonatomic, weak) UIImageView *rightImageView;

@property (nonatomic, strong) NSTimer *timer;

/** 切换的时间间隔 */
- (NSTimeInterval)pagingInterval;
@end

@implementation MGPageScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)awakeFromNib
{
    // 初始化
    [self initial];
}

#pragma mark - 初始化
- (void)initial
{
    // 初始化scrollView
    [self setupScrollView];
    // 初始化imageView
    [self setupImageView];
}

/**
 *  初始化scrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    _scrollView = scrollView;
    [self addSubview:scrollView];
    
    // scrollView属性
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO; // 循环滚动,没有bounds属性

    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    [self addSubview:pageControl];
    
    // pageControl属性
    [pageControl setValue:[UIImage imageNamed:@"activeImage"] forKey:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"inactiveImage"] forKey:@"_pageImage"];
    
    
}

/**
 *  初始化子控件
 */
- (void)setupImageView
{
    UIImageView *leftImageView    = [[UIImageView alloc] init];
    UIImageView *currentImageView = [[UIImageView alloc] init];
    UIImageView *rightImageView   = [[UIImageView alloc] init];
    _leftImageView    = leftImageView;
    _currentImageView = currentImageView;
    _rightImageView   = rightImageView;
    [self.scrollView addSubview:leftImageView];
    [self.scrollView addSubview:currentImageView];
    [self.scrollView addSubview:rightImageView];

    // currentImageView始终显示在中间,为它添加事件
    [self.currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
    self.currentImageView.userInteractionEnabled = YES;
}

/**
 *  点击图片
 */
- (void)tapImageView:(UITapGestureRecognizer *)recognizer
{
    // 调用代理方法做事情
//    NSLog(@"%s", __func__);
    UIImageView *selImageView = (UIImageView *)recognizer.view;
    if (_clickImageAction) {
        
        self.clickImageAction(selImageView.tag);
    }
}

#pragma mark - 布局调整控件的frame
- (void)layoutSubviews
{
    // 这里得到self.frame才是真实的尺寸
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    // 设置imageView的frame
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height;
    
    self.leftImageView.frame = CGRectMake(0, 0, imageW, imageH);
    self.currentImageView.frame = CGRectMake(imageW, 0, imageW, imageH);
    self.rightImageView.frame = CGRectMake(imageW * 2, 0, imageW, imageH);
    
    // 设置imageView的内容尺寸
    self.scrollView.contentSize = CGSizeMake(imageW * 3, imageH);
    
    // 调整pageControl的frame
    [self setPageControlPosition];
    
    // 更新显示中间图片 - 悄无声息的改变
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
}

/**
 *  更新pageControl位置
 */
- (void)setPageControlPosition
{
    // pegaControl只需要设置中心点即可，width自动调整??
    CGFloat centerX = 0;
    CGFloat centerY = 0;
    
    if (MGPageControlPositionCenter == self.pageControlPostion) {
        centerX = self.frame.size.width * 0.5;
    } else if (MGPageControlPositionRight == self.pageControlPostion) {
        
        centerX = self.frame.size.width - self.images.count * kPageControlEachWidth * 0.5;
    }
    centerY = self.frame.size.height - kPageControlHeight / 4;
    self.pageControl.center = CGPointMake(centerX, centerY);
}

#pragma mark - 设置图片数据
- (void)setImages:(NSArray *)images
{
    _images = images;
    // 没有图片
    if (images.count < 1) return;
    
    // 默认设置
    self.currentImageView.image = images[0];
    self.currentImageView.tag = 0;
    
    // 图片数量为1,不能滚动
    self.scrollView.scrollEnabled = !(self.images.count == 1);
    
    // 小于等于一张就不设置左右图片
    if (images.count > 1) {
        self.leftImageView.image = images[images.count - 1]; // 最后一张图片
        self.rightImageView.image = images[1];
        self.leftImageView.tag = images.count - 1;
        self.rightImageView.tag = 1;
    }
    
    // 设置页码
    self.pageControl.numberOfPages = images.count;
    
    // 开启定时器，放在初始化方法中，开始不起作用,
    // 放在layoutSubviews方法中，就算timer销毁还是会调用
    [self addTimer];
}

#pragma mark - 更改数据，移动imageView
/**
 *  更新tag和图片
 */
- (void)updateContent
{
    if (self.images.count <= 1) return;
    
    CGFloat imageW = self.scrollView.bounds.size.width;
    
    // 1.设置tag更新图片
    if (self.scrollView.contentOffset.x > imageW) { // 向后滚
        // 先设置左边的tag为当前图片tag后，才改变当前图片tag
        self.leftImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.rightImageView.tag;
        self.rightImageView.tag = (self.rightImageView.tag + 1) % self.images.count;
        
    } else if (self.scrollView.contentOffset.x < imageW) { // 向前滚
        
        self.rightImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.leftImageView.tag;
        self.leftImageView.tag = (self.leftImageView.tag - 1 + self.images.count) % self.images.count;
    }
    
    // 更新图片
    self.leftImageView.image = self.images[self.leftImageView.tag];
    self.currentImageView.image = self.images[self.currentImageView.tag];
    self.rightImageView.image = self.images[self.rightImageView.tag];
    
    // 2.滚动到中间,不设置动画
    [self.scrollView setContentOffset:CGPointMake(imageW, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
/**
 *  随时监听scrollView的滚动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.images.count <= 1) return;
    
    // 设置UIPageControl的页码
    if (self.scrollView.contentOffset.x > self.scrollView.bounds.size.width * 1.5) {
        self.pageControl.currentPage = self.rightImageView.tag;
    } else if (self.scrollView.contentOffset.x < self.scrollView.bounds.size.width * 0.5) {
        self.pageControl.currentPage = self.leftImageView.tag;
    } else {
        self.pageControl.currentPage = self.currentImageView.tag;
    }
}

/**
 *  定时器切换更改内容
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //
    [self updateContent];
//    LxDBAnyVar(@"EndScrollingAnimation");
}

/**
 *  减速完成,马上进行更新
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
//    LxDBAnyVar(@"EndDecelerating");
}

/**
 *  开始拖拽
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  停止拖拽
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

#pragma mark - 定时器
- (void)addTimer
{
    if (self.images.count <= 1) return;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.pagingInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    _timer = timer;
    
    // 把timer加到runloop
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    // 防止layoutSubviews中，第一次偏移量还没更改时就执行
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * 2, 0) animated:YES];
}

- (NSTimeInterval)pagingInterval
{
    if (self.autoScrollTimeInterval) {
        return self.autoScrollTimeInterval;
    } else {
        return kDefaultInterval;
    }
}

#pragma mark - 实时更新
- (void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

- (void)setOtherPageColor:(UIColor *)otherPageColor
{
    _otherPageColor = otherPageColor;
    self.pageControl.pageIndicatorTintColor = otherPageColor;
}

- (void)setPageControlPostion:(MGPageControlPosition)pageControlPostion
{
    _pageControlPostion = pageControlPostion;
    [self setNeedsLayout];
}

@end
