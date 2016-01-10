//
//  InstallHeaderView.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/10.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "InstallHeaderView.h"

@implementation InstallHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        

       self  = [[[NSBundle mainBundle] loadNibNamed:@"InstallHeaderView" owner:self options:nil] lastObject];
        self.label1.hidden = YES;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self setFrame:frame];

    }
    return self;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
