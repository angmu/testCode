//
//  NSObject+MGKVO.m
//  testKVO
//
//  Created by MGBook on 2018/2/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "NSObject+MGKVO.h"
#include <objc/message.h>


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
    // 修改调用者的类型，修改isa指针
    object_setClass(self, MyClass);
    
    // 重写set方法
    class_addMethod(MyClass, @selector(setName:), (IMP)setName, "v@:");
    
    // 动态绑定属性
    // 最终还是要调用_相应方法
    
    
    // --- 保存观察者
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

// 把隐含参数补齐，就可以接收name了
// id self, SEL _cmd
// 子类的setName方法
void setName(id self, SEL _cmd, id name)
{
    NSLog(@"NSObject+MGKVO---setName---调用了----%@", name);
    
    // 调用父类方法，消息机制
//    [super setName:name];
//    objc_msgSendSuper([self class], _cmd, name);
    
    
    
    // ------1
    // 保存当前类
//    Class MyClass = [self class];
//    // 将self指向父类，准备调用父类方法
//    object_setClass(self, class_getSuperclass([self class]));
//    // 调用父类方法
//    objc_msgSend(self, @selector(setName:), name);
//    // 通知观察者
//    id observer = objc_getAssociatedObject(self, @"observer");
//    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), @"name", self, nil, nil);
//    // 改回子类
//    object_setClass(self, MyClass);
    // 5监听到<MGPerson: 0x60000000a2d0>属性的改变为(null)
    /**
     
     2018-03-27 18:03:01.760025+0800 testKVO[6590:1043259] <MGPerson: 0x600000013fb0>监听到name属性的改变为{
     kind = 1;
     new = 5;
     old = lisa;
     }
     2018-03-27 18:03:01.760218+0800 testKVO[6590:1043259] name的值------5

     --------------------------
     NSObject+MGKVO---setName---调用了----7
     <MGPerson: 0x600000015400>监听到name属性的改变为(null)
     name的值------7
     */
    
    // ------2 直接调用父类方法，设置name的值
    // class_getSuperclass(object_getClass(self));
    // Use of undeclared identifier 'super'
//    objc_msgSendSuper(super, @selector(setName:), name);
    
    
    
    
}


/**
 1. 扩展性
 2. block实现kvo函数式编程
 
    创建的子类就没有这个name属性
 
 */
@end
