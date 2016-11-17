//
//  TextTabbatViewController.m
//  SWApp
//
//  Created by hhsoft on 16/7/13.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "TextTabbatViewController.h"
#import "DataEngine.h"

@interface TextTabbatViewController ()
@property (nonatomic,strong)DataEngine *dataEngine;
@end
@implementation TextTabbatViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self barButtonArr];
    [self getDataWithCityName:@"郑州"];
    [self getDataWithCookName:@"E5%AE%AB%E4%BF%9D%E9%B8%A1%E4%B8%81"];
}
-(void)getDataWithCityName:(NSString *)cityName{
    if (_dataEngine == nil) {
        _dataEngine = [[DataEngine alloc]init];
    }
    [_dataEngine getWeatherWithname:cityName getDataSucceed:^(NSMutableArray *arr) {
        
    } getDataFail:^(NSError *err) {
        
    }];
    
}
-(void)getDataWithCookName:(NSString *)cookName{
    if (_dataEngine == nil) {
        _dataEngine = [[DataEngine alloc]init];
    }
    [_dataEngine getCookWithname:cookName getDataSucceed:^(NSMutableArray *arr) {
        
    } getDataFail:^(NSError *err) {
        
    }];

}

-(void)barButtonArr{

    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    shareButton.backgroundColor = [UIColor redColor];
    [shareButton addTarget:self action:@selector(shareButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
    UIButton *menuButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    menuButton.backgroundColor = [UIColor greenColor];
    [menuButton addTarget:self action:@selector(menuButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    NSMutableArray *arrButtons;
    arrButtons = [NSMutableArray arrayWithObjects:shareButtonItem,moreButtonItem, nil];
    
    self.navigationItem.rightBarButtonItems = arrButtons;

}
-(void)shareButtonClickEvent{

}
-(void)menuButtonClickEvent{

    
}
@end
