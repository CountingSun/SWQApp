//
//  TimeViewController.m
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "TimeViewController.h"
#import "HYBClockView.h"
#import "HYBAnimationClock.h"


@interface TimeViewController ()
@property (nonatomic, strong) HYBClockView *clockView;

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.edgesForExtendedLayout=UIRectEdgeBottom;

    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 200) / 2;
    self.clockView = [[HYBClockView alloc] initWithFrame:CGRectMake(x, 40, 200, 200)
                                               imageName:@"timeBackground"];
      [self.view addSubview:self.clockView];
    
    HYBAnimationClock *aniClockView = [[HYBAnimationClock alloc] initWithFrame:CGRectMake(x, 250, 200, 200)
                                                                     imageName:@"timeBackground"];
    
    [self.view addSubview:aniClockView];
    
//    [self.clockView releaseTimer];
    //  [self.clockView removeFromSuperview];
    self.clockView = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
