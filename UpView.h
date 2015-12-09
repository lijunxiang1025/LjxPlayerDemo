//
//  UpView.h
//  LjxPlayerDemo
//
//  Created by MS on 15/12/1.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^returnBtClick)(NSInteger);
@interface UpView : UIView
@property(nonatomic,copy)returnBtClick block;
@end
