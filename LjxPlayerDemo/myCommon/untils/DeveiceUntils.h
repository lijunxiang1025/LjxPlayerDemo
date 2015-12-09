//
//  DeveiceUntils.h
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeveiceUntils : NSObject



+ (CGFloat)getIOSVersion;
#pragma mark 判断存储软件版本是否是当前版本
+ (BOOL)isNowSoftVersion;
@end
