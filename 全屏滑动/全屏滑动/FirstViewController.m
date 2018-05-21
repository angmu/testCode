//
//  FirstViewController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 添加按钮
    [self addBtn];
}


- (void)addBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
}

- (void)btnPress {
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

@end
