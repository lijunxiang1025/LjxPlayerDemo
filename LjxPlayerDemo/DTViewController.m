//
//  DTViewController.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/31.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "DTViewController.h"
#import "DTMoreCell.h"
#import "FirstNetWork.h"
#import "DTModel.h"
#import "PlayerDeatailViewController.h"
#import "PlayViewController.h"
@interface DTViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * playerArray;

@property(nonatomic)NSInteger offset;
@end

@implementation DTViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setStatuBarColor];
}


- (void)setStatuBarColor{
    //更改状态栏的颜色
    [commonUtils changeStatueBarBlack];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}
- (void)createNav{
   
    UIButton * bt = [LjxUi createButtonWithFrame:CGRectMake(0, 0, 24, 24) Target:self Action:@selector(goLast) ImageName:@"back" andTitle:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bt];
}
- (void)goLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEITHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray array];
    self.playerArray = [NSMutableArray array];
    _offset = 0;
    
    
    commonUtils * untils = [[commonUtils alloc]init];
    //检查网络状态
    untils.block = ^(NSInteger index){
        if (index ==1||index ==2) {
            
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _offset = 0;
                [_dataArray removeAllObjects];
                [_playerArray removeAllObjects];
                [self loadData:_offset];
                
                
            }];
            
            [self.tableView.mj_header beginRefreshing];
            
            
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                _offset+=10;
                [self loadData:_offset];
                
            }];
            self.tableView.mj_footer.hidden = YES;
            
            
        }else{
           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"你没有网!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
           
//            if (alert == nil){
//              alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"你没有网!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            }
            
            
            //delegate
            //alert = nil;
        }
        
        
        
        
        
        
    };
    [untils checkNet];
    
    // Do any additional setup after loading the view.
}

- (void)loadData:(NSInteger)offset{
    
    
    FirstNetWork * netWork  =[[FirstNetWork alloc]init];
    netWork.hotBlock = ^(NSDictionary* dic){
        
        if ([[dic objectForKey:@"isOk"] intValue]==1) {
            for (NSDictionary *dic1 in [[dic objectForKey:@"data"] objectForKey:@"data"]) {
                DTModel * model = [[DTModel alloc]init];
                [model setValuesForKeysWithDictionary:dic1];
                [_dataArray addObject:model];
                [_playerArray addObject:[dic1 objectForKey:@"id"]];
                
            }
            [self.tableView reloadData];
            self.tableView.mj_footer.hidden = NO;
        }else{
            NSLog(@"请求失败%@",[[dic objectForKey:@"data"] objectForKey:@"error"]);
        }
        //不论数据是否请求成功都停止刷新
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    };
    [netWork loadHotPlayerData:offset];
}

#pragma mark tbleView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DTMoreCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DTMoreCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = 0;
    
    if (_dataArray.count > 0) {
        [cell config:_dataArray[indexPath.row]];

    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerDeatailViewController *playerVc= [[PlayerDeatailViewController alloc]init];
    DTModel * model = _dataArray[indexPath.row];
    
    playerVc.playerId = _playerArray[indexPath.row];
    
    [self.navigationController pushViewController:playerVc animated:YES];
    
    
    
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
