//
//  ColorViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/1.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()
@property (nonatomic,strong) UIView *colorView;
@end
@implementation ColorViewController
-(instancetype)init{

    if (self = [super init]) {
        if (_colorView == nil) {
            _colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
            self.view.backgroundColor = [UIColor whiteColor];
            if (_colorView == nil) {
                _colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
                
            }
            [self.view addSubview:_colorView];

        }
    }
    return self;
}
//-(void)viewDidLoad{
//
//    [super viewDidLoad];
//}
-(void)setColorInter:(NSInteger)colorInter{
    
    _colorView.backgroundColor = [UIColor colorWithRed:0.1*colorInter green:0.2*colorInter blue:0.05*colorInter alpha:1];
    
}
@end
