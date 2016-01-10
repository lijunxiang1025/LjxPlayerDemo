//
//  MyPlayer.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "MyPlayer.h"
static MyPlayer * manager;
@implementation MyPlayer


+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyPlayer alloc]init];
    });
    return manager;
}
- (AVAudioPlayer*)playerWithUrl:(NSString*)url{
    
    if (manager.player!=nil) {
        [manager.player stop];
        manager.player = nil;
    }
    manager.player=[[AVAudioPlayer alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingMappedIfSafe error:nil] error:nil];
    [manager.player prepareToPlay];
    [manager.player play];
    manager.player.delegate =manager;
    return self.player;
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    
    manager.player.currentTime = 0;
    [manager.player prepareToPlay];
    [manager.player play];
    
    
}
- (void)myPlayerStop{
    if (manager.player) {
        [manager.player pause];
    }
 
}
- (void)setTime:(NSInteger)goTime{
    if (manager.player!=nil) {
        [manager.player stop];
        manager.player = nil;
    }
    manager.player=[[AVAudioPlayer alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://yiapi.xinli001.com/fm/media-url/1/857"] options:NSDataReadingMappedIfSafe error:nil] error:nil];
    manager.player.currentTime = goTime;
    [manager.player prepareToPlay];
    [manager.player play];
    
    
    
}
- (void)myPlayerContinuePlay{
    
    if (manager.player) {
        [manager.player play];

    }
    
}

- (BOOL)myPlayerIsPlaying{
    
    
    return [manager.player isPlaying];
    
    
    
    
}


@end
