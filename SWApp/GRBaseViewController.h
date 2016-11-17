//
//  GRBaseViewController.h
//  SWApp
//
//  Created by hhsoft on 2016/11/15.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRBaseViewController : UIViewController
-(void)showSuccessWithStatus:(NSString *)status;
-(void)showWithStatus:(NSString *)status;
-(void)showErrorWithStatus:(NSString *)status;
-(void)dismissWithDelay:(NSInteger)status;
-(void)dismiss;

@end
