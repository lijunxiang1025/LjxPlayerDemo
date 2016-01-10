//
//  PlayerDetailCell.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "PlayerDetailCell.h"

@implementation PlayerDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)config:(PlayerCellModel*)model{
    [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"]];
    self.label1.text = model.title;
    self.label2.text = [NSString stringWithFormat:@"收听%@",model.viewnum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
