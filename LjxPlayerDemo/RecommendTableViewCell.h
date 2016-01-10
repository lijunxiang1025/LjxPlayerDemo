//
//  RecommendTableViewCell.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/2.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btClick)(NSInteger);
@interface RecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *la1;

@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;


@property(nonatomic,copy)btClick click;
- (void)congfig:(NSArray*)dataArray;
@end
