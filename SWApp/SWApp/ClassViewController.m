//
//  ClassViewController.m
//  MyApp
//
//  Created by hhsoft on 16/4/1.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import "ClassViewController.h"
#import "MJRefresh.h"
#import "DataEngine.h"
#import "DataModel.h"
#import <objc/runtime.h>

#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height


@interface ClassViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSArray *arrNetData;
@end

@implementation ClassViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];


}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeBottom;
    //滑动时隐藏导航栏 但是要对界面位置进行处理
    self.navigationController.hidesBarsOnSwipe = YES;

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:view];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    _pageIndex = 1;
    
    self.navigationItem.title = @"列表";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self arrData];
    [self getData];
}
-(void)getData{

    [[[DataEngine alloc]init] getDataWithPage:_pageIndex getDataSucceed:^(NSMutableArray *arr) {
        if (_arrData == nil) {
            _arrData = [[NSMutableArray alloc]init];
        }
        if (_pageIndex == 1) {
            [_arrData removeAllObjects];
        }
        [_arrData addObjectsFromArray:(NSMutableArray *)arr];
        [self.dataTableView reloadData];
        [self.dataTableView.mj_footer endRefreshing];
        [self.dataTableView.mj_header endRefreshing];
    }getDataFail:^(NSError *err) {
    }];
}

//-(NSMutableArray *)arrData{
//    if (_arrData == nil) {
//        _arrData = [[NSMutableArray alloc]init];
//
//    }
//    if (_pageIndex == 1) {
//        [_arrData removeAllObjects];
//    }
//    NSString *string = @"数据";
//    for (NSInteger i = 0; i<30; i++) {
//        NSInteger x = arc4random() % 1000;
//        NSString *str = [NSString stringWithFormat:@"%@%@",string,[NSNumber numberWithInteger:x]];
//        [_arrData addObject:str];
//
//    }
//    [self.dataTableView reloadData];
//    NSLog(@"当前数据个数%lu",(unsigned long)_arrData.count);
//    return _arrData;
//    
//    
//}
-(UITableView *)dataTableView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:view];
    if (_dataTableView == nil) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH-64) style:UITableViewStylePlain];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;

        [self.view addSubview:_dataTableView];
        // 下拉刷新
        _dataTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;

            [self getData];
            
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _dataTableView.mj_header.automaticallyChangeAlpha = NO;
        
        // 上拉刷新
        _dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex = ++_pageIndex;

            [self getData];


        }];

    }

    return _dataTableView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  _arrData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *dataModel = [_arrData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = dataModel.dataTitle;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",_dataTableView.contentOffset.y);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
