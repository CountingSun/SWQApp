//
//  SelectViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/16.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "SelectViewController.h"
#import "UIColor+CustomColors.h"
#import "AppInfo.h"
#import "UserViewController.h"
#import "AppDelegate.h"
#import "JVFloatingDrawerViewController.h"
#import "CalendarViewController.h"

@interface SelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *dataTable;
@property (nonatomic,strong) UIView *headView;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor customGrayColor];
    [self.dataTable reloadData];
    self.dataTable.tableHeaderView =self.headView;
    
}
-(UIView *)headView{

    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [AppInfo appScreen].width, 200)];
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake([AppInfo appScreen].width/4-40, 60, 80, 80)];
//        headImage.center =_headView.center;
        headImage.backgroundColor = [UIColor whiteColor];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius =headImage.frame.size.width/2;
        [_headView addSubview:headImage];
    }
    return _headView;
}
-(UITableView *)dataTable{

    if (!_dataTable) {
        _dataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [AppInfo appScreen].width, [AppInfo appScreen].height) style:UITableViewStylePlain];
        [self.view addSubview:_dataTable];
        _dataTable.backgroundColor = [UIColor clearColor];
        _dataTable.separatorColor = [UIColor clearColor];
        _dataTable.delegate = self;
        _dataTable.dataSource = self;
    }
    return _dataTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
        cell.textLabel.text = @[@"首页",@"个人",@"日历"][indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = 0;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    switch (indexPath.row) {
        case 0:
        {
            [AppDelegate globalDelegate].drawController.centerViewController = [AppDelegate getRootViewController];
            [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];

        }
            break;
            
        case 1:{
        
            UserViewController *userViewController = [[UserViewController alloc]init];
            [AppDelegate globalDelegate].drawController.centerViewController = userViewController;
            [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];

            
        }
            break;
        case 2:{
         
            CalendarViewController *calendarViewController = [[CalendarViewController alloc]init];
            [AppDelegate globalDelegate].drawController.centerViewController = calendarViewController;
            [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];

        }
            break;
        default:
            
            break;
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
