//
//  RadioTableViewCell.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "RadioTableViewCell.h"
#import "UIButton+WebCache.h"
@implementation RadioTableViewCell

- (void)awakeFromNib {
    
    
    
}
- (IBAction)gotherClick:(id)sender {
    
    
    
    
}
- (IBAction)bt1Click:(id)sender {
}
- (IBAction)bt2Click:(id)sender {
}
- (IBAction)bt3Click:(id)sender {
}
- (IBAction)bt4Click:(id)sender {
}
- (void)configWith:(NSArray*)dataArr{
    
    self.colorLabel.backgroundColor =        self.colorLabel.backgroundColor = [UIColor colorWithRed:0.36 green:0.99 blue:0.67 alpha:1];
    
    
    [self.bt1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[0] objectForKey:@"cover"]] forState:UIControlStateNormal];
    [self.bt2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[1] objectForKey:@"cover"]] forState:UIControlStateNormal];
    [self.bt3 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[2] objectForKey:@"cover"]] forState:UIControlStateNormal];
    [self.bt4 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[3] objectForKey:@"cover"]] forState:UIControlStateNormal];
   

    self.label1.text = [[[dataArr objectAtIndex:0] objectForKey:@"user"] objectForKey:@"nickname"];
    self.label2.text = [[[dataArr objectAtIndex:1] objectForKey:@"user"] objectForKey:@"nickname"];
    self.label3.text = [[[dataArr objectAtIndex:2] objectForKey:@"user"] objectForKey:@"nickname"];
    self.label4.text = [[[[[dataArr objectAtIndex:3] objectForKey:@"user"] objectForKey:@"nickname"] componentsSeparatedByString:@"_"] componentsJoinedByString:@""];

    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
