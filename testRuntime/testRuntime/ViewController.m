//
//  ViewController.m
//  testRuntime
//
//  Created by 穆良 on 2018/2/8.
//  Copyright © 2018年 穆良. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建 dispatch_group
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 添加到 group 中
    NSLog(@"begin-----%@", [NSThread currentThread]);
    dispatch_group_async(group, queue, ^{
        NSLog(@"block 1-----%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block 2-----%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block 3-----%@", [NSThread currentThread]);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end-----%@", [NSThread currentThread]);
    });
    NSLog(@"go-----%@", [NSThread currentThread]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
