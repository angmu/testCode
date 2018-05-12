//
//  ScrollViewController.m
//  testWindow
//
//  Created by MGBook on 2018/5/7.
//  Copyright © 2018年 MGBook. All rights reserved.
//

// ScrollView的本质
#import "ScrollViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ScrollViewController ()
@property (nonatomic, strong) UIView *scrollView;
@end


@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
}


- (void)setupScrollView
{
    UIView *scrollView = [[UIView alloc] init];
    _scrollView = scrollView;
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    UISwitch *sw = [[UISwitch alloc] init];
    sw.center = self.view.center;
    [scrollView addSubview:sw];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [scrollView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    UIView *scrollView = pan.view;
    // 获取手指偏移量
    CGPoint transPoint = [pan translationInView:pan.view];
    
    // 滚动范围
    CGRect bounds = scrollView.bounds;
    bounds.origin.y -= transPoint.y;
    
    // 限制范围
    CGFloat viewY = bounds.origin.y;
    if (viewY < 0) {
        viewY = 0;
    } else if (viewY > kScreenHeight * 0.5) {
        viewY = kScreenHeight * 0.5;
    }
    
    CGRect viewBounds = scrollView.bounds;
    viewBounds.origin.y = viewY;
    scrollView.bounds = viewBounds;
    
    // 复位 还原
    [pan setTranslation:CGPointZero inView:pan.view];
}


@end
