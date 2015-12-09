//
//  DeveiceUntils.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "DeveiceUntils.h"

@implementation DeveiceUntils


+ (CGFloat)getIOSVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}



+ (BOOL)isNowSoftVersion{
    //获取字典版本
    NSUserDefaults * _default =[NSUserDefaults standardUserDefaults];
    NSString * _bundleVersion  = [_default  objectForKey:@"bundleVersion"];
    //获取系统版本
   NSString * _bundleVer =   [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    BOOL _isEqualVersion =  [_bundleVer isEqualToString:_bundleVersion];
    
    [_default setObject:_bundleVer forKey:@"bundleVersion"];
    
    return _isEqualVersion;
}
@end
