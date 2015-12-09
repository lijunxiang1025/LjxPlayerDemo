//
//  FindTableViewCell1.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/6.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "FindTableViewCell1.h"

@interface FindTableViewCell1 ()

@end
@implementation FindTableViewCell1

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    NSArray * array = @[@"emotion1",@"emotion2",@"emotion3",@"emotion4",@"emotion5",@"emotion6",@"emotion7",@"emotion8",@"emotion9"];
    
    NSArray * titleArr =@[@"烦躁",@"悲伤",@"孤独",@"已弃疗",@"减压",@"无奈",@"快乐",@"感动",@"迷茫"];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, ScreenWidth, 25)];
    [self.contentView addSubview:label];
    label.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    label.text = @"心情";
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
        control.tag = 600+ i;
    }
    
    
    
}
- (void)goOther:(UIControl*)control{
    
    self.block(control.tag);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
