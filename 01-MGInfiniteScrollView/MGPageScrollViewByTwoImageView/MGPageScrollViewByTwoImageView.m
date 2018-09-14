//
//  MGPageScrollViewByTwoImageView.m
//  MGInfiniteScrollView
//
//  Created by 穆良 on 16/6/21.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPageScrollViewByTwoImageView.h"

@interface MGPageScrollViewByTwoImageView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
/** 当前显示的view */
@property (nonatomic, weak) UIImageView *currentImageView;
/** 备份的view（左右滑动时，显示的view） */
@property (nonatomic, weak) UIImageView *backupImageView;
@end


@implementation MGPageScrollViewByTwoImageView

#pragma mark - 初始化
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
    [self initial];
}

/**
 *  初始化控件
 */
- (void)initial
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    _scrollView = scrollView;
    [self addSubview:scrollView];
    // 设置scrollView的属性
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    // 创建imageView
    UIImageView *currentImageView = [[UIImageView alloc] init];
    _currentImageView = currentImageView;
    [self.scrollView addSubview:currentImageView];
    
    UIImageView *backupImageView = [[UIImageView alloc] init];
    _backupImageView = backupImageView;
    [self.scrollView addSubview:backupImageView];
}


#pragma mark - 布局子控件
- (void)layoutSubviews
{
    self.scrollView.frame = self.bounds;
    
    CGFloat imageViewW = self.scrollView.bounds.size.width;
    CGFloat imageViewH = self.scrollView.bounds.size.height;
    // 设置scrollView的contenSize
    self.scrollView.contentSize = CGSizeMake(imageViewW * 3, 0);
    
    // 设置2个imageView的frame
    self.currentImageView.frame = CGRectMake(imageViewW, 0, imageViewW, imageViewH);
    self.backupImageView.frame = CGRectMake(imageViewW * 2, 0, imageViewW, imageViewH);
    
    // 更换图片改变,只能放在这里
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
}

#pragma mark - 获得图片数据
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 设置imageView数据
    self.currentImageView.image = images[0];
    self.backupImageView.image = images[1];
    
    // 设置imageView的tag为图片下标
    self.currentImageView.tag = 0;
    self.backupImageView.tag = 1;
}

#pragma mark - 随时调整其位置
/**
 *  currentImageView的位置和图片是标准的
 *  根据中间图片，设置backupImageView的尺寸和image、tag
 */
- (void)updateBackupImageView
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height;
    NSInteger imageCount = self.images.count;
    
    // 根据偏移量，设置backView的图片，并修改其图片下标
    if (offsetX < imageW) { // 往前滚动
        self.backupImageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.backupImageView.tag = (self.currentImageView.tag - 1 + imageCount) % imageCount;
        self.backupImageView.image = self.images[self.backupImageView.tag];
    } else if (offsetX > imageW) { // 往后滚动
        self.backupImageView.frame = CGRectMake(self.bounds.size.width * 2, 0, imageW, imageH);
        self.backupImageView.tag = (self.currentImageView.tag + 1) % imageCount;
        self.backupImageView.image = self.images[self.backupImageView.tag];
    }
}

- (void)setupContent
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    CGFloat imageW = self.bounds.size.width;
    
    // 实际上没有换页，就返回
    if (offsetX < imageW * 1.5 && offsetX > imageW * 0.5) {
        return;
    }
    
    // 根据backImageView的image,来进行图片更换 -只更换中间图片
    self.currentImageView.image = self.backupImageView.image;
    // 设置当前图片下标
    self.currentImageView.tag = self.backupImageView.tag;
    
    // 停止时，设置偏移量为currentView所在位置
    self.scrollView.contentOffset = CGPointMake(imageW, 0);
}

#pragma mark - UIScrollViewDelegate
/**
 *  实时监听,调整backupImageView的frame
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateBackupImageView];
}

/**
 *  手动拖拽,减速完成
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 马上更换图片,移动到中间
    [self setupContent];
}
@end
