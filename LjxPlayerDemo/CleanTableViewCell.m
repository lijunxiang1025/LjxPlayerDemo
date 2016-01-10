//
//  CleanTableViewCell.m
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "CleanTableViewCell.h"

@interface CleanTableViewCell ()
@property (strong, nonatomic) IBOutlet UIView *backView;

@end

@implementation CleanTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backView.layer.cornerRadius = 10 ;
    self.backView.layer.borderWidth = 0.5 ;
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor ;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)] ;
    [self.backView addGestureRecognizer:tap] ;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    self.block() ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
