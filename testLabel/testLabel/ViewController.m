//
//  ViewController.m
//  testLabel
//
//  Created by MGBook on 2018/4/17.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "YYCategories.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.attributedText = [self makeTheAmountNumber:@"88.88"];
    
    
    
}



/**
 竖直排列
 */
- (void)test3
{
    // 通过sizeToFit改变frame来实现：
    // 限制尺寸
    CGRect frame =CGRectMake(kScreenWidth/2,200,30,30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor orangeColor];
    NSString*text = @"今天是个好日子啊";
    label.text = text;
    // 根据内容自适应尺寸
    // 竖直排列的关键
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
}


// 增加label的padding
//- (CGSize)intrinsicContentSize
//{
//    CGSize originalSize = [super intrinsicContentSize];
//    CGSize size = CGSizeMake(originalSize.width+20, originalSiz
//                             e.height+20); return size;
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





/**
 下划线
 */
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

@end
