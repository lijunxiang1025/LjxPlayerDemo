//
//  FindViewController.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "FindViewController.h"
#import "FindLoadData.h"
#import "UIButton+WebCache.h"
#import "FindTableViewCell1.h"
#import "FindTableViewCell2.h"
#import "FindTableViewCell3.h"
#import "SearchViewController.h"
#import "PlayViewController.h"
#define H 60
@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)    UITableView * tableView;
@property (strong, nonatomic)  UIPageControl *pageC;
@property (nonatomic,strong)   NSTimer * time;
@property (nonatomic,strong)   UIScrollView * sc ;
@property (nonatomic,strong)   NSMutableArray * upArr;
@property (nonatomic,strong)   NSMutableArray * mainPlayArr;

@end

@implementation FindViewController
- (void)viewWillAppear:(BOOL)animated{
    [self setStatuBarColor];
    [super viewWillDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"ffffff" alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self loadData];
    [self createView];
}
- (void)setStatuBarColor{
    //更改状态栏的颜色
    [commonUtils changeStatueBarWhite];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}
- (void)loadData{
    FindLoadData * load = [[FindLoadData alloc]init];
    [load   requestAllData];
    load.data = ^(NSMutableDictionary * dic,NSError * error){
        //请求错误
        if (error!=nil) {
            return ;
        }
        if(dic.count!=0){
        _upArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"data"]];
        [_upArr insertObject:[_upArr lastObject] atIndex:0];
        [_upArr addObject:_upArr[1]];
        [_tableView reloadData];
        }
    } ;
    [load requestMainPlayData];
    load.data1 = ^(NSMutableDictionary * dic,NSError * error){
        //请求错误
        if (error!=nil) {
            return ;
        }
        if(dic.count!=0){
            _mainPlayArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"data"]];
            [_tableView reloadData];
        }
    } ;
}
- (void)createView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView .dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator   = NO;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section   {
    return 0.5;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/3*2+H)];
    _sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenWidth/3*2)];
    _sc.contentSize = CGSizeMake(ScreenWidth*5, _sc.frame.size.height);
    _sc.showsHorizontalScrollIndicator=NO;
    _sc.showsVerticalScrollIndicator=NO;
    _sc.pagingEnabled=YES;
    _sc.contentOffset = CGPointMake(ScreenWidth, 0);
    _sc.bounces=NO;
    _sc.delegate=self;
    _sc.backgroundColor  = [UIColor blackColor];
    [view1 addSubview:_sc];
    _pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0,  _sc.frame.size.height-20, ScreenWidth,20)];
    _pageC.numberOfPages=3;
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    [view1 addSubview:_pageC];
    /*****假search 懒得建View*****/
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth/3*2+15, ScreenWidth, 40)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [LjxUi createLable:CGRectMake(10, 10, 200, 20) andFont:14 andTextAlignment:0 text:@"搜索主播名/节目名" andColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
    [view addSubview:label];
    [view1 addSubview:view];
    UIImageView * searchImageView = [LjxUi createImageView:CGRectMake(ScreenWidth-40, 12, 16, 16) andName:@"searching"];
    searchImageView.userInteractionEnabled = YES;
    [view addSubview:searchImageView];
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, ScreenWidth/3*2+15, ScreenWidth, 40)];
    [control addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:control];
    /*********结束**********/
    for (int i=0; i<5; i++) {
        
        UIButton* _upBt = [LjxUi createButtonWithFrame:CGRectMake(i%5*ScreenWidth, 0, ScreenWidth, ScreenWidth/3*2) Target:self Action:@selector(upBtClick:) ImageName:@"sy.jpg" andTitle:nil];
        _upBt.tag = 500 + i;
        if (_upArr) {
            [_upBt sd_setBackgroundImageWithURL:[_upArr[i] objectForKey:@"cover"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"sy.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        [_sc addSubview:_upBt];
    }
    if (_time==nil) {
        [self createDate];
    }
    return view1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenWidth/3*2+H;
}
- (void)createDate{
    _time = [NSTimer  scheduledTimerWithTimeInterval:4 target:self selector:@selector(goNextImageView) userInfo:nil repeats:YES];
}
- (void)goNextImageView{
    if (_pageC.currentPage==2) {
        _sc.contentOffset = CGPointMake(ScreenWidth, 0);
        _pageC.currentPage = 0;
        return;
    }
    _pageC.currentPage =_pageC.currentPage+1;
    [UIView animateWithDuration:0.5 animations:^{
        _sc.contentOffset = CGPointMake((_pageC.currentPage+1)*ScreenWidth,0);
    }];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 0) {
        FindTableViewCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"FindID1"];
        if (cell == nil) {
            cell = [[FindTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindID1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.block = ^(NSInteger tag){
            PlayViewController * myplayerVc =[[PlayViewController alloc]init];
            myplayerVc.playId = @"72";
            myplayerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myplayerVc animated:YES];
            NSLog(@"----心情");
        };
        return cell;
    }
    else if (indexPath.row == 1){
    FindTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"FindID2"];
    if (cell == nil) {
        cell = [[FindTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindID2"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.block = ^(NSInteger tag){
        PlayViewController * myplayerVc =[[PlayViewController alloc]init];
        myplayerVc.playId = @"72";
        myplayerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myplayerVc animated:YES];
        NSLog(@"----场景");

    };
    return cell;
    }
    FindTableViewCell3 * cell = [tableView dequeueReusableCellWithIdentifier:@"FindID3"];
    if (cell == nil) {
        cell = [[FindTableViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindID3"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.block = ^(NSInteger tag){
        NSLog(@"----主播");
        PlayViewController * myplayerVc =[[PlayViewController alloc]init];
        myplayerVc.playId = @"72";
        myplayerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myplayerVc animated:YES];
    };
    [cell config:_mainPlayArr];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}
- (void)upBtClick:(UIButton*)bt{
    
    
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
    switch (bt.tag-500) {
        case 0:
        {
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
    
}



- (void)goSearch{
    
    NSLog(@"----search");
    
    
    SearchViewController * searchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (_sc.contentOffset.x==0) {
        _sc .contentOffset = CGPointMake(ScreenWidth*4, 0);
        _pageC.currentPage=2;
    }
    if (_sc.contentOffset.x==ScreenWidth*4) {
        _sc .contentOffset = CGPointMake(ScreenWidth, 0);
        _pageC.currentPage=0;
    }
    if (_sc.contentOffset.x==ScreenWidth) {
        _pageC.currentPage=0;
    }
    if (_sc.contentOffset.x==ScreenWidth*2) {
        _pageC.currentPage=1;
    }
    if (_sc.contentOffset.x==ScreenWidth*3) {
        _pageC.currentPage=2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath     {
    if (indexPath.row==2) {
        return 250;
    }
    return ScreenWidth+30+15;
    
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
