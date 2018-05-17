//
//  LXFNavigationController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "LXFNavigationController.h"

@interface LXFNavigationController () <UINavigationControllerDelegate>

/** 系统手势代理 */
@property(nonatomic, strong) id popGesture;

@end

@implementation LXFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 记录系统手势代理
    self.popGesture = self.interactivePopGestureRecognizer;
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
// 当控制器显示完毕的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 根据 栈 先进后出
    if (self.viewControllers[0] == viewController) { // 根控制器
        // 还原代理
        self.interactivePopGestureRecognizer.delegate = self.popGesture;
    } else { // 非控制器
        // 清空手势代理就能实现滑动返回，iOS6不支持
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    // 如果当前控制器为根控制器，则使手势失效，不然手势会将根控制器移除
    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
