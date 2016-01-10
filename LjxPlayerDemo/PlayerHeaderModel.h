//
//  PlayerHeaderModel.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerHeaderModel : NSObject

@property(nonatomic,copy)NSString *absolute_url;
@property(nonatomic,copy)NSString *commentnum;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *cover;
@property(nonatomic,copy)NSString *favnum;
@property(nonatomic,copy)NSString *fmnum;
@property(nonatomic,copy)NSString *gcover   ;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *viewnum;
@property(nonatomic,strong)NSDictionary *user;



@end
