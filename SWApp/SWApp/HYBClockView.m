//
//  HYBClockView.m
//  HYBClockDemo
//
//  Created by huangyibiao on 16/3/15.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBClockView.h"

#define kAngleToRadion(angle) ((angle) / 180.0 * M_PI)

@interface HYBClockView () {
 __weak NSTimer *_timer;
}

@property (nonatomic, strong) CALayer *hourLayer;
@property (nonatomic, strong) CALayer *minuteLayer;
@property (nonatomic, strong) CALayer *secondLayer;

@end

@implementation HYBClockView

- (void)dealloc {
  NSLog(@"remove from superview");
}

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName {
  if (self = [super initWithFrame:frame]) {
    UIImage *image = [UIImage imageNamed:imageName];
      //layer 加背景图片
    self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    
    // hour layer set up
    self.hourLayer = [self layerWithBackgroundColor:[UIColor blackColor]
                                               size:CGSizeMake(3, self.frame.size.width / 2 - 40)];
    // 秒针与分针一样长
    self.minuteLayer = [self layerWithBackgroundColor:[UIColor blackColor]
                                                 size:CGSizeMake(3, self.frame.size.width / 2 - 20)];
    self.secondLayer = [self layerWithBackgroundColor:[UIColor redColor]
                                                 size:CGSizeMake(1, self.frame.size.width / 2 - 20)];
    self.secondLayer.cornerRadius = 0;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(onTimerUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
      /**
       *  我们通常在主线程中使用NSTimer，有个实际遇到的问题需要注意。当滑动界面时，系统为了更好地处理UI事件和滚动显示，主线程runloop会暂时停止处理一些其它事件，这时主线程中运行的NSTimer就会被暂停。解决办法就是改变NSTimer运行的mode（mode可以看成事件类型），不使用缺省的NSDefaultRunLoopMode，而是改用NSRunLoopCommonModes，这样主线程就会继续处理NSTimer事件了。具体代码如下：
       
       NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
       
       [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
       
        http://www.cnblogs.com/wendingding/p/3805119.html

       */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
      //获取当前的线程【这两句话在这里没有】
      NSThread *thead = [NSThread currentThread];
      //判断当前线程是否是主线程
      if ([thead isMainThread]) {
          NSLog(@"主线程");
          
      }else{
          NSLog(@"非主线程");
          
      };
      
    _timer = timer;
    [self updateUI];
  }
  
  return self;
}

- (void)releaseTimer {
  [_timer invalidate];
  _timer = nil;
}

#pragma mark - Private
- (void)updateUI {
    
    //日历类 获取时间的
  NSCalendar *calender = [NSCalendar currentCalendar];
  
  NSDateComponents *date = [calender components:NSCalendarUnitSecond
                            | NSCalendarUnitMinute
                            | NSCalendarUnitHour
                                       fromDate:[NSDate date]];
  
  NSInteger second = date.second;
  NSInteger minute = date.minute;
  NSInteger hour = date.hour;
  
  CGFloat perHourMove = 1.0 / 12. * 360.0;
  CGFloat hourAngle = hour * perHourMove + minute * (1.0 / 60.0) * perHourMove;
  self.hourLayer.transform = CATransform3DMakeRotation(kAngleToRadion(hourAngle), 0, 0, 1);
  
  // 一分钟就是一圈，也就是每秒走度
  CGFloat minuteAngle = minute * 360.0 / 60.0;
  self.minuteLayer.transform = CATransform3DMakeRotation(kAngleToRadion(minuteAngle), 0, 0, 1);
  
  CGFloat secondAngle = second * 360.0 / 60.0;
  self.secondLayer.transform = CATransform3DMakeRotation(kAngleToRadion(secondAngle), 0, 0, 1);
}

- (void)onTimerUpdate:(NSTimer *)timer {
  [self updateUI];
}

- (CALayer *)layerWithBackgroundColor:(UIColor *)color size:(CGSize)size {
  CALayer *layer = [CALayer layer];
  
  layer.backgroundColor = color.CGColor;
  layer.anchorPoint = CGPointMake(0.5, 1);
  // 设置为中心
  layer.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
  // 时针、分针、秒针长度是不一样的
  layer.bounds = CGRectMake(0, 0, size.width, size.height);
  // 加个小圆角
  layer.cornerRadius = 4;
    
  [self.layer addSublayer:layer];
  
  return layer;
}

@end
