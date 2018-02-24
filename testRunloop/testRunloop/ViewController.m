//
//  ViewController.m
//  testRunloop
//
//  Created by MGBook on 2018/1/30.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "MOThread.h"
#import "NSImage+WebCache.h"

@interface ViewController ()
/// 线程安排
@property (nonatomic, strong) MOThread *thread;
/// UIImageView控件
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadGCD];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
////        code to be executed once
//
//    });
    // 打印主线程
    NSLog(@"主线程----%@", [NSThread mainThread]);
    // 1.创建串行队列
//    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // DISPATCH_QUEUE_CONCURRENT
//    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 2.添加任务到队列中执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@", [NSThread currentThread]);
    });
    
    NSLog(@"主线程结束----%@", [NSThread mainThread]);
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    // 队列组
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    // 下载第1张图片
//    __block UIImage *image1 = nil;
//    dispatch_group_async(group, queue, ^{
//        image1 = [self downloadImage:@"http://cdn.duitang.com/uploads/item/201403/23/20140323171323_aNfWX.jpeg"];
//    });
//
//    // 下载第2张图片
//    __block UIImage *image2 = nil;
//    dispatch_group_async(group, queue, ^{
//        image2 = [self downloadImage:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517917604513&di=b384a346f45265d311829387a0f49167&imgtype=0&src=http%3A%2F%2Fnfs.gongkong.com%2FUpload%2FBBSPicture%2F201407%2F20140726220208791_min.jpg"];
//    });
//
//
//    // 合并2张图片(保证执行完组里面的所有任务之后，再执行notify函数里面的block)
//    dispatch_group_notify(group, queue, ^{
//        // 开启位图上下文
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image1.size.width * 2, image1.size.height), NO, 0.0);
//
//        // 绘制第1张图片
//        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
//        // 绘制第2张图片
//        [image2 drawInRect:CGRectMake(image1.size.width, 0, image2.size.width, image2.size.height)];
//
//        // 得到上下文中的图片
//        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
//        // 结束上下文
//        UIGraphicsEndImageContext();
//
//        //到主线程中更新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"setting------%@", [NSThread currentThread]);
//            [self.imageView setImage:fullImage];
//        });
//    });
//}

/// 下载图片
- (UIImage *)downloadImage:(NSString *)urlStr
{
    NSLog(@"下载图片---%@", [NSThread currentThread]);
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    return [UIImage imageWithData:data];
}

/// 同步函数+ 并行队列
- (void)loadGCD
{
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"syncConcurrent---begin");
    // 同步任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; ++i)
        {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; ++i)
        {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; ++i)
        {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
    NSLog(@"syncConcurrent---end");
}

- (void)doMethod
{
    NSLog(@"---%@", [NSThread currentThread]);
}

- (void)testRunloop
{
    NSLog(@"viewDidLoad ---- 调用了");
    
    // 创建线程
    _thread = [[MOThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(doMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        //        [[NSRunLoop currentRunLoop] run];
        
        
        NSLog(@"initWithBlock ---- 调用了");
    }];
    
    [_thread start];
}
@end
