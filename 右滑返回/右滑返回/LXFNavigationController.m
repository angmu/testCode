//
//  LXFNavigationController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "LXFNavigationController.h"

@interface LXFNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

/** 系统手势代理 */
@property(nonatomic, strong) id popGesture;

@end

@implementation LXFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 记录系统手势代理
//    self.popGesture = self.interactivePopGestureRecognizer;
//    self.delegate = self;
//}
//
//#pragma mark - UINavigationControllerDelegate
//// 当控制器显示完毕的时候调用
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 根据 栈 先进后出
//    if (self.viewControllers[0] == viewController) { // 根控制器
//        // 还原代理
//        self.interactivePopGestureRecognizer.delegate = self.popGesture;
//    } else { // 非控制器
//        // 清空手势代理就能实现滑动返回，iOS6不支持
//        self.interactivePopGestureRecognizer.delegate = nil;
//    }
//    // 如果当前控制器为根控制器，则使手势失效，不然手势会将根控制器移除
//    if (self.viewControllers.count == 1) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    } else {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
//}

@end
