//
//  NetObject.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "NetObject.h"

@implementation NetObject
+(NSInteger )checkNet{

   __block NSInteger  a = 1 ;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {   //wifi;
            
            break;
        }
        case AFNetworkReachabilityStatusUnknown:
        {
            //未知
            break;
        }
        case AFNetworkReachabilityStatusNotReachable:
        {
            //无连接
            a = 0;
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            //4G网
            a = 2;
            break;
        }
        default:
            break;
    
    }
}];
    return a;
    
}

@end
