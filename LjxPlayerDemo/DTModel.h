//
//  DTModel.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/31.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTModel : NSObject
@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* cover;
@property(nonatomic,copy) NSString* favnum;
@property(nonatomic,copy) NSString* fmnum;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* user_id;
@property(nonatomic,copy) NSString* viewnum;
@property(nonatomic,strong)NSDictionary * user;


@end
