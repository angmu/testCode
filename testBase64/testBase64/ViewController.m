//
//  ViewController.m
//  testBase64
//
//  Created by MGBook on 2018/2/26.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *uid;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

static NSString *const salt = @"sniushiud898ebudbuyagY&Y(*9vbuyvsay";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", [self base64Encode:@"haha"]);
//    NSLog(@"%@", [self base64Encode:@"哈哈😆"]);
////    aGFoYQ==
////    5ZOI5ZOI8J+Yhg==
//    NSLog(@"%@", [self base64Decode:@"aGFoYQ=="]);
//    NSLog(@"%@", [self base64Decode:@"5ZOI5ZOI8J+Yhg=="]);
    
}


- (IBAction)login {
    
    NSString *uid = self.uid.text;
    NSString *pwd = self.pwd.text;
    
    // 直接md5太简单
//    pwd = pwd.md5String;
//    pwd = [pwd stringByAppendingString:salt].md5String;
    pwd = [pwd hmacSHA1StringWithKey:@"helen"];
    
    // 登陆
    [self sendUserId:uid withPwd:pwd];
}


- (void)sendUserId:(NSString *)uid withPwd:(NSString *)pwd
{
    NSLog(@"\n账号：%@\n密码：%@", uid, pwd);
}


/** 字符串，进行base64编码 */
- (NSString *)base64Encode:(NSString *)string
{
    // 1.将字符串转成 二进制
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 2.返回base64编码
    return [data base64EncodedStringWithOptions:0];
}

/** 给我一个base64编码，解码 */
- (NSString *)base64Decode:(NSString *)string
{
    // 1.将base64编码后的字符串，转换成 二进制
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    // 2.返回字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}




@end
