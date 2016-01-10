//
//  DTMoreCell.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/31.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "DTMoreCell.h"

@implementation DTMoreCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)config:(DTModel*)model{
    
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.cornerRadius = 20;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"sy.jpg"]];

    });
    self.label1.text = model.title;
    self.label2.text = model.content;
    self.label3.text = [NSString stringWithFormat:@"节目   %@",model.fmnum];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
