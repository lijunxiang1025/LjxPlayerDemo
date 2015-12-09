//  ViewController.m
//  LjxPlayerDemo
//  Created by MS on 15/11/25.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "ViewController.h"
#import "MainTabBarController.h"
@interface ViewController ()<UIScrollViewDelegate >
{
    //启动页面
    UIScrollView * _sc;
    UIPageControl* _pageC;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
        [self createSc];

    
    
    
    
    
}
- (void)createSc{
    _sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _sc.contentSize=CGSizeMake(ScreenWidth*3,ScreenWidth);
    _sc.showsHorizontalScrollIndicator=NO;
    _sc.showsVerticalScrollIndicator=NO;
    _sc.pagingEnabled=YES;
    _sc.bounces=NO;
    _sc.delegate=self;
    _sc.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_sc];
    _pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(40, ScreenHeight-40, ScreenWidth-40*2, 20)];
    [self.view addSubview:_pageC];
    _pageC.numberOfPages=3;
    _pageC.currentPageIndicatorTintColor = [UIColor colorWithRed:0.4 green:0.78 blue:0.6 alpha:1];
    for (int i=0; i<3; i++) {
        UIImageView*imageView1=[LjxUi createImageView:CGRectMake(i%3*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) andName:nil];
        if (i==0) {
            imageView1.image=[UIImage imageNamed:@"xiong1.png"];
            
        }else{
            imageView1.image=[UIImage imageNamed:[NSString stringWithFormat:@"xiong%d",i+1]];
        }
        [_sc addSubview:imageView1];
        if (i==2) {
            UIButton*button=[LjxUi createButtonWithFrame:CGRectMake((ScreenWidth-100)/2, self.view.frame.size.height-100, 100, 40) Target:self Action:@selector(goMain)  ImageName:@"input_bg" andTitle:@"立即体验" ];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 8;
            [button setTitleColor:[UIColor colorWithRed:0.11 green:0.17 blue:0.26 alpha:1] forState:UIControlStateNormal];
            [imageView1 addSubview:button];
        }
    }
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_sc.contentOffset.x==0) {
        _pageC.currentPage=0;
    }
    if (_sc.contentOffset.x==self.view.frame.size.width) {
        _pageC.currentPage=1;
    }
    if (_sc.contentOffset.x==self.view.frame.size.width*2) {
        _pageC.currentPage=2;
    }
    
}

-(void)goMain{
    
    
//    MainTabBarController * mainTabBar = [[MainTabBarController alloc]initWithSelectImageArr:@[@"homeSelected@2x",@"foundSelected@2x",@"communitySelected@2x",@"mySelected@2x",@"installSelected@2x"] andUnSelectImageArr:@[@"home@2x",@"found@2x",@"community@2x",@"my@2x",@"install@2x"] andViewControllerArr:@[@"HoomViewController@2x",@"FindViewController@2x",@"CommunityViewController@2x",@"MyViewController@2x",@"InstallViewController@2x"] andTitleNameArr:@[@"首页",@"发现",@"社区",@"我的",@"设置"]];
//    
//    
//    [self presentViewController:mainTabBar animated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goMain" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
