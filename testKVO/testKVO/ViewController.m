//
//  ViewController.m
//  testKVO
//
//  Created by MGBook on 2018/2/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "MGPerson.h"
#import "NSObject+MGKVO.h"

#import "LxDBAnything.h"

@interface ViewController ()

@property (nonatomic, strong) MGPerson *p;
@property (nonatomic, copy) NSString *address;

@end

/**
 [iOS开发-KVO的奥秘](https://www.jianshu.com/p/742b4b248da9)
 [KVO原理及自定义KVO](https://blog.csdn.net/u014247354/article/details/78403567)
 [手动实现KVO](https://www.cnblogs.com/oc-bowen/p/5999564.html)
 [对于KVO，你真的了解么？](https://www.jianshu.com/p/a32d851603e5)
 
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UISwitch *swi = [[UISwitch alloc] init];
    [self.view addSubview:swi];

//    NSLog(@"=====%@", NSStringFromCGRect(self.view.frame));
//
//    NSDictionary *dict = @{@"address" : self.address?: @""};
//    NSLog(@"%@", dict);
//
//    self.address = @"hubei";
//    NSDictionary *dict2 = @{@"address" : self.address?: @""};
//    NSLog(@"%@", dict2);
    
    
    MGPerson *p = [[MGPerson alloc] init];
    p.name = @"lisa";
    _p = p;

    [p MG_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}


// 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@监听到%@属性的改变为%@", object, keyPath, change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *randomStr = [NSString stringWithFormat:@"%d", arc4random()%10];
    self.p.name = randomStr;
    NSLog(@"name的值------%@", self.p.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
