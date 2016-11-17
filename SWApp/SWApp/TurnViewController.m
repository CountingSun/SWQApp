//
//  TurnViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/12.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "TurnViewController.h"
#import "GlobalFile.h"
#import "UIColor+CustomColors.h"

@interface TurnViewController ()
@property (nonatomic,strong) UIImageView *oneImageView;
@property (nonatomic,strong) UIImageView *twoImageView;
@property (nonatomic,strong) UIImageView *threeImageView;

@end
@implementation TurnViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"点击" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClickEvent)];

    self.view.backgroundColor = [GlobalFile defBackgroundColor];
    [self buileView];
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(15, 400, self.view.frame.size.width-30, 10)];
    [slider addTarget:self action:@selector(sliderChangEvent:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 5;
    slider.minimumValue = 1;
    [self.view addSubview:slider];
}
-(void)sliderChangEvent:(UISlider *)slider{

    [self layer:_oneImageView.layer addAnimationWithDuration:slider.value angle:0];
    [self layer:_twoImageView.layer addAnimationWithDuration:slider.value angle:120];
    [self layer:_threeImageView.layer addAnimationWithDuration:slider.value angle:240];
    NSLog(@"slider.value%f",slider.value);

}
-(void)rightBarButtonItemClickEvent{
    [self layer:_oneImageView.layer addAnimationWithDuration:1 angle:0];
    [self layer:_twoImageView.layer addAnimationWithDuration:1 angle:120];
    [self layer:_threeImageView.layer addAnimationWithDuration:1 angle:240];

}
-(void)buileView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 100)];
    view.layer.masksToBounds = NO;
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    view.layer.shadowOffset = CGSizeMake(0, 5.0f);
    
    view.layer.shadowOpacity = 1;

    view.backgroundColor = [UIColor whiteColor];
//    view.layer.borderColor = [UIColor blackColor].CGColor;
//    view.layer.borderWidth = 2;
    [self.view addSubview:view];

     _oneImageView = [self imageViewWithFrame:CGRectMake(self.view.frame.size.width/2-10, 100, 20, 20*2.2f) image:[UIImage imageNamed:@"line"]];
     _twoImageView =  [self imageViewWithFrame:CGRectMake(self.view.frame.size.width/2-10, 100, 20, 20*2.2f) image:[UIImage imageNamed:@"line"]];

     _threeImageView =  [self imageViewWithFrame:CGRectMake(self.view.frame.size.width/2-10, 100, 20, 20*2.2f) image:[UIImage imageNamed:@"line"]];
   
    
    [self layer:_oneImageView.layer addAnimationWithDuration:3 angle:0];
    [self layer:_twoImageView.layer addAnimationWithDuration:3 angle:120];
    [self layer:_threeImageView.layer addAnimationWithDuration:3 angle:240];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-1, CGRectGetMaxY(_oneImageView.frame), 2, 100)];
    lineView.backgroundColor = [UIColor customBlueColor];
        [self.view addSubview:lineView];
    
    
    
    lineView.layer.masksToBounds = NO;
    
    lineView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    lineView.layer.shadowOffset = CGSizeMake(0, 5.0f);
    
    lineView.layer.shadowOpacity = 1;
    
    

}
-(UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.layer.anchorPoint = CGPointMake(0.5, 1);
    imageView.image = image;
    
    imageView.layer.masksToBounds = NO;
    
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    imageView.layer.shadowOffset = CGSizeMake(0, 5.0f);
    
    imageView.layer.shadowOpacity = 1;

    [self.view addSubview:imageView];

    return imageView;
}
-(void)layer:(CALayer *)layer addAnimationWithDuration:(CGFloat)duration angle:(CGFloat)angle{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(angle * M_PI / 180);
    animation.byValue = @(2 * M_PI);
    [layer addAnimation:animation forKey:@"animation"];

}
@end
