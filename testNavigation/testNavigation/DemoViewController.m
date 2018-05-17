//
//  DemoViewController.m
//  testNavigation
//
//  Created by MGBook on 2018/5/17.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "DemoViewController.h"
#import "LxDBAnything.h"
#import "SwipeBack.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *pushBtn = [[UIButton alloc] init];
    [pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    [pushBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [pushBtn sizeToFit];
    pushBtn.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);
    [pushBtn addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pushBtn];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSInteger viewControllerCount = self.navigationController.viewControllers.count;

    if (!self.navigationItem.title) {
        self.navigationItem.title = [NSString stringWithFormat:@"View Controller %ld", viewControllerCount];
    }
    
    
    if (!self.navigationItem.leftBarButtonItem && viewControllerCount > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    }
    
    LxDBAnyVar(self.navigationController.interactivePopGestureRecognizer.delegate);
    // 🎈 self.navigationController.interactivePopGestureRecognizer.delegate = <_UINavigationInteractiveTransition: 0x7faf55c0e5f0>
    // 🎈 self.navigationController.interactivePopGestureRecognizer.delegate = <UINavigationController: 0x7fd64b844400>
    
    // 测试 -> 所有都不能交互了
//    if (viewControllerCount == 2) {
//        self.navigationController.swipeBackEnabled = NO;
//    }
    
}



- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushViewController
{
    DemoViewController *viewController = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
