//
//  PlayerDetailCell.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerCellModel.h"
@interface PlayerDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;


- (void)config:(PlayerCellModel*)model;
@end
