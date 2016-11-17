//
//  UIViewController+PromptView.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "UIViewController+PromptView.h"
#import "PromptView.h"

@implementation UIViewController (PromptView)
-(void)showPromptViewOnView:(UIView *)baseView image:(UIImage *)image message:(NSString *)message  touchView:(touchView)touchView{
    PromptView *promptView = [[PromptView alloc]initWithFrame:baseView.bounds image:image message:message touchView:touchView];
    promptView.tag = 100;
    [baseView addSubview:promptView];
}
/**
 *  加载动画
 *
 *  @param frame
 *  @param imageArr
 *  @param message
 *  @param totalDuration
 *  @param touchView
 */
-(void)showPromptOnView:(UIView *)baseView ViewWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr message:(NSString *)message totalDuration:(NSInteger)totalDuration{
    PromptView *promptView = [[PromptView alloc]initWithFrame:frame imageArr:imageArr message:message totalDuration:totalDuration touchView:nil];
    promptView.tag = 200;
    [baseView addSubview:promptView];
}
-(void)hiddenLoadingView{
    PromptView *promptView = (PromptView *)[self.view viewWithTag:200];
    [promptView removeFromSuperview];
}

@end
