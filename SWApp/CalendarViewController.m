//
//  CalendarViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/16.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "CalendarViewController.h"
#import "SZCalendarPicker.h"
#import "AppInfo.h"
#import "AppDelegate.h"

#define WeakObj(o) __weak typeof(o) o##Weak = o;
#define StrongObj(o) __strong typeof(o) o##Strong = o;

@interface CalendarViewController ()
@property (nonatomic, strong, readwrite) SZCalendarPicker* calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCalendar];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, [AppInfo appScreen].height/2+30, 50, 50  )];
    
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor blackColor];

}
#pragma mark - private
-(void)buttonEvent{

    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}
- (void)initCalendar {
    _calendar = [SZCalendarPicker showOnView:self.view];
    _calendar.today = [NSDate date];
    _calendar.date = _calendar.today;
    _calendar.frame = CGRectMake(0, 64,[AppInfo appScreen].width, [AppInfo appScreen].height/2);
    
    WeakObj(self);
    _calendar.changeMonthBlock = ^(NSInteger year,NSInteger month){
        StrongObj(selfWeak)
//        [selfWeakStrong.viewModel getWalkAndRunKcalArrayWithMonth:month year:year weigth:65];
//        [selfWeakStrong.viewModel getRunKcalArrayWithMonth:month year:year weigth:65];
    };
    
    _calendar.calendarBlock = ^(NSDate* date){
        StrongObj(selfWeak)
//        NSArray* runArr = [selfWeakStrong.viewModel getRunRecordWithDate:date];
//        if (runArr) {
//            DetailViewController* vc = [selfWeakStrong.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//            vc.runDataArray = runArr;
//            [selfWeakStrong presentViewController:vc animated:YES completion:nil];
//        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
