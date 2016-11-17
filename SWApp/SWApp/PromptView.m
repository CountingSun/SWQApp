//
//  PromptView.m
//  HealthBrueau
//
//  Created by hhsoft on 16/7/29.
//  Copyright © 2016年 huahansoft. All rights reserved.
//

#import "PromptView.h"

@interface PromptView ()
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) NSMutableArray *arrImage;
@end
@implementation PromptView
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image message:(NSString *)message touchView:(touchView)touchView{

    if (self = [super initWithFrame:frame]) {
        _image = image;
        _message = message;
        _touchView = touchView;
        
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    imageView.center = self.center;
    imageView.image = _image;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(imageView.frame), self.frame.size.width-30, 40)];
    label.font = [UIFont systemFontOfSize:16];
    label.text =_message;
    label.textColor =[UIColor blackColor];
    label.textAlignment =NSTextAlignmentCenter;
    
    label.userInteractionEnabled = YES;
    [self addSubview:label];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchselfView)];
    [self addGestureRecognizer:tapGestureRecognizer];

}
-(void)touchselfView{
    if (_touchView) {
        _touchView();
    }
    [self removeFromSuperview];
}
-(instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr message:(NSString *)message totalDuration:(NSInteger)totalDuration touchView:(touchView)touchView{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 175)];
        imageView.center = self.center;
        imageView.animationImages = imageArr;
        imageView.animationDuration = totalDuration;
        imageView.userInteractionEnabled = YES;
        [imageView startAnimating];

        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(imageView.frame), self.frame.size.width-30, 40)];
        label.font = [UIFont systemFontOfSize:16];
        label.text =_message;
        label.textColor =[UIColor blackColor];
        label.textAlignment =NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [self addSubview:label];

    }
    return self;
    
}
-(UIView *)hiddenanimation{
    return self;
}

@end
