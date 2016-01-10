//
//  ClockTableViewCell.h
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockTableViewCell : UITableViewCell

@property (copy,nonatomic) void (^block)(UISwitch *) ;

@property (copy,nonatomic) void (^btnBlock)(UIButton *) ;


@end
