//
//  RecommendTableViewCell.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "RecommendTableViewCell.h"
#import "UIButton+WebCache.h"
@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)congfig:(NSArray*)dataArray{
    
    self.la1.backgroundColor =[UIColor colorWithRed:1 green:0.46 blue:0.3 alpha:1];;
    
    self.bt1.tag =501;
    self.bt2.tag =502;
    self.bt3.tag =503;

    
    [self.bt1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArray[0] objectForKey:@"cover"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    [self.bt2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArray[1] objectForKey:@"cover"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    [self.bt3 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArray[2] objectForKey:@"cover"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    self.label1.text = [dataArray[0] objectForKey:@"title"];
     self.label2.text = [dataArray[1] objectForKey:@"title"];
    self.label3.text = [dataArray[2] objectForKey:@"title"];
  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
