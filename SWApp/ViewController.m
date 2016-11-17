//
//  ViewController.m
//  EmitterDemo
//
//  Created by 菲了然 on 16/3/9.
//  Copyright © 2016年 菲了然. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong)UILabel * babyLable;
@property (nonatomic, strong)UIView * grayView;
@property (nonatomic, strong)CAEmitterLayer * emitterLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 220, 150);
    button.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    [button setTitle:@"点" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:252/255.0 green:190/255.0 blue:0 alpha:0.6] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"奖励"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    label.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0);
    label.text = @"+5金币";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:254/255.0 green:211/255.0 blue:10/255.0 alpha:1];
    [self.view addSubview: self.babyLable = label];
    self.babyLable.hidden = YES;
    
    UIView * grayView = [[UIView alloc] initWithFrame:self.view.bounds];
    grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:self.grayView = grayView];
    self.grayView.hidden = YES;
    //粒子动画
    {
        //发射源
        CAEmitterLayer * emitter = [CAEmitterLayer layer];
        emitter.frame = CGRectMake(0, 0, CGRectGetWidth(self.babyLable.frame), CGRectGetHeight(self.babyLable.frame));
        [self.babyLable.layer addSublayer:self.emitterLayer = emitter];
        //发射源形状
        emitter.emitterShape = kCAEmitterLayerCircle;
        //发射模式
        emitter.emitterMode = kCAEmitterLayerPoints;
        //渲染模式
        //    emitter.renderMode = kCAEmitterLayerAdditive;
        //发射位置
        emitter.emitterPosition = CGPointMake(self.babyLable.frame.size.width/2.0, self.babyLable.frame.size.height/2.0);
        //发射源尺寸大小
        emitter.emitterSize = CGSizeMake(20, 20);
      
        // 从发射源射出的粒子
        {
            CAEmitterCell * cell = [CAEmitterCell emitterCell];
            cell.name = @"zanShape";
            //粒子要展现的图片
            cell.contents = (__bridge id)[UIImage imageNamed:@"point"].CGImage;
            //    cell.contents = (__bridge id)[UIImage imageNamed:@"EffectImage"].CGImage;
//            cell.contentsRect = CGRectMake(100, 100, 100, 100);
            //粒子透明度在生命周期内的改变速度
            cell.alphaSpeed = -0.5;
            //生命周期
            cell.lifetime = 3.0;
            //粒子产生系数(粒子的速度乘数因子)
            cell.birthRate = 0;
            //粒子速度
            cell.velocity = 300;
            //速度范围
            cell.velocityRange = 180;
            //周围发射角度
            cell.emissionRange = M_PI/2;
            //发射的z轴方向的角度
            cell.emissionLatitude = -M_PI;
            //x-y平面的发射方向
            cell.emissionLongitude = -M_PI / 2;
            //粒子y方向的加速度分量
            cell.yAcceleration = 100;
            emitter.emitterCells = @[cell];
        }

    }
}

-(void)tapClick
{
    [self beginAnimation];
}
/**
 *  开始动画
 */
-(void)beginAnimation
{
    __weak typeof(self)bself = self;
    self.babyLable.hidden = NO;
    self.grayView.hidden = NO;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        CABasicAnimation * effectAnimation = [CABasicAnimation animationWithKeyPath:@"emitterCells.zanShape.birthRate"];
        effectAnimation.fromValue = [NSNumber numberWithFloat:30];
        effectAnimation.toValue = [NSNumber numberWithFloat:0];
        effectAnimation.duration = 0.0f;
        effectAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [bself.emitterLayer addAnimation:effectAnimation forKey:@"zanCount"];
        //放大动画
        {
            CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            aniScale.fromValue = [NSNumber numberWithFloat:0.5];
            aniScale.toValue = [NSNumber numberWithFloat:3.0];
            aniScale.duration = 1.5;
            aniScale.delegate = self;
            aniScale.removedOnCompletion = NO;
            aniScale.repeatCount = 1;
            [bself.babyLable.layer addAnimation:aniScale forKey:@"babyCoin_scale"];
        }
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:3.0 animations:^{
        bself.grayView.alpha = 0;
    }];
}
/**
 *  动画结束代理方法
 */
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.babyLable.layer animationForKey:@"babyCoin_scale"]) {
        [self babyCoinFadeAway];
    }
    if (anim == [self.babyLable.layer animationForKey:@"aniMove_aniScale_groupAnimation"]) {
        self.babyLable.hidden = YES;
        self.grayView.alpha = 0.6;
        self.grayView.hidden = YES;
    }
}
/**
 *  金币散开结束后文字下落动画
 */
-(void)babyCoinFadeAway
{
    CGFloat aPPW = [UIScreen mainScreen].bounds.size.width;
    CGFloat aPPH = [UIScreen mainScreen].bounds.size.height;
    CABasicAnimation * aniMove = [CABasicAnimation animationWithKeyPath:@"position"];
    aniMove.fromValue = [NSValue valueWithCGPoint:self.babyLable.layer.position];
    
    aniMove.toValue = [NSValue valueWithCGPoint:CGPointMake(aPPW, aPPH)];
    
    CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    aniScale.fromValue = [NSNumber numberWithFloat:3.0];
    aniScale.toValue = [NSNumber numberWithFloat:0.5];
    
    CAAnimationGroup * aniGroup = [CAAnimationGroup animation];
    aniGroup.duration = 1.0;
    aniGroup.repeatCount = 1;
    aniGroup.delegate = self;
    aniGroup.animations = @[aniMove,aniScale];
    aniGroup.removedOnCompletion = NO;
//    aniGroup.fillMode = kCAFillModeForwards;  //防止动画结束后回到原位
    [self.babyLable.layer removeAllAnimations];
    [self.babyLable.layer addAnimation:aniGroup forKey:@"aniMove_aniScale_groupAnimation"];

}

@end
