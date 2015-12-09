//
//  FindLoadData.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/7.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestFindData)(NSMutableDictionary*dic,NSError * error);
typedef void (^requestMainPlayData)(NSMutableDictionary*dic,NSError * error);

@interface FindLoadData : NSObject
@property(nonatomic,copy)requestFindData  data;
@property(nonatomic,copy)requestMainPlayData  data1;

- (void)requestAllData;
- (void)requestMainPlayData;
@end
