//
//  MGNewsCell.m
//  MGScrollViewDemo
//
//  Created by 穆良 on 16/6/20.
//  Copyright © 2016年 穆良. All rights reserved.
//


#import "MGNewsCell.h"
#import "MGNews.h"

@interface MGNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation MGNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setNews:(MGNews *)news
{
    _news = news;
    
    self.iconView.image = [UIImage imageNamed:news.icon];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", news.title];
}

//- (void)setFrame:(CGRect)frame
//{
//    LxDBAnyVar(frame);
//    [super setFrame:frame];
//}

@end
