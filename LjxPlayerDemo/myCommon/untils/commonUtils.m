//
//  commonUtils.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/28.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "commonUtils.h"

@implementation commonUtils


+(BOOL)isFirstBuldVesion{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Vesion"]) {
        
        NSString * systemVesion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
        
        BOOL isFirstV = [systemVesion isEqualToString:[defaults objectForKey:@"Vesion"]];
        //不论是不是当前版本 都存入新值
        [defaults setObject:systemVesion forKey:@"Vesion"];
        [defaults synchronize];
        
        //比较存入的版本号是否相同 如果相同则进入tabBar页面否则进入滚动视图
        if (isFirstV) {
            return NO;
        }
        return YES;
    }
    NSString * systemVesion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    [defaults setObject:systemVesion forKey:@"Vesion"];
    [defaults synchronize];
    
    return YES;
}


-(void )checkNet{
    
    
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    NSLog(@"有网：%d",[manager isReachable]);
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

+(void)changeStatueBarWhite{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"BarColor"];
    [defaults synchronize];
}
+(void)changeStatueBarBlack{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"BarColor"];
    [defaults synchronize];
}

//图片处理
+(UIImage*)returnFilterImage:(UIImage*)image{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
@end
