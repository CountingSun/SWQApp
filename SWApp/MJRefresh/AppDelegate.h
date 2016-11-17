//
//  AppDelegate.h
//  App
//
//  Created by hhsoft on 16/4/1.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JVFloatingDrawerViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)JVFloatingDrawerViewController* drawController;
+ (AppDelegate *)globalDelegate ;
-(void)toggleLeftDrawer:(id)sender animated:(BOOL)animated;
+ (UIViewController *)getRootViewController;

@end

