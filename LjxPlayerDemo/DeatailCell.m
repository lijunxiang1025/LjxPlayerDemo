//
//  DeatailCell.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/30.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "DeatailCell.h"

@implementation DeatailCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)config:(DetailModel*)model{
   
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"sy.jpg"]];
    self.label1.text = model.title;
    self.label2.text = [NSString stringWithFormat:@"主播:%@",model.speak];
    self.label3.text = [NSString stringWithFormat:@"收听量  %@",model.viewnum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
