//
//  CollectKnowViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "CollectKnowViewController.h"

@implementation CollectKnowViewController
-(void)viewDidLoad{

    [super viewDidLoad];
    
    //载一个字符串中删除一个字符或字符串

    
    
    
    
    //屏幕旋转时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

}
//屏幕旋转
- (void)onDeviceOrientationChange{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    //不同方向时 应该做的事
        if (interfaceOrientation == UIDeviceOrientationPortrait) {
        }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        }else if(interfaceOrientation == UIInterfaceOrientationUnknown){
        }else if(interfaceOrientation == UIDeviceOrientationFaceUp){
            
        }else if(interfaceOrientation == UIDeviceOrientationFaceDown){
            
        }else{
            
    }
}
- (void)countDown{
    
    NSDate *newDate = [NSDate date];
    NSDateFormatter *dateFormatterf = [[NSDateFormatter alloc]init];
    dateFormatterf.timeZone = [NSTimeZone defaultTimeZone];//默认时区，貌似和上一个没什么区别
    
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitSecond;
    NSDate *beginDate = [self dateFromString:@"19:30"];
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:newDate  toDate:beginDate  options:0];
    NSInteger second = [comps second];//时间差
    NSLog(@"%ld",(long)second);
}
- (NSString *)convertSecond2HourMinuteSecond:(int)second
{
    NSInteger hour = 0, minute = 0;
    
    hour = second / 3600;
    minute = (second - hour * 3600) / 60;
    second = second - hour * 3600 - minute *  60;
    
    //    [dict setObject:[NSNumber numberWithInt:hour] forKey:@"hour"];
    //    [dict setObject:[NSNumber numberWithInt:minute] forKey:@"minute"];
    //    [dict setObject:[NSNumber numberWithInt:second] forKey:@"second"];
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@:%@",[@(hour) stringValue],[@(minute) stringValue],[@(second) stringValue]];
    return timeStr;
}

//字符串转时间
- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
//时间转字符串
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

@end
