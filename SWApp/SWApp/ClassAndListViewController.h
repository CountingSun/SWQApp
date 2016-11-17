//
//  ClassAndListViewController.h
//  SWApp
//
//  Created by hhsoft on 16/7/30.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassAndListViewControllerDelegate <NSObject>

-(UIViewController *)viewController:(UIViewController *)viewController atIndex:(NSInteger)index identifier:(NSString *)identifier;


@end

@interface ClassAndListViewController : UIViewController
@property (nonatomic,weak)id<ClassAndListViewControllerDelegate>delegate;
-(void)addClassButtonWithtitleArr:(NSMutableArray *)titleArr;
-(void)addClassButtonWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor titleFont:(UIFont *)titleFont;
-(void)addClassButtonWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor spViewSelectColor:(UIColor *)spViewSelectColor spViewUnSelectColor:(UIColor *)spViewUnSelectColor titleFont:(UIFont *)titleFont;
-(void)reloDataWithArrTitle:(NSMutableArray *)arrTitle;
-(UIViewController *)dequWithIdentifier:(NSString *)identifier;
-(void)reloadData;
-(void)reloadViewControllerAtIndex:(NSInteger)index;
-(void)setDefaultSelectIndex:(NSInteger)index;

@end
