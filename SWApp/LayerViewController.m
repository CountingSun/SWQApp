//
//  LayerViewController.m
//  SWApp
//
//  Created by hhsoft on 16/4/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "LayerViewController.h"

#define kAngleToRadio(angle) ((angle) / 180.0 * M_PI)

@interface LayerViewController ()

@end

@implementation LayerViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake((self.view.bounds.size.width - 200)/2, 100, 200, 50);
    layer.backgroundColor = [[UIColor grayColor] CGColor];
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.shadowOpacity = 3;

    [self.view.layer addSublayer:layer];
    
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSDateComponents *date = [calender components:NSCalendarUnitSecond
//                              | NSCalendarUnitMinute
//                              | NSCalendarUnitHour
//                                         fromDate:[NSDate date]];
//    
//    NSInteger second = date.second;
//    NSInteger minute = date.minute;
//    NSInteger hour = date.hour;
    
    
//    CGFloat secondAngle = second * 360.0 / 60.0;

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.repeatCount = HUGE_VALL;
//    animation.duration = 1;
//    animation.removedOnCompletion = NO;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
////    animation.fromValue = @(secondAngle * M_PI / 180);
////    animation.byValue = @(2 * M_PI);
//    animation.fromValue = @(10);
//    animation.toValue = @(100);
//    
//    [layer addAnimation:animation forKey:@"SecondAnimationKey"];
//
    UIView *textView =  [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 30)];
    textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textView];
    textView.layer.shadowOpacity = 3;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    //开演
    [layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    [textView.layer addAnimation:rotateAnimation forKey:@"transform.rotation.x"];
    
}
-(void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}
@end
