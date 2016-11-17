//
//  PageControlText.m
//  SWApp
//
//  Created by hhsoft on 16/8/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "PageControlText.h"
#import "ColorViewController.h"



@interface PageControlText ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong) UIPageViewController *pageViewController;
@end
@implementation PageControlText
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.pageViewController.view];

}
-(UIPageViewController *)pageViewController{

    if (_pageViewController == nil) {
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                           forKey: UIPageViewControllerOptionSpineLocationKey];

        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.view.frame = self.view.bounds;
        [self addChildViewController:self.pageViewController];
        [self.pageViewController didMoveToParentViewController:self];

    }
    return _pageViewController;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    ColorViewController *colorViewController = [[ColorViewController alloc]init];
    colorViewController.view.frame = self.view.bounds;
    colorViewController.colorInter = 4;

    return colorViewController;
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    ColorViewController *colorViewController = [[ColorViewController alloc]init];
    colorViewController.colorInter = 10;
    colorViewController.view.frame = self.view.bounds;
    return colorViewController;

}

@end
