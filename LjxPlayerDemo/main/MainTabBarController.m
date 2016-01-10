//
//  MainTabBarController.m
//  LjxPlayerDemo
//
//  Created by MS on 15/11/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyNav.h"
@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate=self;
    self.tabBar.barStyle=UIBarStyleBlack;
}

- (instancetype)initWithSelectImageArr:(NSArray*)imageArray andUnSelectImageArr:(NSArray*)unSelectImageArr andViewControllerArr:(NSArray*)viewControllerArr andTitleNameArr:(NSArray*)titleArr{
    
    if (self = [super init]) {
        [self configWithSelectImageArr:imageArray andUnSelectImageArr:unSelectImageArr andViewControllerArr:viewControllerArr andTitleNameArr:titleArr];
    }
    return self;
}

-(void)configWithSelectImageArr:(NSArray*)imageArray andUnSelectImageArr:(NSArray*)unSelectImageArr andViewControllerArr:(NSArray*)viewControllerArr andTitleNameArr:(NSArray*)titleArr{
    
    NSMutableArray * _viewArr = [NSMutableArray array];
    for (int i =0; i<viewControllerArr.count; i++) {
        NSString * viewName = viewControllerArr[i];
        Class Vc = NSClassFromString(viewName);
        UIViewController * _vc = [[Vc alloc]init];
        _vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[[UIImage imageNamed:unSelectImageArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:imageArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        MyNav * _nav = [[MyNav alloc]initWithRootViewController:_vc];
        [_viewArr addObject:_nav];
        if (i==2) {
            _vc.navigationController.navigationBar.hidden=NO;

        }else if (i ==4){

            //_nav.navigationItem.title = titleArr[i];
            _vc.navigationItem.title = titleArr[i];
          _vc.navigationController.navigationBar.hidden=NO;

        }else{
            _vc.navigationController.navigationBar.hidden=YES;
        }
        [_vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:3]} forState:UIControlStateSelected];
         [_vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
       
    }
    
    self.viewControllers = _viewArr;
    
    
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
