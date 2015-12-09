//
//  FindTableViewCell2.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/8.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "FindTableViewCell2.h"

@implementation FindTableViewCell2
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)createView{
    NSArray * array = @[@"scene1",@"scene2",@"scene3",@"emotion4",@"scene5",@"scene6",@"scene7",@"scene8",@"scene9"];
    
    NSArray * titleArr =@[@"睡觉",@"旅行",@"坐车",@"散步",@"独处",@"失恋",@"失眠",@"随便",@"无聊"];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, ScreenWidth, 25)];
    [self.contentView addSubview:label];
    label.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    label.text = @"场景";
    label.font = [UIFont systemFontOfSize:16];
    for (int i =0 ; i<9; i++) {
        
        UIImageView * backImageV = [LjxUi createImageView:CGRectMake(i%3*((ScreenWidth-2)/3+1), 30+i/3*(1+(ScreenWidth-2)/3+5), (ScreenWidth-2)/3, (ScreenWidth-2)/3+5) andName:nil];
        [self.contentView addSubview:backImageV];
        backImageV.backgroundColor = [UIColor whiteColor];
        UIImageView * _imageV = [LjxUi createImageView:CGRectMake(backImageV.frame.size.width/2-15, backImageV.frame.size.height/2-30, 30, 30) andName:array[i]];
        [backImageV addSubview:_imageV];
        
        UILabel * lable = [LjxUi createLable:CGRectMake(0, _imageV.frame.origin.y+30, backImageV.frame.size.width, 30) andFont:12 andTextAlignment:1 text:titleArr[i] andColor:[UIColor blackColor]];
        [backImageV addSubview:lable];
        
        UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(i%3*((ScreenWidth-2)/3+1), 30+i/3*(1+(ScreenWidth-2)/3+5), (ScreenWidth-2)/3, (ScreenWidth-2)/3+5)];
        [control addTarget:self action:@selector(goOther:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:control];
        control.tag = 700+ i;
    }
    
    
    
}
- (void)goOther:(UIControl*)control{
    
    self.block(control.tag);

    
}
@end
