//
//  RepeatDateViewController.m
//  LjxPlayerDemo
//
//  Created by smith on 15/12/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "RepeatDateViewController.h"

@interface RepeatDateViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView * table ;
@property (strong,nonatomic) NSArray * dataArray ;
@property (strong,nonatomic) NSMutableArray * indexArray ;

@end

@implementation RepeatDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.dataArray = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil] ;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = CGRectMake(0, 0, 25, 30) ;
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal] ;
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted] ;
    [button addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside] ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button] ;
    
    [self.view addSubview:self.table] ;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults] ;
    NSArray * array = [user arrayForKey:@"indexArray"] ;
    if (array.count == 0)
    {
        NSArray * indexs = @[@"0",@"0",@"0",@"0",@"0",@"0",@"0"];
        [user setObject:indexs forKey:@"indexArray"] ;
        [user synchronize] ;
    }
    self.indexArray = [NSMutableArray arrayWithArray:[user arrayForKey:@"indexArray"]] ;
}
- (void)backBtn:(UIButton *)btn
{
    NSArray * array = [NSArray arrayWithArray:self.indexArray] ;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults] ;
    [user setObject:array forKey:@"indexArray"] ;
    [user synchronize] ;
    
    NSString * dateStr = @"";
    int i = 0 ;
    for (NSString * str in self.indexArray)
    {
        if ([str isEqualToString:@"1"])
        {
            dateStr = [dateStr stringByAppendingString:[NSString stringWithFormat:@" %@",self.dataArray[i]]] ;
        }
        i++ ;
    }
    self.dateBlock(dateStr) ;
    
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (UITableView *)table
{
    if (!_table)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _table.delegate = self ;
        _table.dataSource = self ;
        _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero] ;
        _table.scrollEnabled = NO ;
    }
    return _table ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
    }
    cell.textLabel.text = self.dataArray[indexPath.row] ;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    NSString * indexStr = self.indexArray[indexPath.row] ;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)] ;
    imageView.image = [UIImage imageNamed:[indexStr isEqualToString:@"1"]?@"checked1":@"check"] ;
    
    cell.accessoryView = imageView ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * indexStr = self.indexArray[indexPath.row] ;
    NSString * newIndex ;
    if ([indexStr isEqualToString:@"0"])
    {
        [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        newIndex = @"1" ;
    }
    else
    {
        [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        newIndex = @"0" ;
    }
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath] ;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)] ;
    imageView.image = [UIImage imageNamed:[newIndex isEqualToString:@"1"]?@"checked1":@"check"] ;
    
    cell.accessoryView = imageView ;
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
