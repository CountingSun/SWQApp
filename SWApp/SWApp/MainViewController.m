//
//  MainViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/15.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ClassViewController.h"
#import "PlayerViewController.h"
#import "UserViewController.h"
#import "GlobalFile.h"
#import "UIColor+CustomColors.h"
#import "NewViewController.h"
#import "AddViewController.h"
#import "LoginNavController.h"

@interface MainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //    Bar的模糊效果，默认为YES
    self.tabBar.translucent = NO;
    // 添加所有的子控制器
    [self setupChildViewControllers];
    
    [self setAddImgView];

}
/**
 * 添加所有的子控制器
 */
- (void)setupChildViewControllers {

    [self setupChildViewController:[[HomeViewController alloc] init] title:@"首页sdfsadfsadfsafd" image:@"" selectedImage:@"" tag:0];
    
    [self setupChildViewController:[[ClassViewController alloc] init] title:@"新闻" image:@"" selectedImage:@"" tag:1];
    
    [self setupChildViewController:[[NewViewController alloc] init] title:@"圈子" image:@"circle_normal" selectedImage:@"" tag:2];
    
    [self setupChildViewController:[[PlayerViewController alloc] init]  title:@"地图" image:@"" selectedImage:@"player" tag:3];
    
    [self setupChildViewController:[[UserViewController alloc] init]  title:@"我的" image:@"" selectedImage:@"user_center" tag:4];

}
/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */

- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSUInteger)tag
{

    // 包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    //导航栏标题文字属性
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    // 文字颜色
    textAttributesDict[NSForegroundColorAttributeName] = [UIColor customBlackColor];
    // 文字大小
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [nav.navigationBar setTitleTextAttributes:textAttributesDict];
    [nav.navigationBar setBackgroundImage:[GlobalFile imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setTintColor:[UIColor customBlackColor]];
//    [nav.navigationBar setBackButtonColor:[UIColor customBlackColor]];
    //    nav.navigationBar.shadowImage = [UIImage new];
    //    nav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //返回按钮图片
    //    [nav.navigationItem setBackBarButtonCustome:[UIImage imageNamed:@"navigationItem_back"]];
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    // UIControlStateNormal状态下的文字属性
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor customBlackColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [GlobalFile themeColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    [nav.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    nav.tabBarItem.title = title;
    nav.tabBarItem.tag = tag;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UINavigationController *circleNav = tabBarController.viewControllers[2];
    if (tabBarController.selectedIndex == 2) {
        if (!_addButton.hidden) {
            NSLog(@"%@",@"点击了加号");
            AddViewController *addViewController = [[AddViewController alloc] init];
            addViewController.hidesBottomBarWhenPushed = YES;
            LoginNavController *loginNav = [[LoginNavController alloc] initWithRootViewController:addViewController];
            loginNav.navigationBar.shadowImage = [UIImage new];
            [circleNav presentViewController:loginNav animated:YES completion:nil];
        }else {
            circleNav.tabBarItem.title = @"";
            circleNav.tabBarItem.image = nil;
            _addButton.hidden = NO;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
            animation.duration = 1;
            animation.calculationMode = kCAAnimationCubic;
            [_addButton.layer addAnimation:animation forKey:nil];
        }
    }else {
        circleNav.tabBarItem.title = @"圈子";
        circleNav.tabBarItem.image = [UIImage imageNamed:@"circle_normal.png"];
        _addButton.hidden = YES;
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    UINavigationController *nav = (UINavigationController*)viewController;
    if ([NSStringFromClass([nav.viewControllers[0] class]) isEqualToString:@"CircleController"]) {
//        if (![UserInfoEngine isLogin]) {
//            [nav presentViewController:[LoginNavController loginNavWithjumpType:JumpTypePresent] animated:YES completion:nil];
//            return NO;
//        }
    }
    return YES;
}
- (void)addButtonAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.1,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去就OK了
    [_addButton.layer addAnimation:animation forKey:nil];
}
- (void)setAddImgView {
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0, 5.5, 38, 38);
    [_addButton setImage:[UIImage imageNamed:@"circle_center.png"] forState:UIControlStateNormal];
    
    
    CGPoint addButtonCenter =_addButton.center;
    addButtonCenter.x = self.tabBar.center.x;
    _addButton.center =addButtonCenter;
    
    [self.tabBar addSubview:_addButton];
    _addButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
