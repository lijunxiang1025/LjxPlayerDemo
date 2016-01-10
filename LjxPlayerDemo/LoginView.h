//
//  LoginView.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^loginBlock)(NSInteger);
@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UIButton *weibo;
@property (weak, nonatomic) IBOutlet UIButton *qq;
@property (weak, nonatomic) IBOutlet UIButton *weixin;

@property(nonatomic,copy)loginBlock block;
@end
