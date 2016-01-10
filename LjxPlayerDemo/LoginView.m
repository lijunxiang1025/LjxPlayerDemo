//
//  LoginView.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self  = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
        self.userInteractionEnabled = YES;
        [self.weibo addTarget:self action:@selector(weiboLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.qq addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.weixin addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];

        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self setFrame:frame];
        
    }
    return self;
    
}
- (void)weiboLogin{
    self.block(0);
}
- (void)qqLogin{
    self.block(1);
}
-(void)weixinLogin{
    self.block(2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
