//
//  MainLoadData.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "MainLoadData.h"
#import "Hoom.h"
@implementation MainLoadData

- (void)requestUpDataWithUrl{
    
  __block  NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:upUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // NSLog(@"responseObject = %@",responseObject);
        dic = (NSMutableDictionary*)responseObject;
        self.upData(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.upData(dic);
    }];
}



- (void)requestAllData{
    
    
    __block  NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:MainUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // NSLog(@"responseObject = %@",responseObject);
        dic = (NSMutableDictionary*)responseObject;
        self.data(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.data(dic);
    }];
}
@end
