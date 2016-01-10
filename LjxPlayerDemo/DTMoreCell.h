//
//  DTMoreCell.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/31.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTModel.h"
@interface DTMoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

- (void)config:(DTModel*)model;
@end
