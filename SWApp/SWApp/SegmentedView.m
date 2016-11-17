//
//  SegmentedView.m
//  FoxHome
//
//  Created by hhsoft on 16/5/12.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "SegmentedView.h"
#import "SegmentedCollectionViewCell.h"
#import "HealthClassInfo.h"

@interface SegmentedView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic,assign) CGRect selfFrame;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIColor *titleSelectColor;
@property (nonatomic,strong) UIColor *titleUnSelectColor;
@property (nonatomic,strong) UIColor *spViewSelectColor;
@property (nonatomic,strong) UIColor *spViewUnSelectColor;
@property (nonatomic,strong) UIFont *titleFont;
@property (nonatomic,assign) BOOL isFirstInitView;

@end

@implementation SegmentedView

-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle{
    
    if (self = [super initWithFrame:frame]) {
        _arrTitle = arrTitle;
        _selfFrame = frame;
        _titleSelectColor = [UIColor redColor];
        _spViewSelectColor = [UIColor redColor];
        _titleUnSelectColor = [UIColor blackColor];
        _spViewUnSelectColor = [UIColor clearColor];
        _titleFont = [UIFont systemFontOfSize:14];

        [self drawView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor titleFont:(UIFont *)titleFont{
    if (self = [super initWithFrame:frame]) {
        _arrTitle = arrTitle;
        _selfFrame = frame;
        _titleSelectColor = selectColor;
        _spViewSelectColor = selectColor;
        _titleUnSelectColor = unSelectColor;
        _spViewUnSelectColor = [UIColor clearColor];
        _titleFont = titleFont;
        [self drawView];
    }

    return self;
}
-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor spViewSelectColor:(UIColor *)spViewSelectColor spViewUnSelectColor:(UIColor *)spViewUnSelectColor titleFont:(UIFont *)titleFont{
    if (self = [super initWithFrame:frame]) {
        _arrTitle = arrTitle;
        _selfFrame = frame;
        _titleSelectColor = selectColor;
        _spViewSelectColor = spViewSelectColor;
        _titleUnSelectColor = unSelectColor;
        _spViewUnSelectColor = spViewUnSelectColor;
        _titleFont = titleFont;

        [self drawView];
    }

    return self;

}
-(void)drawView{
    _isFirstInitView = YES;

    [self.collectionView reloadData];



    
}
-(void)setDefSelectIndex:(NSInteger)index{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];
}
-(void)timerEvent:(NSTimer *)timer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    SegmentedCollectionViewCell *cell = (SegmentedCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];

    if (cell) {
        cell.selected = YES;
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
        
        [timer invalidate];
        timer = nil;
    }
}
-(void)setArrTitles:(NSMutableArray *)arrTitles{
    _arrTitle = arrTitles;
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];


}
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SegmentedCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;

        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];

    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _arrTitle.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ident = @"CollectionViewCell";
    SegmentedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ident forIndexPath:indexPath];
    cell.title =_arrTitle[indexPath.row];
    cell.spViewColor = _spViewUnSelectColor;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HealthClassInfo *healthClassInfo =_arrTitle[indexPath.row];
    return [SegmentedCollectionViewCell setCellWightWithTitle:healthClassInfo.healthClassName];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentedCollectionViewCell *cell = (SegmentedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    
    cell.title =_arrTitle[indexPath.row];
    cell.titleColor = _titleSelectColor;
    cell.spViewColor = _spViewSelectColor;
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    if (_isFirstInitView) {
        if (indexPath.row == 0) {
            
        }else{
        
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
            _isFirstInitView = NO;

        }
    }
    if (_classButtonDelegate) {
        [_classButtonDelegate classButtonClickOnIndexPath:indexPath];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentedCollectionViewCell *cell = (SegmentedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.title =_arrTitle[indexPath.row];
    cell.titleColor = _titleUnSelectColor;
    cell.spViewColor = _spViewUnSelectColor;

    cell.title =_arrTitle[indexPath.row];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];


    
}
-(void)reloDataWithArrTitle:(NSMutableArray *)arrTitle;{
    _arrTitle = arrTitle;
    [self.collectionView reloadData];
}
@end
