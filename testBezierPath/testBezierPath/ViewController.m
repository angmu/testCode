//
//  ViewController.m
//  testBezierPath
//
//  Created by MGBook on 2018/5/10.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    
    
}


/**
 mask渐变颜色
 */
- (void)test2
{
    CALayer *layer = [[CALayer alloc] init];
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(50, 50);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.cornerRadius = 8;
    layer.borderWidth = 3;
    layer.borderColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    // 添加子视图
    CALayer *layer2 = [[CALayer alloc] init];
    layer2.anchorPoint = CGPointMake(1, 1);
    layer2.position = CGPointMake(50, 50);
    layer2.bounds = CGRectMake(0, 0, 45, 45);
    layer2.backgroundColor = [UIColor blueColor].CGColor;
    layer2.shadowColor=[UIColor redColor].CGColor;
    layer2.shadowOffset=CGSizeMake(10, 10);
    layer2.shadowOpacity = 1;
    [layer addSublayer:layer2];
    
    //    CALayer *layer22 = [[CALayer alloc]init];
    //    layer22.anchorPoint = CGPointMake(0, 0);
    //    layer22.position = CGPointMake(15, 15);
    //    layer22.bounds = CGRectMake(0, 0, 60, 60);
    //    layer22.backgroundColor = [UIColor purpleColor].CGColor;
    ////    [layer addSublayer:layer22];
    //    layer.mask = layer22;
    
    
    // 用文字截颜色
    UILabel *label=[[UILabel alloc] init];
    label.text = @"MULIANG";
    label.textColor = [UIColor yellowColor];
    
    // 必须添加，否则label保存不了
    [self.view addSubview:label];
    layer.mask = label.layer;
    //    label.frame= layer.bounds;
    label.frame=CGRectMake(10,25,100, 50);

}


/**
 圆角矩形
 */
- (void)test {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.yellowView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.yellowView.bounds;
    layer.path = path.CGPath;
    
    self.yellowView.layer.mask = layer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
