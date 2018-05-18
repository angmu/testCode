//
//  ThridViewController.m
//  ObjcProj
//
//  Created by MGBook on 2018/5/17.
//  Copyright © 2018年 林洵锋. All rights reserved.
//

#import "ThridViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface ThridViewController ()

@end

@implementation ThridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 自定义返回按钮
    [self setNavBackBtn];
    
    self.fd_interactivePopDisabled = YES;
    
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
