//
//  MainLoadData.h
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requestUpViewData)(NSMutableDictionary*dic);
typedef void (^requestAllData)(NSMutableDictionary*dic);

@interface MainLoadData : NSObject



- (void)requestUpDataWithUrl;
@property(nonatomic,copy)requestUpViewData  upData;

- (void)requestAllData;
@property(nonatomic,copy)requestAllData  data;
@end
