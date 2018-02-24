//
//  NSObject+MGKVO.m
//  testKVO
//
//  Created by MGBook on 2018/2/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "NSObject+MGKVO.h"
#import <objc/runtime.h>

@implementation NSObject (MGKVO)

- (void)MG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    NSString *oldClassName = NSStringFromClass([self class]);;
    NSString *newClassNmae = [@"MGKVO_" stringByAppendingString:oldClassName];
    const char *newName = newClassNmae.UTF8String;
    
    // 动态创建类
    Class MyClass = objc_allocateClassPair([self class], newName, 0);
    // 注册这个类
    objc_registerClassPair(MyClass);
    // 修改调用者的类型
    object_setClass(self, MyClass);
    
    // 重写set方法
    class_addMethod(MyClass, @selector(setName:), (IMP)setName, "v@:");
}

// 把隐含参数补齐，就可以接收name了
// id self, SEL _cmd
void setName(id self, SEL _cmd, NSString *name)
{
    NSLog(@"setName---调用了----%@", name);
}
@end