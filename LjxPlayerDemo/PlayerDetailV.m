//
//  PlayerDetailV.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "PlayerDetailV.h"

@implementation PlayerDetailV
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"PlayerDetailV" owner:self options:nil] lastObject];
        self.frame = frame;
        
    }
    return self;
}

- (void)config:(PlayerHeaderModel*)model{
    self.header.layer.masksToBounds = YES;
    self.header.layer.cornerRadius =20;
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:model.gcover] placeholderImage:[UIImage imageNamed:@"sy.jpg"]];
    [self.header sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"sy.jpg"]];
    self.content.text = model.content;
    self.name.text = model.title;
    self.textLabel.text = [NSString stringWithFormat:@"收听   %@|  关注   %@",model.viewnum,model.favnum];
    self.number.text = model.fmnum;
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
