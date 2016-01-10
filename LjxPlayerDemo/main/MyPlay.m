//
//  MyPlay.m
//  XLFMDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 lijunxiang. All rights reserved.
//
//IdefineID   卡顿
#import "MyPlay.h"
static MyPlay * manager;

static NSString * playUrl = nil;

@implementation MyPlay
+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyPlay alloc]init];
        manager.playDic = [NSMutableDictionary dictionary];
        
    });
    return manager;
}

//创建播放器
- (void)createPlayWithUrl:(NSString*)url{

    if (playUrl ==url) {
        
    }else{
        playUrl = url;
        if (manager.play) {
            [manager.play stop];
            manager.play = nil;
        }
        manager.play = [[AVAudioPlayer alloc]initWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]] error:nil];
        manager.play.delegate = manager;
        [manager.play prepareToPlay];
        [manager.play play];
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    manager.play.currentTime = 0;
    [manager.play play];
    
    
    
}



//暂停
- (void)playPuase{
    if (manager.play) {
        [manager.play pause];
    }
}
//播放
- (void)stillPlay{
    if (manager.play) {
        [manager.play play];
    }
}
//设置播放时间
- (void)setCurrentTimeToPlay:(NSTimeInterval)time1{
    if (manager.play) {
        manager.play.currentTime = time1;
    }
}


@end
