//
//  DetailModel.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/30.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *cover;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *speak;
@property(nonatomic,copy)NSString *favnum;
@property(nonatomic,copy)NSString *viewnum;
@property(nonatomic,copy)NSString *is_teacher;
@property(nonatomic,copy)NSString *absolute_url;
@property(nonatomic,copy)NSString *url_list;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,strong)NSDictionary * diantai;


@end
