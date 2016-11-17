//
//  SegmentedView.m
//  FoxHome
//
//  Created by hhsoft on 16/5/12.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "SegmentedView.h"
#import "SegmentedCollectionViewCell.h"
#import "LableInfo.h"

@interface SegmentedView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic,assign) CGRect selfFrame;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SegmentedView
-(instancetype)initWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle{
    
    if (self = [super initWithFrame:frame]) {
        _arrTitle = arrTitle;
        _selfFrame = frame;
        [self drawView];
    }
    return self;
}

-(void)drawView{
    [self addSubview:self.collectionView];

}
-(void)setArrTitles:(NSMutableArray *)arrTitles{
    _arrTitle = arrTitles;
    [self.collectionView reloadData];
}
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 10;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        flowLayout.itemSize = CGSizeMake(40, 40);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SegmentedCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;

    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _arrTitle.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ident = @"CollectionViewCell";
    SegmentedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ident forIndexPath:indexPath];
    LableInfo *labelinfo = _arrTitle[indexPath.row];
    cell.lableModel =labelinfo;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    LableInfo *labelInfo = _arrTitle[indexPath.row];
    return [SegmentedCollectionViewCell setCellHightWithLabelInfo:labelInfo];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentedCollectionViewCell *cell = (SegmentedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    
    
    LableInfo *labelModel = _arrTitle[indexPath.row];
    labelModel.labelIsSelect = YES;
    cell.lableModel =labelModel;
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    if (_classButtonDelegate) {
        [_classButtonDelegate classButtonClickEventWithLableInfo:labelModel indexPath:indexPath];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LableInfo *labelModel = _arrTitle[indexPath.row];
    labelModel.labelIsSelect = NO;
    SegmentedCollectionViewCell *cell = (SegmentedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.lableModel =labelModel;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (_classButtonDelegate) {
        [_classButtonDelegate classButtonClickEventWithLableInfo:labelModel indexPath:indexPath];
    }

    
}
-(void)reloDataWithArrTitle:(NSMutableArray *)arrTitle;{
    _arrTitle = arrTitle;
    [self.collectionView reloadData];
}
@end
