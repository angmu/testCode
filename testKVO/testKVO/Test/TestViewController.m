//
//  TestViewController.m
//  testKVO
//
//  Created by MGBook on 2018/3/17.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

/** 当键盘改变了frame(位置和尺寸)的时候调用 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 设置窗口的颜色，view和键盘滚动不协调，有黑色的
    self.view.window.backgroundColor = [UIColor lightGrayColor];
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame，把对象转成结构体CGRectValue
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}


@end
