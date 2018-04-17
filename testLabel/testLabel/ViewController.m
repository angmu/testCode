//
//  ViewController.m
//  testLabel
//
//  Created by MGBook on 2018/4/17.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "YYCategories.h"
#import "STLabel.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.nameLabel.attributedText = [self makeTheAmountNumber:@"88.88"];
    
    // 通过sizeToFit改变frame来实现：
    CGRect frame =CGRectMake(kScreenWidth/2,100,30,30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor orangeColor];
    NSString*text = @"今天是个好日子啊";
    label.text = text;
    // 根据内容自适应尺寸
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
    
}

//- (NSAttributedString *)makeTheAmountNumber:(NSString *)amountStr {
//    NSString * lastStr = [NSString stringWithFormat:@"¥%@ 元",amountStr];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lastStr];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, amountStr.length)];
//
//    return attributedString.copy;
//
//}

- (NSAttributedString *)makeTheAmountNumber:(NSString *)amountStr {
    NSString *lastStr = [NSString stringWithFormat:@"¥%@元", amountStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lastStr];
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                      NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                      NSStrikethroughColorAttributeName:[UIColor orangeColor]
                                      }
                     range:NSMakeRange(0, amountStr.length+1)];
    return attributedString.copy;
}



- (void)test2
{
    STLabel *label = [[STLabel alloc] init];
    label.text = @"112uhydnjn";
    [self.view addSubview:label];
    label.center = self.view.center;
    // 按照正常label使用, 别忘了给label赋值后调用sizeToFit
    // 否则没有size
    [label sizeToFit];
}



- (void)test1
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"¥932452" attributes:@{
                                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:20.f],
                                                                                                     NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#5bcec0"],
                                                                                                     NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                                                                                     NSStrikethroughColorAttributeName : [UIColor colorWithHexString:@"#5bcec0"]
                                                                                                     }];
    self.nameLabel.attributedText = attrStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
