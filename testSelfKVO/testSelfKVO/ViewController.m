//
//  ViewController.m
//  testSelfKVO
//
//  Created by MGBook on 2018/3/28.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    LxDBAnyVar([[UIPageControl class] instanceVariables]);
    LxDBAnyVar([[UIPageControl class] properties]);
    
    LxDBAnyVar([UIControl properties]);
}


@end
