//
//  AppDelegate.m
//  App
//
//  Created by hhsoft on 16/4/1.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "JVFloatingDrawerViewController.h"
#import "JVFloatingDrawerSpringAnimator.h"

#import "SelectViewController.h"
#import "AppInfo.h"


@interface AppDelegate ()
@property(nonatomic,strong)SelectViewController* selectViewController;
@property (nonatomic, strong) JVFloatingDrawerSpringAnimator *drawerAnimator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.drawController.leftViewController = self.selectViewController;
    self.drawController.centerViewController = [AppDelegate getRootViewController];
    self.drawController.leftDrawerWidth = [AppInfo appScreen].width/2;
    self.drawController.animator = self.drawerAnimator;
    self.drawController.backgroundImage = [UIImage imageNamed:@"timeBackground"];
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [AppInfo appScreen].width, [AppInfo appScreen].height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.drawController.view insertSubview:backView atIndex:1];

    self.window.rootViewController = self.drawController;
    [self.window makeKeyAndVisible];

    return YES;
}
+ (UIViewController *)getRootViewController {
    return [[MainViewController alloc] init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - getter
+ (AppDelegate *)globalDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(JVFloatingDrawerViewController *)drawController{
    if (!_drawController) {
        _drawController = [[JVFloatingDrawerViewController alloc]init];
    }
    return _drawController;
}
-(SelectViewController *)selectViewController{
    if (!_selectViewController) {
        _selectViewController = [[SelectViewController alloc]init];
    }
    return _selectViewController;
}
-(void)toggleLeftDrawer:(id)sender animated:(BOOL)animated{
    [self.drawController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];

}
-(JVFloatingDrawerSpringAnimator *)drawerAnimator{
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc]init];
    }
    return _drawerAnimator;
}

@end
