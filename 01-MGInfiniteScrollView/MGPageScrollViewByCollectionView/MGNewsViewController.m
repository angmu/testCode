//
//  MGNewsViewController.m
//  MGScrollViewDemo
//
//  Created by 穆良 on 16/6/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGNewsViewController.h"
#import "MGNews.h"
#import "MGNewsCell.h"
#import "MJExtension.h"

#define MAXSECTIONS 100

@interface MGNewsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** 所有数据 */
@property (nonatomic, strong) NSArray *newses;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** pageControl */
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@end

@implementation MGNewsViewController

static NSString *const ID = @"news";

- (NSArray *)newses
{
    if (!_newses) {
        _newses = [MGNews objectArrayWithFilename:@"newses.plist"];
        self.pageControl.numberOfPages = self.newses.count;
    }
//    LxDBAnyVar(_newses);
    return _newses;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGNewsCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    // 默认显示中间哪一组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:MAXSECTIONS/2] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:NSFileTypeSymbolicLink];

//    LxDBAnyVar([[self.collectionView indexPathsForVisibleItems] lastObject]);
//    LxDBAnyVar(self.collectionView.frame);
    // 设置定时器
    [self addTimer];
    
    // 添加pageControl
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:MAXSECTIONS/2] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:NSFileTypeSymbolicLink];
}


#pragma mark - NSTimer
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPath) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil; // 清空
}

- (void)nextPath
{
    // 1.当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 2.计算下一个indexPath
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    if (nextItem == self.newses.count) {
        
        nextItem = 0;
        nextSection++;
    }
    
    if (nextSection == MAXSECTIONS) {
        nextSection = MAXSECTIONS/2;
        // 不要动画滚到中间去
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        return;
    }
    
    // 3.设置页码
//    self.pageControl.currentPage = nextItem;
    
    // 4.动画滚动到下一页
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
//    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.collectionView.frame.size.width, 0) animated:YES];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LxDBAnyVar(self.collectionView.frame);
    });
    
    LxDBAnyVar([NSIndexPath indexPathForRow:nextItem inSection:nextSection]);
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MAXSECTIONS;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGNewsCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.news = self.newses[indexPath.item];

    return cell;
}

#pragma mark - collectionViewDelegate
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/** 当用户停止拖拽时调用 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

/**
 *  时刻监听scrollView的滚动，设置pageControl
 *  pageControl只在定时器方法里改变
 *  定时器方法里pageControl可以去掉
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 看那个家伙占上风
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
    self.pageControl.currentPage = page;
}


@end
