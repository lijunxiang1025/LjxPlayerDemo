//
//  SearchViewController.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "SearchViewController.h"
#import "MyPlayerViewController.h"
#import "PlayViewController.h"
@interface SearchViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField * textFiled;
@end

@implementation SearchViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)setBarStyle{
    
    [commonUtils changeStatueBarBlack];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;

    self.automaticallyAdjustsScrollViewInsets = NO;

    [self createNav];
    [self setBarStyle];

}
- (void)createNav{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton * bt =[LjxUi createButtonWithFrame:CGRectMake(0, 0, 0, 0) Target:nil Action:NULL ImageName:@"" andTitle:@""];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bt  ];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
- (void)createView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
      [self.view addSubview:view];

    UIImageView *imageView = [LjxUi createImageView:CGRectMake(10, 24, ScreenWidth-80, 30) andName:nil];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5;
    [view addSubview:imageView];
    UIImageView * searchImageView = [LjxUi createImageView:CGRectMake(5, 7.5, 15, 15) andName:@"searching"];
    searchImageView.userInteractionEnabled = YES;
    [imageView addSubview:searchImageView];
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(25, 5, ScreenWidth-105, 20)];
    self.textFiled.placeholder = @"搜索主播名/节目名字";
    self.textFiled.clearButtonMode =UITextFieldViewModeAlways;
    [self.textFiled becomeFirstResponder];
    self.textFiled.userInteractionEnabled=YES;
    [imageView addSubview:self.textFiled];
    self.textFiled.delegate = self;
    UIButton * bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame =CGRectMake(ScreenWidth-60,24 ,50, 30);
    [bt1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //bt1.backgroundColor = [UIColor redColor];
    [bt1 setTitle:@"取消" forState:UIControlStateNormal];
    [bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt1 setTitleEdgeInsets:UIEdgeInsetsMake(-5, -5, 0, 0)];
    [view addSubview:bt1];
 
    NSArray * titleArr =@[@"热恋",@"沙朵",@"孤独",@"情绪",@"难过",@"高考",@"难过"];
    for (int i = 0; i<6 ; i++) {
        UIButton * bt2 = [LjxUi createButtonWithFrame:CGRectMake(20+i%3*60, 80+i/3*40, 50, 30) Target:self Action:@selector(click) ImageName:@"act" andTitle:titleArr[i]];
        bt2.layer.masksToBounds =YES;
        bt2.layer.cornerRadius =3;
        bt2.layer.borderWidth =1;
        bt2.titleLabel.font =[UIFont systemFontOfSize:12];
        bt2.layer.borderColor= (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]);
        [bt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:bt2];
        
    }
    
}

- (void)click{
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if (textField.text.length !=0) {
        
    }
    PlayViewController * myplayerVc =[[PlayViewController alloc]init];
    myplayerVc.playId = @"72";
    myplayerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myplayerVc animated:YES];
    
    
    return YES;
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
