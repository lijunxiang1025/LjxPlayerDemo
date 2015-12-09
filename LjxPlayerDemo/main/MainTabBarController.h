//
//  MainTabBarController.h
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController


//对TabBar初始化

- (instancetype)initWithSelectImageArr:(NSArray*)imageArray andUnSelectImageArr:(NSArray*)unSelectImageArr andViewControllerArr:(NSArray*)viewControllerArr andTitleNameArr:(NSArray*)titleArr;


@end
