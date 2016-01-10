//
//  MyPlayer.h
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MyPlayer : NSObject<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer * player;


+ (instancetype)shareManager;

- (AVAudioPlayer*)playerWithUrl:(NSString*)url;


- (void)myPlayerStop;

- (void)myPlayerContinuePlay;

- (BOOL)myPlayerIsPlaying;
- (void)setTime:(NSInteger)goTime;
@end
