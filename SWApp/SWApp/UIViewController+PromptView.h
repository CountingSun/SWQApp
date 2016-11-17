//
//  UIViewController+PromptView.h
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^touchView)();

@interface UIViewController (PromptView)
/**
 *  展示一张图片
 *
 *  @param frame     <#frame description#>
 *  @param image     <#image description#>
 *  @param message   <#message description#>
 *  @param touchView <#touchView description#>
 */
-(void)showPromptViewOnView:(UIView *)baseView image:(UIImage *)image message:(NSString *)message  touchView:(touchView)touchView;
/**
 *  加载动画
 *
 *  @param frame         <#frame description#>
 *  @param imageArr      <#imageArr description#>
 *  @param message       <#message description#>
 *  @param totalDuration <#totalDuration description#>
 *  @param touchView     <#touchView description#>
 */
-(void)showPromptOnView:(UIView *)baseView ViewWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr message:(NSString *)message totalDuration:(NSInteger)totalDuration;
/**
 *  隐藏动画
 */
-(void)hiddenLoadingView;

@end
