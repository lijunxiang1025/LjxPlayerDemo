//
//  RadioTableViewCell.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnBt)(NSInteger);
@interface RadioTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIButton *bt4;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *goOther;

@property(nonatomic,copy)returnBt dtBlock;

- (void)configWith:(NSArray*)dataArr;

@end
