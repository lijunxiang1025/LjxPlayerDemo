//
//  MyPlay.h
//  XLFMDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MyPlay : NSObject<AVAudioPlayerDelegate>

@property(nonatomic,strong)AVAudioPlayer * play;

@property(nonatomic,strong)NSMutableDictionary * playDic;
+(instancetype)shareManager;

//创建播放器
- (void)createPlayWithUrl:(NSString*)url;
//暂停
- (void)playPuase;
//播放
- (void)stillPlay;
//设置播放时间
- (void)setCurrentTimeToPlay:(NSTimeInterval)time1;


@end
