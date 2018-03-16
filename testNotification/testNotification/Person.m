//
//  Person.m
//  testNotification
//
//  Created by MGBook on 2018/3/16.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "Person.h"
#import "NewsCompany.h"

@implementation Person
- (void)newsCome:(NSNotification *)note
{
    // 通知的发布者
    NewsCompany *obj = note.object;
    NSLog(@"%@接收到了%@发出的通知,通知内容是:%@", self.name, obj.name, note.userInfo);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [super dealloc];   ARC环境下不要调用
}
@end
