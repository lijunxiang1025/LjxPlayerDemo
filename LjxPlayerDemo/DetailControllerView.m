//
//  DetailControllerView.m
//  XLFMDemo
//
//  Created by lijunxiang on 15/12/30.
//  Copyright © 2015年 lijunxiang. All rights reserved.
//

#import "DetailControllerView.h"
#import "FirstNetWork.h"
#import "DeatailCell.h"
#import "DetailModel.h"
#import "MyPlayerViewController.h"
#import "PlayViewController.h"
@interface DetailControllerView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic)NSInteger offset;
@end

@implementation DetailControllerView

//导航出来
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return 0;
//    
//}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
   // [[UIApplication sharedApplication] setStatusBarStyle:0];
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
    UIButton * bt =  [LjxUi createButtonWithFrame:CGRectMake(0, 0, 24, 24) Target:self Action:@selector(goLast) ImageName:@"back" andTitle:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bt];
}
- (void)goLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //标识请求第几段
    _offset = 0;
    [self createNav];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    _dataArray = [NSMutableArray array];

    
    
    
    commonUtils * utils = [[commonUtils  alloc]init];
    utils.block = ^(NSInteger index){
        if (index ==1||index==2) {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                //当下拉刷新的图出现的时候回调会走这里
                //将数组重置为空 刷新的段数也置为0
                _offset = 0;
                [_dataArray removeAllObjects];
                
                //判断点击哪个按钮进入此页面 是8个按钮还是更多心理课
                if (self.number == 0) {
                    [self loadData:_offset];
                }else if(self.number ==1){
                    [self loadXlkData:_offset];
                }else if(self.number ==2){
                    [self loadFMData:_offset];
                }
                
            }];
            [self.tableView.mj_header beginRefreshing];
            //追加尾部刷新
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                //每一次刷新则 offset++ 请求下一段数据
                _offset+=15;
                if (self.number == 0) {
                    [self loadData:_offset];
                }else if(self.number ==1){
                    [self loadXlkData:_offset];
                }else if (self.number ==2){
                    [self loadFMData:_offset];
                }
                
            }];
            self.tableView.mj_footer.hidden = YES;
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真穷" message:@"连网费都出不起！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    };
    [utils checkNet];
}
//当标识符为number为0 则为8个按钮
- (void)loadData:(NSInteger)offset{
    
    FirstNetWork * netWork = [[FirstNetWork alloc]init];
    netWork.block1 = ^(NSDictionary* dic){
        
    if ([[dic objectForKey:@"isOk"] integerValue]==1) {
            
    if ([[[dic objectForKey:@"data"] objectForKey:@"code"] integerValue]==0) {
        for (NSDictionary * dic1 in [[dic objectForKey:@"data"] objectForKey:@"data"]) {
            DetailModel * model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
          
            [_dataArray addObject:model];
        }
        self.tableView.mj_footer.hidden = NO;

        [self.tableView reloadData];
        }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"数据错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
                
            }
    }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"请求失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        //判断是头部还是尾部刷新

        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header  endRefreshing];
        }else{
        [self.tableView.mj_footer     endRefreshing];
      }

    };
    //将下拉或则上拉第几段传入请求
    [netWork loadDetailData:self.index and:offset];
}
//当标识符为number为1 则刷新心理课
- (void)loadXlkData:(NSInteger)offset{
    FirstNetWork * netWork = [[FirstNetWork alloc]init];
    netWork.block2 = ^(NSDictionary* dic){
        
        if ([[dic objectForKey:@"isOk"] integerValue]==1) {
            if ([[[dic objectForKey:@"data"] objectForKey:@"code"] integerValue]==0) {
                for (NSDictionary * dic1 in [[dic objectForKey:@"data"] objectForKey:@"data"]) {
                    DetailModel * model = [[DetailModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic1];
                    [_dataArray addObject:model];
                }
                self.tableView.mj_footer.hidden = NO;

                [self.tableView reloadData];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"数据错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"请求失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        //判断是头部还是尾部刷新
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header  endRefreshing];
        }else{
            [self.tableView.mj_footer     endRefreshing];
        }
    };
    //将下拉或则上拉第几段传入请求
    [netWork loadDetailXlkDataand:offset];
}
//请求更多FM数据
-(void)loadFMData:(NSInteger)offset{
    FirstNetWork * netWork = [[FirstNetWork alloc]init];
    netWork.fmblock = ^(NSDictionary* dic){
        
        if ([[dic objectForKey:@"isOk"] integerValue]==1) {
            if ([[[dic objectForKey:@"data"] objectForKey:@"code"] integerValue]==0) {
                for (NSDictionary * dic1 in [[dic objectForKey:@"data"] objectForKey:@"data"]) {
                    DetailModel * model = [[DetailModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic1];
                    [_dataArray addObject:model];
                }
                self.tableView.mj_footer.hidden = NO;
                
                [self.tableView reloadData];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"数据错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"请求失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        //判断是头部还是尾部刷新
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header  endRefreshing];
        }else{
            [self.tableView.mj_footer     endRefreshing];
        }
    };
    //将下拉或则上拉第几段传入请求
    [netWork loadFMData:offset];
}
- (void)createView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEITHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle    = 0;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeatailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DeatailCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = 0;
    if (_dataArray.count!=0) {
        [cell config:_dataArray[indexPath.row]];

    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
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
