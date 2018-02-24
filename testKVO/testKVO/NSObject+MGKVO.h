//
//  NSObject+MGKVO.h
//  testKVO
//
//  Created by MGBook on 2018/2/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MGKVO)

- (void)MG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
