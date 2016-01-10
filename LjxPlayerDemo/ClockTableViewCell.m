//
//  ClockTableViewCell.m
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "ClockTableViewCell.h"

@interface ClockTableViewCell ()
@property (strong,nonatomic) UIView * backView ;
@end

@implementation ClockTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 88)] ;
        _backView.layer.cornerRadius = 10 ;
        _backView.layer.borderWidth = 0.5 ;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor ;
        [self.contentView addSubview:_backView] ;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom] ;
        button.frame = CGRectMake(0, 0, _backView.frame.size.width, 44);
        [button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside] ;
        [_backView addSubview:button] ;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)] ;
        imageView.image = [UIImage imageNamed:@"_0007_time"] ;
        [button addSubview:imageView] ;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 0, _backView.frame.size.width-imageView.frame.size.width-10, 44)] ;
        label.text = @"心情闹钟" ;
        [button addSubview:label] ;
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), _backView.frame.size.width, 0.5)] ;
        lineView.backgroundColor = [UIColor lightGrayColor] ;
        [_backView addSubview:lineView] ;
        
        UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(lineView.frame)+11, imageView.frame.size.width, imageView.frame.size.height)] ;
        imageView2.image = [UIImage imageNamed:@"clock"] ;
        [_backView addSubview:imageView2] ;
        
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, CGRectGetMaxY(lineView.frame), label.frame.size.width, label.frame.size.height)] ;
        label2.text = @"定时开关" ;
        [_backView addSubview:label2] ;
        
        UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(_backView.frame.size.width-60, CGRectGetMaxY(lineView.frame)+5, 50, 30)];
        [sw addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged] ;
        [_backView addSubview:sw] ;
    }
    return self ;
}

- (void)pressBtn:(UIButton *)btn
{
    self.btnBlock(btn) ;
}

- (void)clickSwitch:(UISwitch *)sw
{
    self.block(sw) ;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
