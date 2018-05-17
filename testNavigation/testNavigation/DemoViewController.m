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
    
    // 自己实现侧滑？
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    // 测试 -> 所有都不能交互了
//    if (viewControllerCount == 2) {
//        self.navigationController.swipeBackEnabled = NO;
//    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    LxDBAnyVar(self.navigationController.interactivePopGestureRecognizer);
    LxDBAnyVar(self.navigationController.interactivePopGestureRecognizer.delegate);
    
    /**
    // 什么都没有 -> 不能滑动返回
    🎈 self.navigationController.interactivePopGestureRecognizer = <UIScreenEdgePanGestureRecognizer: 0x7f9cedf15240; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9cede14880>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f9cedf15100>)>>
    🎈 self.navigationController.interactivePopGestureRecognizer.delegate = <_UINavigationInteractiveTransition: 0x7f9cedf15100>

    // delegate == nil -> 能滑动返回
    // 重大bug: 返回到根控制器，再右滑 点push按钮进不去了
    // 到根控制器，如果不右滑动👉 push按钮能点进去

    🎈 self.navigationController.interactivePopGestureRecognizer = <UIScreenEdgePanGestureRecognizer: 0x7faae8508fe0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7faae8612640>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7faae8508ea0>)>>
    📍-[DemoViewController viewDidAppear:] + 65🎈 self.navigationController.interactivePopGestureRecognizer.delegate = (null)

    // delegate == self -> 和nil同样的问题！
    // 重大bug: 返回根控制器，再右滑 再点push按钮进不去了
    🎈 self.navigationController.interactivePopGestureRecognizer = <UIScreenEdgePanGestureRecognizer: 0x7fd6fce18490; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fd6fcd088f0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fd6fce18350>)>>
    📍-[DemoViewController viewDidAppear:] + 65🎈 self.navigationController.interactivePopGestureRecognizer.delegate = <DemoViewController: 0x7fd6fcc132d0>


    // ----> 直接设置 是不行🚫的

    */

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
