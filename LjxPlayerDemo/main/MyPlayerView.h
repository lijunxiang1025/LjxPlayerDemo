//
//  MyPlayerView.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^playerStart)();
typedef void (^playerStop)();

@interface MyPlayerView : UIView

@property(nonatomic,strong)UIBezierPath * path;
@property(nonatomic)float number;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)NSTimer * time;

@property(nonatomic)BOOL isPlay;
@property(nonatomic,copy)playerStart startBlcok;
@property(nonatomic,copy)playerStop stopBlcok;


@end
