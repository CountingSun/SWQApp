//
//  PromptView.h
//  HealthBrueau
//
//  Created by hhsoft on 16/7/29.
//  Copyright © 2016年 huahansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchView)();
@interface PromptView : UIView
@property (nonatomic,copy) touchView touchView;
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image message:(NSString *)message touchView:(touchView)touchView;
-(instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr message:(NSString *)message totalDuration:(NSInteger)totalDuration touchView:(touchView)touchView;
-(UIView *)hiddenanimation;
@end
