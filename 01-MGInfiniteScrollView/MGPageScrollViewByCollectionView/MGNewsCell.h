//
//  MGNewsCell.h
//  MGScrollViewDemo
//
//  Created by 穆良 on 16/6/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGNews;

@interface MGNewsCell : UICollectionViewCell
/** 新闻模型 */
@property (nonatomic, strong) MGNews *news;
@end
