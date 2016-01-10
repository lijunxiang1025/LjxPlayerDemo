//
//  PlayerDeatailViewController.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/1.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "PlayerDeatailViewController.h"
#import "FirstNetWork.h"
#import "PlayerHeaderModel.h"
#import "PlayerCellModel.h"
#import "PlayerDetailV.h"
#import "PlayerDetailCell.h"
#import "MyPlayerViewController.h"
@interface PlayerDeatailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * headerArray;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation PlayerDeatailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNav];
}
- (void)goLast{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [UIColor whiteColor];
    _headerArray = [NSMutableArray array];
    _dataArray  = [NSMutableArray array];
    [self setupBaseKVNProgressUI];
    [self createTableView];
    [self loadData];
}

- (void)setupBaseKVNProgressUI
{
    // See the documentation of all appearance propoerties
    [KVNProgress appearance].statusColor = [UIColor darkGrayColor];
    [KVNProgress appearance].statusFont = [UIFont systemFontOfSize:17.0f];
    [KVNProgress appearance].circleStrokeForegroundColor = [UIColor darkGrayColor];
    [KVNProgress appearance].circleStrokeBackgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3f];
    [KVNProgress appearance].circleFillBackgroundColor = [UIColor clearColor];
    [KVNProgress appearance].backgroundFillColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
    [KVNProgress appearance].backgroundTintColor = [UIColor whiteColor];
    [KVNProgress appearance].successColor = [UIColor darkGrayColor];
    [KVNProgress appearance].errorColor = [UIColor darkGrayColor];
    [KVNProgress appearance].circleSize = 75.0f;
    [KVNProgress appearance].lineWidth = 2.0f;
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"Loading...",
                                     KVNProgressViewParameterBackgroundType: @(KVNProgressBackgroundTypeSolid),
                                     KVNProgressViewParameterFullScreen: @([self isFullScreen])}];
}
-(BOOL)isFullScreen{
    return NO;
}
- (void)createNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"ffffff" alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton * bt = [LjxUi createButtonWithFrame:CGRectMake(0, 0, 24, 24) Target:self Action:@selector(back) ImageName:@"back" andTitle:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bt  ];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 请求数据
- (void)loadData{
    commonUtils * untils = [[commonUtils alloc]init];
    //检查网络状态
    untils.block = ^(NSInteger index){
        if (index ==1||index ==2) {
                FirstNetWork * netWork  =[[FirstNetWork alloc]init];
                netWork.playerBlock = ^(NSDictionary* dic){
                if ([[dic objectForKey:@"isOk"] intValue]==1) {
                        NSDictionary * dic1 = [[dic objectForKey:@"data"] objectForKey:@"data"];
                        PlayerHeaderModel * model =[[PlayerHeaderModel alloc]init];
                        [model setValuesForKeysWithDictionary:dic1];
                        [_headerArray addObject:model];
                        [self loadCellData];
                    }else{
                        NSLog(@"请求失败%@",[[dic objectForKey:@"data"] objectForKey:@"error"]);
                        //不论数据是否请求成功都停止刷新
                        [KVNProgress dismiss];
                    }
                };
                [netWork loadPlayerDetail:self.playerId];
        }
    };
    [untils checkNet];
}
- (void)loadCellData{
    FirstNetWork * netWork  =[[FirstNetWork alloc]init];
    netWork.cellBlock = ^(NSDictionary* dic){
        if ([[dic objectForKey:@"isOk"] intValue]==1) {
            for (NSDictionary *dic1 in [[dic objectForKey:@"data"] objectForKey:@"data"]) {
                PlayerCellModel  * model = [[PlayerCellModel alloc]init];
                NSLog(@"-----%@",[dic objectForKey:@"data"]);
                [model setValuesForKeysWithDictionary:dic1];
                [_dataArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
            NSLog(@"请求失败%@",[[dic objectForKey:@"data"] objectForKey:@"error"]);
        }
        //不论数据是否请求成功都停止刷新
        [KVNProgress dismiss];
        [self.tableView.mj_header endRefreshing];
    };
    [netWork loadPlayerCellDetail:self.playerId];
}
#pragma mark 创建UI
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEITHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"playerID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PlayerDetailCell" owner:self options:nil]lastObject];
    }
    if (_dataArray.count>0) {
        [cell config:_dataArray[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PlayerDetailV * view = [[PlayerDetailV alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 254)];
    if (_headerArray.count>0) {
        [view config:_headerArray[0]];
    }
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPlayerViewController * myplayerVc =[[MyPlayerViewController alloc]init];
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 254.0;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"ffffff" alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
