//
//  ViewController.m
//  父子控制器
//
//  Created by 穆良 on 2018/4/22.
//  Copyright © 2018年 穆良. All rights reserved.
//

#import "ViewController.h"

#import "SocietyViewController.h"
#import "HotViewController.h"
#import "TopicViewController.h"



/**
 父子控制器：用一个大控制器，管理多个子控制器
 任何控制器 都可以做 容器  === addChildViewController
 
 */

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *societyBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@property (nonatomic, strong) SocietyViewController *society;
@property (nonatomic, strong) HotViewController *hot;
@property (nonatomic, strong) TopicViewController *topic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
  
    
}

- (IBAction)showSociety:(id)sender
{
    if (!_society) {
        SocietyViewController *society = [[SocietyViewController alloc] init];
        _society = society;
        [self addChildViewController:society];
    }
    [self.view addSubview:self.society.view];
}

- (IBAction)showHot:(id)sender
{
    if (!_hot) {
        HotViewController *hot = [[HotViewController alloc] init];
        _hot = hot;
        [self addChildViewController:hot];
    }
    [self.view addSubview:self.hot.view];
}

- (IBAction)showTopic:(id)sender
{
    if (!_topic) {
        TopicViewController *topic = [[TopicViewController alloc] init];
        _topic = topic;
        [self addChildViewController:topic];
    }
    [self.view addSubview:self.topic.view];
}

/**
 ARC管理原则：只要对象没有被强引用，就会被销毁
 控制器的View存在，控制器销毁，导致View上的事件不能处理
 
 
 */

@end
