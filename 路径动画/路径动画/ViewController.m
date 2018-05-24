//
//  ViewController.m
//  路径动画
//
//  Created by MGBook on 2018/5/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "MGDrawView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MGDrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)startAnim:(id)sender {
    [self.drawView startAnim];
}

- (IBAction)clearAll:(id)sender {
    [self.drawView clearAll];
}


@end
