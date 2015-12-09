//
//  FindTableViewCell2.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/8.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickBlock)(NSInteger);

@interface FindTableViewCell2 : UITableViewCell
@property(nonatomic,copy)clickBlock block;
@end
