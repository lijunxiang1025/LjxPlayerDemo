//
//  MySmallPlayView.m
//  XLFMDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 lijunxiang. All rights reserved.
//

#import "MySmallPlayView.h"
static MySmallPlayView * manager;
@implementation MySmallPlayView

+(instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MySmallPlayView alloc]init];
        manager.index = 0;
    });
    return manager;
}

- (void)creteImageVWithCGRECT:(CGRect)rect{
    if (manager.imageV) {
        manager.imageV.frame = rect;
        return;
    }
    manager.imageV = [LjxUi createImageView:rect andName:@"littlePlaying1@2x" ];
                      
                   //   createImageView:rect backGroundImageV:@"littlePlaying1@2x"];
}

-(void)imageChangeView{
    manager.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:manager selector:@selector(changeImage) userInfo:nil repeats:YES];
    [manager.timer fire];
}
- (void)changeImage{
    manager.index++;
    if (manager.index==7) {
        manager.index = 1;
    }
    manager.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"littlePlaying%ld@2x",manager.index]];
}

- (void)imageStopChange{
    
    [manager.timer invalidate];
    manager.timer = nil;
    
}

@end
