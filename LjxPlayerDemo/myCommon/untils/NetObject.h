//
//  NetObject.h
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^returnState)(NSInteger);
@interface NetObject : NSObject

-(void )checkNet;
@property(nonatomic,copy)returnState block;
@end
