//
//  ViewController.m
//  testWindow
//
//  Created by MGBook on 2018/3/29.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *redView = [[UIView alloc] init];
    _redView = redView;
    redView.backgroundColor = [UIColor redColor];
    redView.frame = CGRectMake(50, 50, 200, 200);
    [self.view addSubview:redView];
    
    UISwitch *switchV = [[UISwitch alloc] init];
    [_redView addSubview:switchV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect bounds = _redView.bounds;
    bounds.origin.y += 10;
    _redView.bounds = bounds;
}

@end
