//
//  SegmentedCollectionViewCell.h
//  FoxHome
//
//  Created by hhsoft on 16/6/24.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LableInfo;

@interface SegmentedCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *spViewColor;
@property (nonatomic,strong) UIFont  *titleFont;

+(CGSize)setCellWightWithTitle:(NSString *)title;
@end
