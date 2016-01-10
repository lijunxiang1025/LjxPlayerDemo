//
//  FirstNetWork.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/28.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "FirstNetWork.h"
#define FirstUrl @"http://yiapi.xinli001.com/fm/home-list.json?key=c0d28ec0954084b4426223366293d190"


//8个按钮
#define DetailUrl @"http://yiapi.xinli001.com/fm/category-jiemu-list.json?key=c0d28ec0954084b4426223366293d190&offset=%ld&category_id=%ld"
//更多心理课
#define XLKUrl @"http://bapi.xinli001.com/fm2/broadcast_list.json/?rows=15&offset=%ld&is_teacher=1&key=c0d28ec0954084b4426223366293d190"

#define FMUrl @"http://bapi.xinli001.com/fm2/broadcast_list.json/?rows=15&offset=%ld&is_teacher=0&key=c0d28ec0954084b4426223366293d190"
//热门主播
#define HOTPlayer @"http://yiapi.xinli001.com/fm/diantai-hot-list.json?key=c0d28ec0954084b4426223366293d190&limit=10&offset=%ld"

#define PlayerDetail @"http://yiapi.xinli001.com/fm/diantai-detai.json?key=046b6a2a43dc6ff6e770255f57328f89&id=%@"
#define PlayerCell  @"http://yiapi.xinli001.com/fm/diantai-jiemu-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=0&diantai_id=%@&limit=10"
#define Play @"http://yiapi.xinli001.com/fm/diantai-detai.json?key=046b6a2a43dc6ff6e770255f57328f89&id=%@"
#define PlayUrl @"http://yiapi.xinli001.com/fm/broadcast-detail-old.json?key=c0d28ec0954084b4426223366293d190&id=%@"

@implementation FirstNetWork

-(void)loadFirstData{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [manager GET:FirstUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.block(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.block(dic);

    }];
}


-(void)loadDetailData:(NSInteger)index and:(NSInteger)offset{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:DetailUrl,offset,index] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.block1(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.block1(dic);
        
    }];
}


-(void)loadDetailXlkDataand:(NSInteger)offset{

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:XLKUrl,offset] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.block2(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.block2(dic);
    }];

}
-(void)loadFMData:(NSInteger)offset{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:FMUrl,offset] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.fmblock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.fmblock(dic);
    }];

}
- (void)loadHotPlayerData:(NSInteger)offset{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:HOTPlayer,offset] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.hotBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.hotBlock(dic);
    }];
}

- (void)loadPlayerDetail:(NSString*)playerId{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:PlayerDetail,playerId] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.playerBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.playerBlock(dic);
    }];
    
}
- (void)loadPlayerCellDetail:(NSString*)playerId{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:PlayerCell,playerId] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.cellBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.cellBlock(dic);
    }];
    
}


- (void)loadPlayeWithUrl:(NSString*)playId{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:Play,playId] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.playBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.playBlock(dic);
    }];
    
}
//请求播放数据的方法
- (void)loadPlayData:(NSString *)playID{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [manager GET:[NSString stringWithFormat:PlayUrl,@"72"] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [dic setObject:@"1" forKey:@"isOk"];
        [dic setObject:responseObject forKey:@"data"];
        self.playBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [dic setObject:@"0" forKey:@"isOk"];
        [dic setObject:error forKey:@"data"];
        self.playBlock(dic);
    }];
    
    
}
@end
