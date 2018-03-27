//
//  Son.m
//  testSuper
//
//  Created by MGBook on 2018/3/27.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "Son.h"

@implementation Son

- (void)test
{
    NSLog(@"%@", self);
//    NSLog(@"%@", super);
    // 函数里也没有定义super
//    NSLog(@"%@, %@, %@", [self class], [self superclass], [super class]);
    [super test];
}
@end
