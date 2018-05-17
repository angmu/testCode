//
//  SecondViewController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    // 自定义返回按钮
    [self setNavBackBtn];
}



- (void)setNavBackBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50, 50);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
