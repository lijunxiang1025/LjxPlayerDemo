//
//  MyNav.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 15/12/30.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "MyNav.h"

@interface MyNav ()

@end

@implementation MyNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"BarColor"] intValue]==1) {
        return 1;

    }
    return 0;
    
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
