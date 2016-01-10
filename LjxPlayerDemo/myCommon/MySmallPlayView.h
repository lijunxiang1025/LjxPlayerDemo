//
//  MySmallPlayView.h
//  XLFMDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MySmallPlayView : NSObject

+(instancetype)shareManager;

@property(nonatomic,strong)UIImageView * imageV;
@property(nonatomic,strong)NSTimer * timer;
//为了控制切换图片
@property(nonatomic)NSInteger index;
//创建imageView
- (void)creteImageVWithCGRECT:(CGRect)rect;
//定时器控制
- (void)imageChangeView;
- (void)imageStopChange;


@end
