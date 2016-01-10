//
//  PlayerCellModel.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerCellModel : NSObject
@property(nonatomic,copy)NSString *absolute_url;
@property(nonatomic,copy)NSString *background;
@property(nonatomic,copy)NSString *cover;
@property(nonatomic,copy)NSString *favnum;
@property(nonatomic)BOOL  is_teacher;
@property(nonatomic,copy)NSString *speak;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *viewnum;
@property(nonatomic,strong)NSArray * url_list;

@end
