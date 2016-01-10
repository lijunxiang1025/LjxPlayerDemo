//  XLClassTableViewCell.m
//  LjxPlayerDemo
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "XLClassTableViewCell.h"
#import "UIButton+WebCache.h"

@interface XLClassTableViewCell ()

@property(nonatomic,strong)UIControl * control1;
@property(nonatomic,strong)UIControl * control2;
@property(nonatomic,strong)UIControl * control3;
@property(nonatomic,strong)UIControl * control_1;
@property(nonatomic,strong)UIControl * control_2;
@property(nonatomic,strong)UIControl * control_3;

@property(nonatomic,strong)UIControl * control4;

@property(nonatomic,strong)UIControl * control_4;

@end
@implementation XLClassTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.control1 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt1.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control1];
    [self.control1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.control_1 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt1.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control_1];
    [self.control_1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.control2 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt2.frame.origin.y, ScreenWidth, 40)];
    [self.control2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.control2];

    self.control_2 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt2.frame.origin.y, ScreenWidth, 40)];
    [self.control_2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.control_2];
    
    self.control3 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt3.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control3];
    [self.control3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.control_3 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.bt3.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control_3];
    [self.control_3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.control4 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.textLa.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control4];
    [self.control4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.control_4 = [[UIControl alloc]initWithFrame:CGRectMake(0, self.textLa.frame.origin.y, ScreenWidth, 40)];
    [self.contentView addSubview:self.control_4];
    [self.control_4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
  
    self.control1.tag =301;
    self.control_1.tag =401;
    self.control2.tag =302;
    self.control_2.tag =402;
    self.control3.tag =303;
    self.control_3.tag =403;
    self.control4.tag =304;
    self.control_4.tag =404;
}
- (void)congfig:(NSArray*)dataArr andIndex:(NSInteger)index{
    
    
    
    if (index == 1) {
        self.colorLabel.backgroundColor = [UIColor colorWithRed:0.36 green:0.99 blue:0.67 alpha:1];
        self.titleLabel.text  =@"   最新心理课";
        self.textLa.text = @"更多心理科";
        self.control1.hidden = NO;
        self.control2.hidden = NO;
        self.control3.hidden = NO;
        self.control_1.hidden = YES;
        self.control_2.hidden = YES;
        self.control_3.hidden = YES;
        
        self.control4.hidden = NO;
        self.control_4.hidden = YES;


    }else{
        self.colorLabel.backgroundColor =[UIColor colorWithRed:1 green:0.46 blue:0.3 alpha:1];
        self.titleLabel.text  =@"   最新FM";
        self.textLa.text = @"更多FM";
        self.control1.hidden = YES;
        self.control2.hidden = YES;
        self.control3.hidden = YES;
        self.control_1.hidden = NO;
        self.control_2.hidden = NO;
        self.control_3.hidden = NO;
        
        self.control4.hidden = YES;
        self.control_4.hidden = NO;

    }
    
    
    self.label1.text = [dataArr[0] objectForKey:@"title"];
    self.label_1.text = [dataArr[0] objectForKey:@"speak"];
    self.label2.text = [dataArr[1] objectForKey:@"title"];
    self.label_2.text = [dataArr[1] objectForKey:@"speak"];
    self.label3.text = [dataArr[2] objectForKey:@"title"];
    self.label_3.text = [dataArr[2] objectForKey:@"speak"];
    [self.bt1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[0] objectForKey:@"cover" ]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.bt2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[1] objectForKey:@"cover" ]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.bt3 sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataArr[2] objectForKey:@"cover" ]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}
- (void)click:(UIControl*)control{
    
    NSLog(@"-----%ld",control.tag);
    
    self.click(control.tag);
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
