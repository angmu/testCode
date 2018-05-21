//
//  SecondViewController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ThridViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    // 自定义返回按钮
    [self setNavBackBtn];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    // 添加按钮
    [self addBtn];
}



// 隐藏导航栏
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//// 消失时还原，否则都没有
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//}


- (void)addBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
}


- (void)btnPress
{
    ThridViewController *thrid = [[ThridViewController alloc] init];
    [self.navigationController pushViewController:thrid animated:YES];
}

- (void)setNavBackBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50, 50);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
