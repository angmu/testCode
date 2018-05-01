//
//  ViewController2.m
//  父子控制器
//
//  Created by 穆良 on 2018/5/1.
//  Copyright © 2018年 穆良. All rights reserved.
//

#import "ViewController2.h"
#import "SocietyViewController.h"
#import "HotViewController.h"
#import "TopicViewController.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupAllController];

    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.view.subviews[i];
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
    }
    
}




- (IBAction)showView:(UIButton *)sender
{
    // 添加控制到
    NSInteger tag = sender.tag;
    UIViewController *vc = self.childViewControllers[tag];
    vc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:vc.view];
}


/**
 添加所有子控制器
 */
- (void)setupAllController
{
    SocietyViewController *socity = [[SocietyViewController alloc] init];
    socity.title = @"社会";
    [self addChildViewController:socity];
    
    HotViewController *hot = [[HotViewController alloc] init];
    hot.title = @"热点";
    [self addChildViewController:hot];
    
    TopicViewController *topic = [[TopicViewController alloc] init];
    topic.title = @"头条";
    [self addChildViewController:topic];
}






@end
