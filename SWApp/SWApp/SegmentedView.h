//
//  SegmentedView.h
//  FoxHome
//
//  Created by hhsoft on 16/5/12.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//
//选择类别的按钮 可以根据返回的文字长度确定按钮的长度
#import <UIKit/UIKit.h>
@protocol ClassButtonDelegate <NSObject>

-(void)classButtonClickOnIndexPath:(NSIndexPath *)indexPath;

@end

@interface SegmentedView : UIScrollView
@property (nonatomic,weak)id<ClassButtonDelegate>classButtonDelegate;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,strong) NSMutableArray *arrTitles;

/**
 *  <#Description#>
 *
 *  @param frame         <#frame description#>
 *  @param arrTitle      <#arrTitle description#>
 *  @param selectColor   <#selectColor description#>
 *  @param unSelectColor <#unSelectColor description#>
 *  @param titleFont     <#titleFont description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor titleFont:(UIFont *)titleFont;


/**
 *  <#Description#>
 *
 *  @param frame               <#frame description#>
 *  @param arrTitle            <#arrTitle description#>
 *  @param selectColor         <#selectColor description#>
 *  @param unSelectColor       <#unSelectColor description#>
 *  @param spViewSelectColor   <#spViewSelectColor description#>
 *  @param spViewUnSelectColor <#spViewUnSelectColor description#>
 *  @param titleFont           <#titleFont description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor spViewSelectColor:(UIColor *)spViewSelectColor spViewUnSelectColor:(UIColor *)spViewUnSelectColor titleFont:(UIFont *)titleFont;


-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle;
/**
 *  刷新按钮文字
 *
 *  @param arrTitle 
 */
-(void)reloDataWithArrTitle:(NSMutableArray *)arrTitle;
-(void)setDefSelectIndex:(NSInteger)index;

@end
