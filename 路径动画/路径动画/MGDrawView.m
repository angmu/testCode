//
//  MGDrawView.m
//  路径动画
//
//  Created by MGBook on 2018/5/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "MGDrawView.h"

@interface MGDrawView ()
/// 记录手动绘图路径
@property (nonatomic, strong) UIBezierPath *path;
@end


@implementation MGDrawView

- (UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取手触摸点
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    
    // 路径起点
    [self.path moveToPoint:currentP];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取手触摸点
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    
    // 不断添加点到某根线
    [self.path addLineToPoint:currentP];
    // 绘制出来
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 把路径画出来
    [self.path stroke];
}

// 跟着路径动画
- (void)startAnim
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = self.path.CGPath;
    // 填充颜色，最后一个封闭的形状
    layer.fillColor = [UIColor whiteColor].CGColor;
    // 描边颜色
    layer.strokeColor = [UIColor redColor].CGColor;
    
    // 只画一部分
//    layer.strokeEnd = 0.5;
    
    // 改变图层的某个熟悉
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"strokeEnd";
    anim.fromValue = @0;
    anim.toValue = @1;
    anim.duration = 5;
    [layer addAnimation:anim forKey:nil];
    [self.layer addSublayer:layer];
    
    // 清空画线,图形还在，和路径一样图层
    [self clearAll];
}

- (void)clearAll
{
    [self.path removeAllPoints];
    [self setNeedsDisplay];
}


@end
