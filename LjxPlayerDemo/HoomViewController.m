//
//  HoomViewController.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "HoomViewController.h"
#import "MainLoadData.h"
#import "UpDataModel.h"
#import "UIButton+WebCache.h"
#import "UpView.h"
#import "RadioTableViewCell.h"
#import "XLClassTableViewCell.h"
#import "RecommendTableViewCell.h"
#import "DetailControllerView.h"
#import "DTViewController.h"
#import "PlayViewController.h"
#define  _h 3.5
#define  _h1 4.2
//static int number;
@interface HoomViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  UITableView * tableView;
@property (strong, nonatomic)  UIPageControl *pageC;
@property (nonatomic,strong)   NSTimer * time;
@property (nonatomic,strong)   UIScrollView *upScrollView;

//数据
@property (nonatomic,strong)NSMutableArray * upDataArray;
@property (nonatomic,strong)NSMutableArray * hotDataArray;
@property (nonatomic,strong)NSMutableArray * nXClassArray;
//NSMutableArray * newXClassDataArray;
@property (nonatomic,strong)NSMutableArray * nFMDataArray;
@property (nonatomic,strong)NSMutableArray * recommendDataArray;


@property(nonatomic,strong)NSDictionary* dicAll;

@property(nonatomic,strong)UIAlertView * alert;
@end

@implementation HoomViewController

- (void)viewWillAppear:(BOOL)animated{
    [commonUtils changeStatueBarWhite];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNeedsStatusBarAppearanceUpdate];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createTableView];
    //开始头部刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NetObject * netCheck = [[NetObject alloc]init];
        netCheck.block = ^ (NSInteger index){
            if (index  == 0) {
                [self.tableView.mj_header endRefreshing];
                _alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前网络状态不佳" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [_alert show];
            }
            else{
                [self loadData];
            }
        };
        [netCheck checkNet];
    }];
    
    NetObject * netCheck = [[NetObject alloc]init];
    netCheck.block = ^ (NSInteger index){
        if (index  == 0) {
            [self.tableView.mj_header endRefreshing];
            _alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前网络状态不佳" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [_alert show];
        }
        else{
            [self loadData];
        }
    };
    [netCheck checkNet];
}
#pragma mark 创建tableView
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.view.autoresizesSubviews = NO;
    [self.view addSubview:_tableView];
}


