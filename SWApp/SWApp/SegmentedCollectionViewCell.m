//
//  SegmentedCollectionViewCell.m
//  FoxHome
//
//  Created by hhsoft on 16/6/24.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "SegmentedCollectionViewCell.h"
#import "NSString+Extension.h"
#import "GlobalFile.h"

@interface SegmentedCollectionViewCell()
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong) UIView *spView;

@end
@implementation SegmentedCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 38)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        _spView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, 60, 2)];
        [self.contentView addSubview:_spView];
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(1000, 40)];
    
    _label.frame = CGRectMake(0, 0, size.width+20, self.frame.size.height-2);
    _label.text = title;
        _label.textColor = [UIColor blackColor];
    _spView.backgroundColor = [UIColor clearColor];
    _spView.frame = CGRectMake(0, self.frame.size.height-2, size.width+20, 2);

    
}
-(void)setTitleColor:(UIColor *)titleColor{
    _label.textColor =titleColor;
    
}
-(void)setSpViewColor:(UIColor *)spViewColor{
    _spView.backgroundColor = spViewColor;

}
-(void)setTitleFont:(UIFont *)titleFont{
    _label.font = titleFont;

    
}
+(CGSize)setCellWightWithTitle:(NSString *)title{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(1000, 40)];
    
    size.width = size.width +20;
    size.height = 40;
    return size;

    
}


@end
