//
//  RepeatDateViewController.h
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepeatDateViewController : UIViewController

@property (copy,nonatomic) void (^dateBlock)(NSString *);

@end
