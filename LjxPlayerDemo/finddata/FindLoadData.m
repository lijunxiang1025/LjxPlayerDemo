//
//  FindLoadData.m
//  LjxPlayerDemo
//
//  Created by MS on 15/12/7.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "FindLoadData.h"
#import "Find.h"
@implementation FindLoadData
- (void)requestAllData{
    
      __block  NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:findUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        self.data(dic,nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
        self.data(dic,error);
    }];
}


- (void)requestMainPlayData{
    
    __block  NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:MainPlayUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        self.data1(dic,nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
        self.data1(dic,error);
    }];
    
    
}
@end
