//
//  HomeViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "HomeViewController.h"
#import "DataEngine.h"
#import "HealthListViewController.h"
#import "HealthClassInfo.h"
#import "GlobalFile.h"
#import "UIViewController+PromptView.h"
#import "UIColor+CustomColors.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface HomeViewController () <GUITabPagerDataSource, GUITabPagerDelegate>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic,strong) DataEngine *dataEngine;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDataSource:self];
    [self setDelegate:self];
    [self rightButton];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];

    [self showPromptOnView:self.view ViewWithFrame:self.view.bounds imageArr:[GlobalFile arrLoadingImage] message:[GlobalFile loadWaitMessage] totalDuration:[GlobalFile animationDuration]];

    [self getHealthClass];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    self.view.backgroundColor = [GlobalFile defBackgroundColor];
    self.navigationItem.title = @"首页";
}
-(void)openDrawer{
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
    
}
-(void)rightButton{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"签到" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClickEvent)];
    
}
-(void)rightBarButtonItemClickEvent{

    ViewController *VC = [[ViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)getHealthClass{
    
    if (_dataEngine == nil) {
        _dataEngine = [[DataEngine alloc]init];
    }
    [_dataEngine getHealthClassSucceed:^(NSMutableArray *arrClass) {
        [self hiddenLoadingView];

        if (_arrTitle == nil) {
            _arrTitle = [[NSMutableArray alloc]init];
        }
        
        _arrTitle = arrClass;
        
        [self reloadData];
    } getDataFail:^(NSError *err) {
        [self hiddenLoadingView];

    }];
}
- (NSInteger)numberOfViewControllers {
    return self.arrTitle.count;
}
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    HealthListViewController *healthListViewController = [[HealthListViewController alloc]init];
    return healthListViewController;

}
- (NSString *)titleForTabAtIndex:(NSInteger)index {
    HealthClassInfo *healthClassInfo = _arrTitle[index];
    return healthClassInfo.healthClassName;
}

- (CGFloat)tabHeight {
    // Default: 44.0f
    return 40.0f;
}

- (UIColor *)tabColor {
    // Default: [UIColor orangeColor];
    return [UIColor customRedColor];
}

- (UIColor *)tabBackgroundColor {
    // Default: [UIColor colorWithWhite:0.95f alpha:1.0f];
    return [UIColor whiteColor];
}

- (UIFont *)titleFont {
    // Default: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
}

- (UIColor *)titleColor {
    // Default: [UIColor blackColor];
    return [UIColor customBlackColor];
}

#pragma mark - Tab Pager Delegate

- (void)tabPager:(GUITabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Will transition from tab %ld to %ld", (long)[self selectedIndex], (long)index);
    HealthClassInfo *healthClassInfo = _arrTitle[index];
    HealthListViewController *healthListViewController = (HealthListViewController *)tabPager;
    [healthListViewController getHealthListWithID:healthClassInfo.healthClassID];
}

- (void)tabPager:(GUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Did transition to tab %ld", (long)index);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self reloadData];
}

@end
