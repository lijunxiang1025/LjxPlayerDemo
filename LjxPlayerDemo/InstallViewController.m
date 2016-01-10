//
//  InstallViewController.m
//  LjxPlayerDemo
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "InstallViewController.h"
#import "InstallHeaderView.h"
#import "ClockTableViewCell.h"
#import "ClockViewController.h"
#import "CleanTableViewCell.h"
#import "ShareTableViewCell.h"
#import "LoginView.h"
#import "UMSocial.h"
#define headH 102
@interface InstallViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic)BOOL isUp;
@property(nonatomic,strong)LoginView * loginV;

@end

@implementation InstallViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden= NO;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isUp = NO;
    self.navigationItem.title = @"设置";
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    _loginV = [[LoginView alloc]initWithFrame:CGRectMake(0, HEITHT+20, WIDTH, 100)];
    _loginV.block = ^(NSInteger index){
        
        
        NSString *platformName;
        
        if (index ==0) {
            platformName = UMShareToSina;
        }else if(index ==1){
            platformName = UMShareToQzone;
        }else{
            platformName = UMShareToWechatSession;
        }
        [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            //          获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                NSLog(@"username is %@, uid is %@, token is %@ iconUrl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"qq" message:[NSString stringWithFormat:@"username is %@, uid is %@, token is %@ iconUrl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [self goOther];
            }
            //这里可以获取到腾讯微博openid,Qzone的token等
            
             if ([platformName isEqualToString:UMShareToTencent]) {
             [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
             NSLog(@"get openid  response is %@",respose);
             }];
             }
            
            
        });
  
        
    };
    [self.view addSubview:_loginV];
}

- (void)createView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0)
    {
        ClockTableViewCell * cell = [[ClockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"clock"] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.block = ^(UISwitch * sw){
            NSLog(@"******") ;
        } ;
        cell.btnBlock = ^(UIButton *btn){
            ClockViewController * clockVC = [[ClockViewController alloc] init] ;
            clockVC.hidesBottomBarWhenPushed = YES ;
            [self.navigationController pushViewController:clockVC animated:YES] ;
        } ;
        
        return cell ;
    }
    else if(indexPath.section == 1)
    {
        CleanTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"CleanTableViewCell" owner:self options:nil] firstObject] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.block = ^{
            NSLog(@"点击") ;
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"清理成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        } ;
        return cell ;
    }
    else
    {
        ShareTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ShareTableViewCell" owner:self options:nil] firstObject] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.block = ^(){
            NSLog(@"点击") ;
            
            //创建分享参数
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"568a6fb4e0f55ace3400075b"
                                              shareText:@"你要分享的文字"
                                             shareImage:[UIImage imageNamed:@"icon.png"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                               delegate:self];
            
            
        } ;
        return cell ;
    }
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 88.5 ;
    }
    else
    {
        return 44 ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        return  headH+40;
    }
    else
        return 10 ;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , headH+40)];
        InstallHeaderView * view1 = [[InstallHeaderView alloc]initWithFrame:CGRectMake(10, 35, ScreenWidth-20, 100)];
        [view addSubview:view1];
        UIControl * control =[[UIControl alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , headH+40)];
        [control addTarget:self action:@selector(goOther) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:control];
        return view ;
    }
    else
        return nil ;
}

- (void)goOther{
    
    if (_isUp==NO) {
        [UIView animateWithDuration:0.5 animations:^{
            _loginV.frame = CGRectMake(0, HEITHT-100, WIDTH, 100);
            self.tabBarController.tabBar.hidden =YES;

        }];
        _isUp= YES;
    }else{

        [UIView animateWithDuration:0.5 animations:^{
            _loginV.frame = CGRectMake(0, HEITHT+20, WIDTH, 100);
            self.tabBarController.tabBar.hidden =NO;

        }];
        _isUp= NO;
    }
    
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
