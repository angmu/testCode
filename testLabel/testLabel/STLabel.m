//
//  STLabel.m
//  testLabel
//
//  Created by MGBook on 2018/4/17.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "STLabel.h"

@implementation STLabel

//- (void)drawRect:(CGRect)rect
//{
//    // 调用super的drawRect:方法,会按照父类绘制label的文字
//    [super drawRect:rect];
//    // 取文字的颜色作为删除线的颜色
//    [self.textColor set];
//    CGFloat w = rect.size.width;
//    CGFloat h = rect.size.height;
//    // 绘制(这个数字是为了找到label的中间位置,0.35这个数字是试出来的,如果不在中间可以自己调整)
//    UIRectFill(CGRectMake(0, h * 0.35, w, 1));
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 颜色
    [self.textColor setStroke];
    // 线的起点
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(context, 0, y);
    // 字体宽度
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    // 线的终点
    CGContextAddLineToPoint(context, size.width, y);
    // 渲染
    CGContextStrokePath(context);
}

@end
