//
//  DeatailCell.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/30.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface DeatailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
- (void)config:(DetailModel*)model;
@end
