//
//  ViewController.m
//  testQR
//
//  Created by MGBook on 2018/2/26.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "HMScannerController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scanResultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *cardName = @"天涯刀哥 - 傅红雪";
    UIImage *avatar = [UIImage imageNamed:@"avatar"];
    
    // 实例化扫描控制器
    HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
        
        self.scanResultLabel.text = stringValue;
    }];
    
    // 设置导航栏样式
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    // 展现扫描控制器
    [self showDetailViewController:scanner sender:nil];
    
}



@end
