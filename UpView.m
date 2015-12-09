//
//  UpView.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/1.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "UpView.h"
#import "UIButton+WebCache.h"
#define w 40
@interface UpView ()

@property(nonatomic,strong)NSArray * dataArray;

@end
@implementation UpView



- (instancetype)initWithFrame:(CGRect)frame{
    
    
    
    if (self = [super initWithFrame:frame]) {
        [self loadData];
        [self createSelf];
        
    }
    
    return  self;
}
//导入数据
- (void)loadData{
    
    self.dataArray = @[
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/143236a3b4ab51542065ad.png",
                           @"flag" : @"0",
                           @"id" : @"1",
                           @"name" : @"自我成长",
                           @"sort" : @"100"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/1812518bed0d80ba92b442.png",
                           @"flag" : @"0",
                           @"id" : @"2",
                           @"name" : @"情绪管理",
                           @"sort" : @"99"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/1813419d495c3a731032b2.png",
                           @"flag" : @"0",
                           @"id" : @"3",
                           @"name" : @"人际沟通",
                           @"sort" : @"98"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/1814013e4bdc25715cef5c.png",
                           @"flag" : @"0",
                           @"id" : @"4",
                           @"name" : @"恋爱婚姻",
                           @"sort" : @"97"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/181421e84186ee0a27a4c1.png",
                           @"flag" : @"0",
                           @"id" : @"5",
                           @"name" : @"职场管理",
                           @"sort" : @"96"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/181441aa708ec4e9a81a1d.png",
                           @"flag" : @"0",
                           @"id" : @"6",
                           @"name" : @"亲子家庭",
                           @"sort" : @"95"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/1814587c54292cf01ba4a9.png",
                           @"flag" : @"0",
                           @"id" : @"7",
                           @"name" : @"心理科普",
                           @"sort" : @"94"
                           },
                       @{
                           @"cover" : @"http://image.xinli001.com/20150706/181523f84c6958f491c8b6.png",
                           @"flag" : @"0",
                           @"id" : @"8",
                           @"name" : @"课程讲座",
                           @"sort" : @"93"
                           }
                       ];
    
    
    
}
- (void)createSelf{
    for (int i =0 ; i< 8; i++) {
        float _w = (ScreenWidth-4*w)/5;
        float _h = (ScreenHeight/4.2 -2*w)/3;
        UIButton * bt = [LjxUi createButtonWithFrame:CGRectMake(i%4*w + _w*(i%4+1), _h + i/4*(_h+w)-_h/2 , w, w) Target:self Action:@selector(btClick:) ImageName:nil andTitle:nil];
        bt.tag = 200+i;
        [bt sd_setImageWithURL:[NSURL URLWithString:[self.dataArray[i] objectForKey:@"cover"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"]];
        
        
        UILabel * label = [LjxUi createLable:CGRectMake(i%4*w + _w*(i%4+1)-5, _h + i/4*(_h+w)-_h/2+w+2 , w+10, _h/2) andFont:10 andTextAlignment:1 text:[self.dataArray[i] objectForKey:@"name"] andColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1]];
        [self addSubview:label];
        [self addSubview:bt];
    }
}

- (void)btClick:(UIButton*)bt{
        
    _block(bt.tag);
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