#pragma mark tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return 4;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3    ) {
     RadioTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"radioID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RadioTableViewCell" owner:self options:nil] firstObject];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dtBlock = ^(NSInteger index){
        if (index ==605) {
            DTViewController * vc = [[DTViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationItem.title = @"发现主播";
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"更多主播");
        }else{
            PlayViewController * myplayerVc =[[PlayViewController alloc]init];
            myplayerVc.playId = @"72";
            myplayerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myplayerVc animated:YES];
        }
        
        
        
        
        
        };
    [cell configWith:_recommendDataArray];
    return cell;
    }else if(indexPath.row ==1){
        XLClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XLC"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"XLClassTableViewCell" owner:self options:nil] firstObject];;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell congfig:_nXClassArray andIndex:indexPath.row];
        cell.click = ^(NSInteger index){
            //更多心理课
            
            DetailControllerView * vc = [[DetailControllerView alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.number = 1;
            vc.navigationItem.title = @"最新心理课";
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        };
        return cell;
    }else if (indexPath.row==2){
        XLClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XLC"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"XLClassTableViewCell" owner:self options:nil] firstObject];;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell congfig:_nFMDataArray andIndex:indexPath.row];
        cell.click = ^(NSInteger index){
          //更多FM
            
            DetailControllerView * vc = [[DetailControllerView    alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            //用于标识这是心理FM页面
            vc.number = 2;
            vc.navigationItem.title  = @"最新心理FM";
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            
        };
        return cell;
    }else{
        RecommendTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Rec"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RecommendTableViewCell" owner:self options:nil] firstObject];;
        }
        cell.click= ^(NSInteger index){
            PlayViewController * myplayerVc =[[PlayViewController alloc]init];
            myplayerVc.playId = @"72";
            myplayerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myplayerVc animated:YES];
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell congfig:_hotDataArray ];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if(indexPath.row ==3){
    return  180.0;
    } else if (indexPath.row ==0){
        return 178;
    }
    else{
        return 210.0;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * imageView = [LjxUi createImageView:CGRectMake(0, 0, ScreenWidth, ScreenHeight/_h+ScreenHeight/_h1) andName:nil];
    _upScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight/_h)];
    _upScrollView.contentSize = CGSizeMake(ScreenWidth*5, _upScrollView.frame.size.height);
    _upScrollView.showsHorizontalScrollIndicator=NO;
    _upScrollView.showsVerticalScrollIndicator=NO;
    _upScrollView.pagingEnabled=YES;
    _upScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    _upScrollView.bounces=NO;
    _upScrollView.delegate=self;
    _upScrollView.backgroundColor  = [UIColor blackColor];
    [imageView addSubview:_upScrollView];
    // NSLog(@"%f``",_upScrollView.frame.size.width);
    
    _pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0,  _upScrollView.frame.size.height-20, ScreenWidth,20)];
    _pageC.numberOfPages=3;
    //_pageC.backgroundColor = [UIColor redColor];
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    [imageView addSubview:_pageC];
    
    NSUserDefaults * _default = [NSUserDefaults standardUserDefaults];
    NSMutableArray * _arr =[NSMutableArray arrayWithArray:[_default objectForKey:@"homeUpImageArray"]]  ;
    if (_arr.count>0){
        [_arr insertObject:[_arr lastObject] atIndex:0];
        
        [_arr addObject:_arr[1]];
    }
    for (int i=0; i<5; i++) {
        UIButton* _upBt = [LjxUi createButtonWithFrame:CGRectMake(i%5*ScreenWidth, 0, ScreenWidth, ScreenHeight/_h) Target:self Action:@selector(upBtClick:) ImageName:@"broadcasterBg" andTitle:nil];
        _upBt.tag = 100 + i;
        if (_arr.count !=0) {
            [_upBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[_arr[i]objectForKey:@"cover"]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        [_upScrollView addSubview:_upBt];
    }
    if (_time==nil) {
        [self createDate];
    }
    UpView * view = [[UpView alloc]initWithFrame:CGRectMake(0, ScreenHeight/_h, ScreenWidth, ScreenHeight/_h1)];
    view.block = ^ (NSInteger index){

        NSLog(@"%ld",index);
        DetailControllerView * vc = [[DetailControllerView alloc]init];
        vc.number =0;
        vc.hidesBottomBarWhenPushed = YES;
        vc.index = index -200+1;
        [self.navigationController pushViewController:vc animated:YES];
    
    };
    view.backgroundColor = [UIColor whiteColor];
    [imageView addSubview:view];
    
    MySmallPlayView * manager =[MySmallPlayView shareManager];
    [manager creteImageVWithCGRECT:CGRectMake(WIDTH-40, 20, 20, 20)];
    [imageView addSubview:manager.imageV];
    return imageView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenHeight/_h+ScreenHeight/_h1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark请求数据
- (void)loadData{
    //请求头部数据
    [self.tableView.mj_header beginRefreshing];
    MainLoadData * load = [[MainLoadData alloc]init];
    [load requestUpDataWithUrl];
    load.upData = ^(NSDictionary*dic){
       
        
    };
    [load requestAllData];
    load.data = ^(NSDictionary*dic1){
        
        [self reloadData:[dic1 objectForKey:@"data"]];
        [self reloadButton:[[dic1 objectForKey:@"data"] objectForKey:@"tuijian"]];
        self.dicAll = [NSMutableDictionary dictionaryWithDictionary:dic1];
        [self.tableView.mj_header endRefreshing];
    };
}
- (void)reloadButton:(NSArray*)arr{
    NSUserDefaults * _default = [NSUserDefaults standardUserDefaults];
    [_default setObject:arr forKey:@"homeUpImageArray"];
    [_default synchronize];
    _upDataArray = [NSMutableArray array];
    for (NSDictionary *dic in arr){
        UpDataModel * model = [[UpDataModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_upDataArray addObject:model];
    }
    if (_upDataArray.count>0) {
        [_upDataArray insertObject:[_upDataArray lastObject] atIndex:0];
        [_upDataArray addObject:_upDataArray[1]];
    }
    for (int i =0; i<_upDataArray.count; i++) {
        UpDataModel * model = _upDataArray[i];
        UIButton * bt = (UIButton *)[_upScrollView viewWithTag:100+i];
        [bt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"broadcasterBg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }

}
- (void)reloadData:(NSDictionary*)dic1{
    if (dic1.count>4) {
        _hotDataArray = [dic1 objectForKey:@"hotfm"];
        _recommendDataArray = [dic1 objectForKey:@"diantai"];
        _nXClassArray = [dic1 objectForKey:@"newlesson"];
        _nFMDataArray = [dic1 objectForKey:@"newfm"];
        [self.tableView  reloadData];
    }
}


#pragma  mark 创建SC
- (void)upBtClick:(UIButton*)bt{
    if (_upDataArray.count==0) {
        NSLog(@"无数据");
    }
    NSLog(@"==%@",self.dicAll);
    
    
    NSString * playerId;
    switch (bt.tag-100) {
        case 0:
        {
            //3
            playerId =  [[[[self.dicAll objectForKey:@"data"] objectForKey:@"tuijian"]objectAtIndex:2] objectForKey:@"id"];
        }
            break;
        case 1:
        {
            playerId =  [[[[self.dicAll objectForKey:@"data"] objectForKey:@"tuijian"]objectAtIndex:0] objectForKey:@"id"];

        }
            break;
        case 2:
        {
            playerId =  [[[[self.dicAll objectForKey:@"data"] objectForKey:@"tuijian"]objectAtIndex:1] objectForKey:@"id"];
        }
            break;
        case 3:
        {
            playerId =  [[[[self.dicAll objectForKey:@"data"] objectForKey:@"tuijian"]objectAtIndex:2] objectForKey:@"id"];

        }
            break;
        case 4:
        {
            //0
            playerId =  [[[[self.dicAll objectForKey:@"data"] objectForKey:@"tuijian"]objectAtIndex:0] objectForKey:@"id"];

        }
            break;
        default:
            break;
    }
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
//    myplayerVc.playId = playerId;
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (_upScrollView.contentOffset.x==0) {
        _upScrollView .contentOffset = CGPointMake(ScreenWidth*4, 0);
        _pageC.currentPage=2;
    }
    if (_upScrollView.contentOffset.x==ScreenWidth*4) {
        _upScrollView .contentOffset = CGPointMake(ScreenWidth, 0);
        _pageC.currentPage=0;
    }
    if (_upScrollView.contentOffset.x==ScreenWidth) {
        _pageC.currentPage=0;
    }
    if (_upScrollView.contentOffset.x==ScreenWidth*2) {
        _pageC.currentPage=1;
    }
    if (_upScrollView.contentOffset.x==ScreenWidth*3) {
        _pageC.currentPage=2;
    }
}


#pragma mark 创建定时器
- (void)createDate{
    _time = [NSTimer  scheduledTimerWithTimeInterval:4 target:self selector:@selector(goNextImageView) userInfo:nil repeats:YES];
    //[_time fire];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
    
}

- (void)goNextImageView{
    if (_pageC.currentPage==2) {
        _upScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        _pageC.currentPage = 0;
        return;
    }
    _pageC.currentPage =_pageC.currentPage+1;
    
    
    [UIView animateWithDuration:0.5 animations:^{
         _upScrollView.contentOffset = CGPointMake((_pageC.currentPage+1)*ScreenWidth,0);
    }];
   
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
