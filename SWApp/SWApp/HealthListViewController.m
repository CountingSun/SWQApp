//
//  HealthListViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "HealthListViewController.h"
#import "GlobalFile.h"
#import "MJRefresh.h"
#import "DataEngine.h"
#import "HealthListInfo.h"
#import "HealthListTableViewCell.h"
#import "UIViewController+PromptView.h"
#import "HealthDetailViewController.h"

#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height

@interface HealthListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) DataEngine *dataEngine;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) UITableView *dataTableView;
@property (nonatomic,assign) NSInteger pageIndex,pageSize;
@property (nonatomic,assign) NSInteger healthClassID;

@end
@implementation HealthListViewController
-(instancetype)initWithID:(NSInteger)ID{


    if (self = [super init]) {
        _healthClassID =ID;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pageSize = 30;
    _pageIndex = 1;
    self.view.backgroundColor = [GlobalFile defBackgroundColor];

    [self showPromptOnView:self.dataTableView ViewWithFrame:self.view.bounds imageArr:[GlobalFile arrLoadingImage] message:[GlobalFile loadWaitMessage] totalDuration:[GlobalFile animationDuration]];
    [self getHealthListWithHealthClassID:_healthClassID];
    
}
-(void)getHealthListWithID:(NSInteger)ID{
    _healthClassID =ID;
    [self showPromptOnView:self.dataTableView ViewWithFrame:self.view.bounds imageArr:[GlobalFile arrLoadingImage] message:[GlobalFile loadWaitMessage] totalDuration:[GlobalFile animationDuration]];

    [self getHealthListWithHealthClassID:ID];
}

-(void)getHealthListWithHealthClassID:(NSInteger)healthClassID{

    if (_dataEngine == nil) {
        _dataEngine = [[DataEngine alloc]init];
    }
    [_dataEngine getHealthListWithHealthClassID:healthClassID page:_pageIndex pageSize:_pageSize getHealthListSucceed:^(NSMutableArray *arrDetails) {
        [self hiddenLoadingView];
        if (_arrData == nil) {
            _arrData = [[NSMutableArray alloc]init];
        }
        if (_pageIndex == 1) {
            [_arrData removeAllObjects];
        }
        [_arrData addObjectsFromArray:(NSMutableArray *)arrDetails];
        [self.dataTableView.mj_footer endRefreshing];
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView reloadData];
    } getDataFail:^(NSError *err) {
        
    }];
}
-(UITableView *)dataTableView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:view];
    if (_dataTableView == nil) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH-154) style:UITableViewStylePlain];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.rowHeight = 100;
        [self.view addSubview:_dataTableView];
        // 下拉刷新
        _dataTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            
            [self getHealthListWithHealthClassID:_healthClassID];
            
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _dataTableView.mj_header.automaticallyChangeAlpha = NO;
        
        // 上拉刷新
        _dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex = ++_pageIndex;
            
            [self getHealthListWithHealthClassID:_healthClassID];
            
            
        }];
        
    }
    
    return _dataTableView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _arrData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HealthListInfo *healthListInfo = [_arrData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"Cell";
    HealthListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HealthListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.healthListInfo = healthListInfo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HealthListInfo *healthListInfo = [_arrData objectAtIndex:indexPath.row];
    HealthDetailViewController *healthDetailViewController = [[HealthDetailViewController alloc]initWithHealthID:healthListInfo.healthListID];
    healthDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:healthDetailViewController animated:YES];
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
