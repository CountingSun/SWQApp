//
//  UserViewController.m
//  MyApp
//
//  Created by hhsoft on 16/4/1.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import "UserViewController.h"
#import "DataEngine.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height
#import "MenuInfo.h"
#import "SystemEngine.h"
#import "FMDBViewController.h"
#import "TimeViewController.h"
#import "LayerViewController.h"
#import "RunTimeText.h"
#import "EaysView.h"
#import "TextControlViewController.h"
#import "ClassAndListViewController.h"
#import "HHsoftViewController.h"
#import "PageControlText.h"
#import "ImageTextViewController.h"
#import "AppDelegate.h"


@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *dataTable ;
@property (nonatomic,strong) NSMutableArray *arrData;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeBottom;
    self.navigationItem.title = @"个人中心";
    [self getMenu];
    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)getMenu{
    _arrData = [SystemEngine arrMenu];
    [self.dataTable reloadData];
}
-(UITableView *)dataTable{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (_dataTable == nil) {
        _dataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        _dataTable.delegate =  self ;
        _dataTable.dataSource = self;
        [self.view addSubview:_dataTable];
        [_dataTable setTableFooterView:v];

    }
    return _dataTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _arrData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *menuInfo = [_arrData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = menuInfo.menuName;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.image = [UIImage imageNamed:menuInfo.menuIcon];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *menuInfo = _arrData[indexPath.row];
    switch (menuInfo.menuID) {
        case 0:
        {
        
//            FMDBViewController *fmdbViewController = [[FMDBViewController alloc]init];
//            fmdbViewController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:fmdbViewController animated:YES];
            [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
        }
            break;
        case 1:{
        
            TimeViewController *timeViewController = [[TimeViewController alloc]init];
            timeViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:timeViewController animated:YES];
        }
            break;
        case 2:{
            LayerViewController *layerViewController = [[LayerViewController alloc]init];
            layerViewController.hidesBottomBarWhenPushed = YES;
            layerViewController.automaticallyAdjustsScrollViewInsets = NO;

            [self.navigationController pushViewController: layerViewController animated:YES];
            
        }
            break;
        case 3:{
            RunTimeText *runTimeText = [[RunTimeText alloc]init];
            runTimeText.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:runTimeText animated:YES];
            
            
        }
            break;
        case 4:{
            TextControlViewController *textControlViewController = [[TextControlViewController alloc]init];
            textControlViewController.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:textControlViewController animated:YES];
            
        }
            break;
        case 5:{
            
            HHsoftViewController *classAndListViewController = [[HHsoftViewController alloc]init];
            classAndListViewController.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:classAndListViewController animated:YES];

        }
            break;
        case 6:{
            PageControlText *controller = [[PageControlText alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:YES];

            
        }
            
            break;
        case 7:{
        
            ImageTextViewController *controller = [[ImageTextViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:YES];

        }
            break;
        default:
            break;
    }
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
