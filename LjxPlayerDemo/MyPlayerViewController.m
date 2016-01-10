//
//  MyPlayerViewController.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "MyPlayerViewController.h"
#import "MyPlayerView.h"
#import "FirstNetWork.h"
@interface MyPlayerViewController ()
{
    NSTimer  * timer;
}
@property(nonatomic,strong)UIImageView*backgroundImageV;

@property(nonatomic,strong)MyPlayerView * viewPlayer;

@property(nonatomic)NSTimeInterval  duration;
//进度条
@property(nonatomic,strong)UISlider * slider;
@end

@implementation MyPlayerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
  
    [self setStatuBarColor];
}
- (void)setStatuBarColor{
    //更改状态栏的颜色
    [commonUtils changeStatueBarBlack];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    _duration = 792.0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self setNeedsDisplay];
    self.backgroundImageV = [LjxUi createImageView:CGRectMake(0, 0, WIDTH, HEITHT) andName:@"sy.jpg"];
    //[self.view addSubview:self.backgroundImageV];
    
    //绘制贝斯曲线
    
    
    [self createView];
    [self setupBaseKVNProgressUI];
    [self createSlider];

    
   // self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
}
- (void)createSlider{
    
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(WIDTH/2-130, HEITHT/6+250+2*45+40, 260,20)];
    //设置最小进度值
    _slider.minimumValue = 0;
    //设置最大进度值
    _slider.maximumValue = 1;
    
    _slider.continuous  = NO;
    [_slider addTarget:self action:@selector(changeTime) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changgeSilder) userInfo:nil repeats:YES];
    [timer fire];

}
- (void)changeTime{
    MyPlayer* player = [MyPlayer shareManager];
    if (player.player) {
        //滑动时 滑到的位置即为播放的时间
        player.player.currentTime = self.duration * _slider.value;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"ffffff" alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)changgeSilder{
    MyPlayer* player = [MyPlayer shareManager];

    if(_slider.touchInside==1){
        //_slider.touchInside BOOL 1 表示手指在slider上 0表示没有在操控
        //当手指操控_slider的时候则停止计算播放时间的位置
        return;
    }
    _slider.value=player.player.currentTime/self
    .duration;
}


- (void)goLast{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playTimeStop" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
- (void)createView{
    _viewPlayer = [[MyPlayerView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEITHT)];
   
    __block MyPlayer* player1 = [MyPlayer shareManager];
    _viewPlayer.startBlcok= ^(){
        
        [player1 myPlayerContinuePlay];
        
    };
    _viewPlayer.stopBlcok=^(){
        [player1 myPlayerStop];
    };
    [self.view addSubview:_viewPlayer];

}




- (void)createPlayer:(NSString*)url{
    
    MyPlayer * player = [MyPlayer shareManager];
   [player playerWithUrl:url];
    
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

    [self loadData];
}
- (void)loadData{
    
    FirstNetWork * net = [[FirstNetWork alloc]init];
    net.playBlock= ^(NSDictionary *dic){
        
        [KVNProgress dismiss];
        
        if ([[dic objectForKey:@"isOk"] integerValue]==1) {
            
            if ([[[dic objectForKey:@"data"] objectForKey:@"code"] integerValue]==0) {
                
                NSLog(@"===----%@",[[dic objectForKey:@"data"] objectForKey:@"data"]);
                
                [self createPlayer:@"http://cdn.lizhi.fm/audio/2014/01/09/8663524568517382_hd.mp3"];
              
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"数据错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"真蠢" message:@"请求失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    };
    
    
    [net loadPlayeWithUrl:self.playerId];
    
    
    
    
}
-(BOOL)isFullScreen{
    return NO;
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
