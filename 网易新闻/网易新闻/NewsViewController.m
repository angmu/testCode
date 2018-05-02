//
//  NewsViewController.m
//  网易新闻
//
//  Created by MGBook on 2018/5/2.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "NewsViewController.h"

static CGFloat const labelW = 100;

@interface NewsViewController ()
/// 选中的Label
@property (nonatomic, weak) UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *containView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
    
    // 头条 热点 视频 社会 阅读 科技
    [self setupAllViewController];
    [self setupHeaderTitle];
    
    [self setupScrollView];
}


/**
 初始化ScrollView
 */
- (void)setupScrollView
{
    // 标题ScrollView
    NSUInteger count = self.childViewControllers.count;
    self.titleScrollView.contentSize = CGSizeMake(labelW * count, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 内容ScrollView
    self.containView.contentSize = CGSizeMake(count * kScreenWidth, 0);
    self.containView.showsHorizontalScrollIndicator = NO;
    self.containView.pagingEnabled = YES;
}

/**
 所有标题文字
 */
- (void)setupHeaderTitle
{
    NSUInteger count = self.childViewControllers.count;
    
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UILabel *label = [[UILabel alloc] init];
        
        CGFloat labelX = i * labelW;
        label.frame =CGRectMake(labelX, 0, labelW, 44);
        label.text = vc.title;
        label.textAlignment = NSTextAlignmentCenter;

        label.textColor = [UIColor blackColor];
        label.highlightedTextColor = [UIColor redColor];
        label.tag = i;
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidClick:)];
        [label addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:label];
        
        // 默认选中第一个
        if (i == 0) {
            [self selectLabel:label];
        }
    }
}


/**
 点击标题
 */
- (void)titleDidClick:(UITapGestureRecognizer *)tap
{
    // label文字变红色
    UILabel *label = (UILabel *)tap.view;
    [self selectLabel:label];
    
    // 滚到对应的位置
    NSInteger index = label.tag;
    CGFloat offsetX = index * kScreenWidth;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.containView setContentOffset:offset animated:NO];
    
    // 在对应位置添加子控制器
    UIViewController *vc = self.childViewControllers[index];
    // 设置尺寸
    vc.view.frame = self.containView.bounds;
    vc.view.left = offsetX;
    vc.view.backgroundColor = kRandomColor;
    [self.containView addSubview:vc.view];
}


/**
 选中Label
 */
- (void)selectLabel:(UILabel *)label
{
    _selectLabel.highlighted = NO;
    label.highlighted = YES;
    _selectLabel = label;
}

/**
 初始化所有子控制器
 */
- (void)setupAllViewController
{
    // 头条
    UIViewController *topic = [[UIViewController alloc] init];
    topic.title = @"头条";
    [self addChildViewController:topic];
    
    // 热点
    UIViewController *hot = [[UIViewController alloc] init];
    hot.title = @"热点";
    [self addChildViewController:hot];
    
    // 视频
    UIViewController *vedio = [[UIViewController alloc] init];
    vedio.title = @"视频";
    [self addChildViewController:vedio];
    
    // 社会
    UIViewController *society = [[UIViewController alloc] init];
    society.title = @"社会";
    [self addChildViewController:society];
    
    // 阅读
    UIViewController *read = [[UIViewController alloc] init];
    read.title = @"阅读";
    [self addChildViewController:read];
    
    // 科技
    UIViewController *science = [[UIViewController alloc] init];
    science.title = @"科技";
    [self addChildViewController:science];
}

@end
