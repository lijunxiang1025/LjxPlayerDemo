//
//  PlayerDetailV.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerHeaderModel.h"
@interface PlayerDetailV : UIView
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (void)config:(PlayerHeaderModel*)model;
@end
