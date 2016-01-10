//
//  PlayViewController.m
//  XLFMDemo
//
//  Created by lijunxiang on 16/1/4.
//  Copyright © 2016年 lijunxiang. All rights reserved.
//
static NSString * playId = nil;


#import "PlayViewController.h"
#import "FirstNetWork.h"
#import "MyPlay.h"
#import "LjxUi.h"
#import "MySmallPlayView.h"
@interface PlayViewController ()

@property(nonatomic,strong)UIImageView* imageV;
@property(nonatomic,strong)NSTimer  *  imageVTimer;
@property(nonatomic)double jd;

@property(nonatomic,strong)UISlider *  slider;
@property(nonatomic,strong)NSTimer  *  sliderTimer;
@property(nonatomic)double sliderValue;


@end

@implementation PlayViewController

- (void)createNavBt{
    
    UIButton * bt =[LjxUi createButtonWithFrame:CGRectMake(10, 20, 15, 15) Target:self Action:@selector(goLast) ImageName:@"back" andTitle:nil];
    
    [self.view addSubview:bt];
}
- (void)goLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _jd =  0  ;
    _sliderValue = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    [self createNavBt];

    if (playId&&(playId==self.playId)) {
        //意味着重复进入
        //图片旋转位置
        //slider的位置
        MyPlay * myPlay = [MyPlay shareManager];
        _jd = [[myPlay.playDic  objectForKey:@"jd"] floatValue];
        
        
        _sliderValue = myPlay.play.currentTime/[[myPlay.playDic objectForKey:@"duration"] floatValue];
        _imageV.transform =CGAffineTransformMakeRotation(_jd);
        _slider.value =_sliderValue;
        //歌曲播放时 imageV的旋转动画 slider进度
        
        if (myPlay.play.isPlaying) {
            [self.imageVTimer invalidate ];
            self.imageVTimer = nil;
            self.imageVTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
            [self.imageVTimer fire];
        }else {
            //解决系统bug
            self.imageVTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:NO];
            [self.imageVTimer fire];
        }
      
        
        
        self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSliderValue) userInfo:nil repeats:YES];
        [self.sliderTimer fire];
        

        }else{
            [self addProgress];

            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                /*添加遮盖层*/
                
                [self loadData];
               
 
            }) ;
    }
}

- (void)addProgress{
    
    [self setupBaseKVNProgressUI];
    if ([self isFullScreen]) {
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"Loading...",
                                          KVNProgressViewParameterFullScreen: @(YES)}];
    } else {
        [KVNProgress showWithStatus:@"Loading..."];
    }
    
}
- (BOOL)isFullScreen{
    
    return NO;
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
}
//创建图片 和 slider
- (void)createView{
    
    self.imageV = [LjxUi createImageView:CGRectMake(20, 40, WIDTH-40, WIDTH-40) andName:@"ljx"];
                   //createImageView:CGRectMake(20, 40, WIDTH-40, WIDTH-40) backGroundImageV:@"ljx"];
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = (WIDTH-40)/2;
    [self.view addSubview:self.imageV];
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePlaying)];
    [self.imageV addGestureRecognizer:gesture];
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(20, WIDTH+30, WIDTH-40, 30)];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.minimumTrackTintColor = [UIColor yellowColor];
    self.slider.maximumTrackTintColor = [UIColor redColor];
    [self.view addSubview:self.slider];
    
    [self.slider addTarget:self action:@selector(sliderchange:) forControlEvents:UIControlEventValueChanged];

}
//点击暂停以及点击播放
- (void)changePlaying{
    MyPlay * play = [MyPlay shareManager];
    
    if (play.play==nil) {
        return;
    }
    if ([play.play isPlaying]) {
        [self.imageVTimer invalidate];
        self.imageVTimer = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程让UI开始刷新
            MySmallPlayView * manager = [MySmallPlayView shareManager];
            [manager imageStopChange];
            
        });
        [play playPuase];
    }else{
        self.imageVTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
        [self.imageVTimer fire];
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程让UI开始刷新
            MySmallPlayView * manager = [MySmallPlayView shareManager];
            [manager imageChangeView];
            
        });
        [play stillPlay];
    }
}

- (void)sliderchange:(UISlider*)slider{
    MyPlay * play = [MyPlay shareManager];
    
    if (play.play==nil) {
        //slider.value = 0;
        return;
    }
    
    play.play.currentTime = slider.value* [[play.playDic objectForKey:@"duration"] floatValue];
    
}




- (void)loadData{
    FirstNetWork * netWork = [[FirstNetWork alloc]init];
    //请求数据
    netWork.playBlock = ^(NSDictionary*dic){
        if ([[dic objectForKey:@"isOk"] intValue]==1) {
            if ([[[dic objectForKey:@"data"] objectForKey:@"code"] intValue]==0) {
                //数据正确
                MyPlay * play = [MyPlay shareManager];
                //用于记录上次进入的ID
                playId = self.playId;
                //play.playDic = [NSMutableDictionary dictionaryWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"data"]];
               
                [play.playDic setObject:@"792" forKey:@"duration"];
                [play.playDic setObject:[NSString stringWithFormat:@"%lf",_jd] forKey:@"jd"];
                [play.playDic setObject:[NSString stringWithFormat:@"%lf",_sliderValue] forKey:@"sliderValue"];
                //开始播放 图片开始旋转 进度条开始走
                [play createPlayWithUrl:@"http://cdn.lizhi.fm/audio/2014/01/09/8663524568517382_hd.mp3"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程让UI开始刷新
                    MySmallPlayView * manager = [MySmallPlayView shareManager];
                    [manager imageChangeView];
                    [KVNProgress dismiss];

                    
                });
                self.imageVTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
                [self.imageVTimer fire];
                self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSliderValue) userInfo:nil repeats:YES];
                [self.sliderTimer fire];

            }else{
                NSLog(@"数据错误");
            }
        }else{
            NSLog(@"请求失败");
        }
  
    };
    [netWork loadPlayData:self.playId];

}
- (void)xz{
    
    _jd+=0.005;
    self.imageV.transform = CGAffineTransformMakeRotation(M_PI*_jd);
    if (_jd==1) {
        _jd = 0;
    }
    
    
    MyPlay * play = [MyPlay shareManager];
    [play.playDic setObject:[NSString stringWithFormat:@"%lf",_jd] forKey:@"jd"];
    
}
- (void)changeSliderValue{
    
    if (_slider.touchInside) {
        //当我们手动操控slider的时候 那么就不让定时器给slider.value赋值
        return;
    }
    MyPlay * play = [MyPlay shareManager];
    NSTimeInterval duration = [[play.playDic objectForKey:@"duration"] doubleValue];
    _slider.value = play.play.currentTime /duration;
    //总时间减去播放时间 得到剩余时间
   //duration - play.play.currentTime;
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    MyPlay * play = [MyPlay shareManager];
    [play.playDic setObject:[NSString stringWithFormat:@"%lf",_jd] forKey:@"jd"];
    [self.imageVTimer invalidate];
    [self.sliderTimer invalidate];
    self.imageVTimer = nil;
    self.sliderTimer = nil;

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
