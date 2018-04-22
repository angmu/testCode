//
//  ViewController.m
//  父子控制器
//
//  Created by 穆良 on 2018/4/22.
//  Copyright © 2018年 穆良. All rights reserved.
//

#import "ViewController.h"




/**
 父子控制器：用一个大控制器，管理多个子控制器
 任何控制器 都可以做 容器  === addChildViewController
 
 */
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *societyBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)showSociety:(id)sender
{
    
}
- (IBAction)showHot:(id)sender
{
    
}
- (IBAction)showTopic:(id)sender
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
