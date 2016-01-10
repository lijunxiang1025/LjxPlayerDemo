//
//  NetObject.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "NetObject.h"

@implementation NetObject
-(void )checkNet{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {   //wifi;
            self.block(1);
        }
            break;
        case AFNetworkReachabilityStatusUnknown:
        {
            //未知
            self.block(3);
        }
            break;

        case AFNetworkReachabilityStatusNotReachable:
        {
            //无连接
            self.block(0);
            
        }
            break;

        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            //4G网
            self.block(2);
        }
            break;

        default:
            break;
    
    }
}];
    
    
    
    
}

@end
