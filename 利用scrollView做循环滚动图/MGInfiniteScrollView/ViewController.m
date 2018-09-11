//
//  ViewController.m
//  MGScrollView
//
//  Created by 穆良 on 16/6/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "ViewController.h"
#import "LxDBAnything.h"
#import "MGPageScrollView.h"

#import "MGPageScrollViewByTwoImageView.h"

#define kImageCount 5

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MGPageScrollView *pageScrollView;
//@property (weak, nonatomic) IBOutlet MGPageScrollViewByTwoImageView *pageScrollView;

/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.pageScrollView.images = self.images;
    
    self.pageScrollView.images = self.images;
    self.pageScrollView.currentPageColor = [UIColor redColor];

//    self.pageScrollView.pageControlPostion = MGPageControlPositionRight;
//    self.pageScrollView.autoScrollTimeInterval = 1.0;
    
    self.pageScrollView.clickImageAction = ^(NSInteger index) {
        NSLog(@"----%zd", index);
    };
    
}

/**
- (void)testPageScrollView
{
    self.pageScrollView.images = self.images;
    self.pageScrollView.currentPageColor = [UIColor redColor];
    //    self.pageScrollView.pageControlPostion = MGPageControlPositionRight;
    
    //    self.pageScrollView.autoScrollTimeInterval = 1.0;
    
    self.pageScrollView.clickImageAction = ^(NSInteger index) {
        NSLog(@"----%zd", index);
    };
}
*/


- (NSMutableArray *)images
{
    if (!_images) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:kImageCount];
        
        for (int i = 0; i < kImageCount; i++)  {
            NSString *imageName = [NSString stringWithFormat:@"img_%02d", i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        
        _images = images;
    }
    return _images;
}


@end
