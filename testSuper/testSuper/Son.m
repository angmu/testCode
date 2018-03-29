//
//  Son.m
//  testSuper
//
//  Created by MGBook on 2018/3/27.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "Son.h"

@implementation Son

/**
  class：获取方法调用者类名
  superclass：获取方法调用者的父类类名
  super：指向父类的标识，编译器修饰符，不是指针
 */
- (void)test
{
    // 谁调用这个方法，self就是谁！
    NSLog(@"%@", self);
//    NSLog(@"%@", super);
    // 函数里也没有定义super
    // self是隐藏参数，super就是个标识符，和const差不多！
//    NSLog(@"%@, %@, %@", [self class], [self superclass], [super class]);
    // Son, Father, Son
    
    [super test];
    // Son, Father, Son
}
@end
