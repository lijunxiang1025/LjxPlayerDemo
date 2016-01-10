//
//  commonUtils.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/28.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^returnState)(NSInteger);

@interface commonUtils : NSObject




+(BOOL)isFirstBuldVesion;

//白状态栏
+(void)changeStatueBarWhite;
//黑状态栏
+(void)changeStatueBarBlack;
//判断网络方法
-(void )checkNet;

@property(nonatomic,copy)returnState block;



+(UIImage*)returnFilterImage:(UIImage*)image;
@end
