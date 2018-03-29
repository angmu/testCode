//
//  Father.m
//  testSuper
//
//  Created by MGBook on 2018/3/27.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "Father.h"

@implementation Father
- (void)test
{
    NSLog(@"%@, %@, %@", [self class], [self superclass], [super class]);
}
@end
