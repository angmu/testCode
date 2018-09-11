//
//  MGPageScrollView.h
//  MGScrollViewDemo
//
//  Created by 穆良 on 16/6/21.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPageScrollView : UIView

/**
 *  pageControl位置
 */
typedef NS_ENUM(NSInteger, MGPageControlPosition)
{
    MGPageControlPositionCenter = 0,
    MGPageControlPositionRight
};


@property (nonatomic, copy) void(^clickImageAction)(NSInteger index);

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *images;

/**
 * 页索引位置
 */
@property (assign, nonatomic) MGPageControlPosition pageControlPostion;
/**
 * 当前页索引颜色
 */
@property (strong, nonatomic) UIColor *currentPageColor;

/**
 * 非当前页索引颜色
 */
@property (strong, nonatomic) UIColor *otherPageColor;


/**
 * 自动滚动的时间间隔
 * 在开启自动切图的情况下，修改时间间隔会实时生效
 */
@property (assign, nonatomic) NSTimeInterval autoScrollTimeInterval;

@end
