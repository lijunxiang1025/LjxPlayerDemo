//
//  ClockViewController.m
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "ClockViewController.h"
#import "RepeatDateViewController.h"

@interface ClockViewController ()

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.navigationItem.title = @"心情闹钟" ;
    
    [self createUI] ;
    
}

- (void)createUI
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 132)] ;
    backView.layer.cornerRadius = 10 ;
    backView.layer.borderWidth = 0.5 ;
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor ;
    backView.tag = 99 ;
    [self.view addSubview:backView] ;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 44)] ;
    label.text = @"闹钟开关" ;
    [backView addSubview:label] ;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults] ;
    
    UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(backView.frame.size.width-60, 5, 50, 30)] ;
    sw.on = [user boolForKey:@"isOn"] ;
    [sw addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged] ;
    sw.tag = 104 ;
    [backView addSubview:sw] ;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), backView.frame.size.width, 0.5)] ;
    lineView.backgroundColor = [UIColor lightGrayColor] ;
    [backView addSubview:lineView] ;
    
    UILabel * repeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, CGRectGetMaxY(lineView.frame), label.frame.size.width, label.frame.size.height)] ;
    repeatLabel.text = @"重复" ;
    repeatLabel.userInteractionEnabled = YES ;
    [backView addSubview:repeatLabel] ;
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, repeatLabel.frame.origin.y, backView.frame.size.width-110, repeatLabel.frame.size.height)] ;
    timeLabel.tag = 100 ;
    timeLabel.textAlignment = NSTextAlignmentRight ;
    timeLabel.textColor = [UIColor orangeColor] ;
    timeLabel.font = [UIFont systemFontOfSize:15] ;
    timeLabel.text = [self weekendDat] ;
    [backView addSubview:timeLabel] ;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)] ;
    [repeatLabel addGestureRecognizer:tap] ;
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(repeatLabel.frame), backView.frame.size.width, 0.5)] ;
    lineView2.backgroundColor = [UIColor lightGrayColor] ;
    [backView addSubview:lineView2] ;
    
    UILabel * settingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(repeatLabel.frame.origin.x, CGRectGetMaxY(lineView2.frame), repeatLabel.frame.size.width, repeatLabel.frame.size.height)] ;
    settingTimeLabel.text = @"时间" ;
    settingTimeLabel.userInteractionEnabled = YES ;
    [backView addSubview:settingTimeLabel] ;
    
    NSString * dateS = [user objectForKey:@"dateStr"] ;
    if (dateS.length==0 )
    {
        dateS = [self strFromDate:[NSDate date]] ;
    }
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.frame.origin.x, settingTimeLabel.frame.origin.y, timeLabel.frame.size.width, timeLabel.frame.size.height)] ;
    titleLabel.text = [user boolForKey:@"isOn"]?dateS:@"你现在还没有设置时间哦" ;
    titleLabel.textAlignment = NSTextAlignmentRight ;
    titleLabel.textColor = [UIColor orangeColor] ;
    titleLabel.tag = 101 ;
    [backView addSubview:titleLabel] ;
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)] ;
    [settingTimeLabel addGestureRecognizer:tap2] ;
    
    UIView * boomView = [[UIView alloc] initWithFrame:CGRectMake(10, ScreenHeight, ScreenWidth-20, 240)] ;
    boomView.backgroundColor = [UIColor lightGrayColor] ;
    boomView.tag = 102 ;
    [self.view addSubview:boomView] ;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    saveBtn.frame = CGRectMake(boomView.frame.size.width-100, 0, 80, 40) ;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal] ;
    [saveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [boomView addSubview:saveBtn] ;
    
    UIDatePicker * date = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(saveBtn.frame), boomView.frame.size.width, 200)] ;
    date.datePickerMode = UIDatePickerModeTime ;
    date.backgroundColor = [UIColor lightGrayColor] ;
    date.tag = 103 ;
    [boomView addSubview:date] ;
}

- (NSString *)weekendDat
{
    NSArray * array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSUserDefaults * users = [NSUserDefaults standardUserDefaults] ;
    NSArray * indexArray = [users arrayForKey:@"indexArray"] ;
    NSString * dateStr = @"";
    int i = 0 ;
    for (NSString * str in indexArray)
    {
        if ([str isEqualToString:@"1"])
        {
            dateStr = [dateStr stringByAppendingString:[NSString stringWithFormat:@" %@",array[i]]] ;
        }
        i++ ;
    }
    return dateStr ;
}

- (void)saveBtn:(UIButton *)saveBtn
{
    UIView * boomView = [self.view viewWithTag:102] ;
    UIDatePicker * datePicker = (id)[boomView viewWithTag:103] ;
    NSString * str = [self strFromDate:datePicker.date] ;
    
    UIView * backView = [self.view viewWithTag:99] ;
    
    UILabel * timeLabel = (id)[backView viewWithTag:101] ;
    timeLabel.text = str ;
    [UIView animateWithDuration:0.5 animations:^{
        boomView.frame = CGRectMake(10, ScreenHeight, ScreenWidth-20, 240) ;
    }] ;
    
    UISwitch * sw = (id)[backView viewWithTag:104] ;
    [sw setOn:YES animated:YES];
   
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults] ;
    [user setObject:str forKey:@"dateStr"] ;
    [user setBool:sw.isOn forKey:@"isOn"] ;
    [user synchronize] ;
    
    UILocalNotification * local = [[UILocalNotification alloc] init] ;
    local.fireDate = [[NSDate date] addTimeInterval:5.0] ;
    local.timeZone = [NSTimeZone localTimeZone] ;
    local.alertBody = @"傻逼" ;
    [[UIApplication sharedApplication] scheduleLocalNotification:local] ;
    
}

- (void)tap2:(UITapGestureRecognizer *)tap
{
    UIView * boomView = [self.view viewWithTag:102] ;
    [UIView animateWithDuration:0.5 animations:^{
        boomView.frame = CGRectMake(10, ScreenHeight-304, ScreenWidth-20, 240) ;
    }] ;
}


- (void)tap:(UITapGestureRecognizer *)tap
{
    RepeatDateViewController * repeatVC = [[RepeatDateViewController alloc] init] ;
    repeatVC.dateBlock = ^(NSString * dateStr){
        UIView * boomView = [self.view viewWithTag:99] ;
        UILabel * timeLabel = (id)[boomView viewWithTag:100] ;
        timeLabel.text = dateStr ;
    } ;
    [self.navigationController pushViewController:repeatVC animated:YES] ;
}

- (void)pressSwitch:(UISwitch *)sw
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults] ;
    [user setBool:sw.isOn forKey:@"isOn"] ;
    [user synchronize] ;
    
    UIView * backView = [self.view viewWithTag:99] ;
    
    UILabel * timeLabel = (id)[backView viewWithTag:101] ;
    
    NSString * str = [self strFromDate:[NSDate date]] ;
    
    timeLabel.text = sw.isOn?str:@"你现在还没有设置时间哦" ; ;
}

- (NSString *)strFromDate:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"HH:mm"] ;
    NSString * str = [formatter stringFromDate:date] ;
    
    NSArray * array = [str componentsSeparatedByString:@":"] ;
    if ([array[0] integerValue] > 11)
    {
        str = [str stringByAppendingString:@" 下午"] ;
    }
    else
    {
        str = [str stringByAppendingString:@" 上午"] ;
    }
    return str ;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView * boomView = [self.view viewWithTag:102] ;
    [UIView animateWithDuration:0.5 animations:^{
        boomView.frame = CGRectMake(10, ScreenHeight, ScreenWidth-20, 240) ;
    }] ;
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
