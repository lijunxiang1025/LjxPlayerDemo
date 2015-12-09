//
//  FindTableViewCell3.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/8.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//
#define h 210
#import "FindTableViewCell3.h"
#import "UIImageView+WebCache.h"
@implementation FindTableViewCell3
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        
    }
    return self;
}
- (void)createView{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, ScreenWidth, 25)];
    [self.contentView addSubview:label];
    label.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    label.text = @"主播";
    label.font = [UIFont systemFontOfSize:16];
    
    UIImageView * nextImageV = [LjxUi createImageView:CGRectMake(ScreenWidth-30, 7, 8, 15) andName:@"detail"];
    [self.contentView addSubview:nextImageV];
    
    for (int i = 0; i<6; i++) {
        UIImageView * imageView = [LjxUi createImageView:CGRectMake(10+i%2*(10+ScreenWidth/2), 30+10+70*(i/2), 60, 60) andName:@"sy.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 30;
        imageView.tag = 1100+i;
        [self.contentView addSubview:imageView];
        float _w = imageView.frame.size.width+imageView.frame.origin.x;
        float _h = imageView.frame.size.width/2+imageView.frame.origin.y;

        UILabel * label = [LjxUi createLable:CGRectMake(5+_w , _h-15, 100, 15) andFont:12 andTextAlignment:0 text:@"最美" andColor:[UIColor blackColor]];
        label.tag = 800 +i;
        [self.contentView addSubview:label];
        
        UILabel * label1 = [LjxUi createLable:CGRectMake(5+_w , _h+1, 100, 20) andFont:12 andTextAlignment:0 text:@"李思雨" andColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1]];
        label1.tag = 900 +i;
        [self.contentView addSubview:label1];
        
        
        
        UIControl * control = [[UIControl     alloc]initWithFrame:CGRectMake(i%2*ScreenWidth/2, 30+i/2*70, ScreenWidth/2, 70)];
        [control addTarget:self action:@selector(goOther:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = 1000+i;
        [self.contentView addSubview:control];
    }
    
}


- (void)goOther:(UIControl*)control{
    
    self.block(control.tag);
    
}


- (void)config:(NSMutableArray*)dataArr{
    
    
    
    for (int i = 0 ; i < 9; i++) {
        
        UIImageView * imageV = [self.contentView viewWithTag:1100+i];
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:[dataArr[i] objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"sy.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        UILabel * label =   [self.contentView viewWithTag:800+i];
        label.text = [dataArr[i] objectForKey:@"title"];
        UILabel * label1 =   [self.contentView viewWithTag:900+i];
        label1.text = [NSString stringWithFormat:@"节目%@",[dataArr[i] objectForKey:@"fmnum"]];
        
    }
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
