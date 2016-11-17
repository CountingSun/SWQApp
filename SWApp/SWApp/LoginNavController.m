//
//  LoginNavController.m
//  FoxHome
//
//  Created by hhsoft on 16/6/21.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "LoginNavController.h"
#import "UIColor+CustomColors.h"

@interface LoginNavController ()

@end

@implementation LoginNavController

+ (LoginNavController *)loginNavWithjumpType:(NSInteger)jumpType{
    UIViewController *loginViewController = [[UIViewController alloc] init];
    
    LoginNavController *loginNav = [[LoginNavController alloc] initWithRootViewController:loginViewController];
    return loginNav;
}
#pragma mark --- 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏标题文字属性
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    // 文字颜色
    textAttributesDict[NSForegroundColorAttributeName] = [UIColor customBlackColor];
    // 文字大小
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [self.navigationBar setTitleTextAttributes:textAttributesDict];
    //返回按钮
    [self.navigationBar setTintColor:[UIColor customBlackColor]];
    self.navigationBar.translucent = NO;//    Bar的模糊效果，默认为YES
}
#pragma mark --- DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
