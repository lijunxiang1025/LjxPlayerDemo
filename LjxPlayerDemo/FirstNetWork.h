//
//  FirstNetWork.h
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/28.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^returnData)(NSDictionary*dic);
typedef void(^returnDetailData)(NSDictionary*dic);
typedef void(^returnDetailXLKData)(NSDictionary*dic);
typedef void(^returnFMData)(NSDictionary*dic);
typedef void(^returnHotData)(NSDictionary*dic);

typedef void(^returnPlayerData)(NSDictionary*dic);

typedef void(^returnPlayerCellData)(NSDictionary*dic);


typedef void(^PlAYData)(NSDictionary*dic);
typedef void(^playData)(NSDictionary*dic);

@interface FirstNetWork : NSObject
- (void)loadFirstData;
- (void)loadDetailData:(NSInteger)index and:(NSInteger)offset;
//更多心理课
- (void)loadDetailXlkDataand:(NSInteger)offset;//数据回调
//更多FM
- (void)loadFMData:(NSInteger)offset;
//热门主播
- (void)loadHotPlayerData:(NSInteger)offset;
//主播详情
- (void)loadPlayerDetail:(NSString*)playerId;

- (void)loadPlayerCellDetail:(NSString*)playerId;



//播放数据请求
- (void)loadPlayData:(NSString*)playID;
//播放详情
- (void)loadPlayeWithUrl:(NSString*)playId;
@property(nonatomic,copy)returnData block;
@property(nonatomic,copy)returnDetailData block1;
@property(nonatomic,copy)returnDetailXLKData block2;
@property(nonatomic,copy)returnFMData fmblock;
@property(nonatomic,copy)returnHotData hotBlock;
@property(nonatomic,copy)returnPlayerData playerBlock;
@property(nonatomic,copy)returnPlayerCellData cellBlock;
//@property(nonatomic,copy)PlAYData playBlock;
@property(nonatomic,copy)playData playBlock;

@end
