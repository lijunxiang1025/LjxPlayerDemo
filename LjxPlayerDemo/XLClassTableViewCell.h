//
//  XLClassTableViewCell.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UILabel *textLa;




@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label_2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label_3;





- (void)congfig:(NSArray*)dataArr andIndex:(NSInteger)index;
@end
