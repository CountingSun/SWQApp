//
//  PlayerViewController.m
//  MyApp
//
//  Created by hhsoft on 16/4/1.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import "PlayerViewController.h"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height
#import "TurnViewController.h"
#import "DataEngine.h"
#import "UIImageView+WebCache.h"
#import "GirlsImageInfo.h"
#import "iCarousel.h"
#import "GlobalFile.h"
#import "GirlImageView.h"

@interface PlayerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,iCarouselDataSource, iCarouselDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (strong, nonatomic) iCarousel *iCaView;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"点击" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClickEvent)];
    self.view.backgroundColor = [GlobalFile defBackgroundColor];
    [self getInfo];
}
-(void)rightBarButtonItemClickEvent{
    TurnViewController *turnViewController = [[TurnViewController alloc]init];
    
    turnViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:turnViewController animated:YES];
    
}
-(void)getInfo{

    [[[DataEngine alloc]init] getImgListWithPage:20 getImgListSucceed:^(NSMutableArray *arrDetails) {
        
        if (_arrData == nil) {
            _arrData = [[NSMutableArray alloc]init];
        }
        [_arrData addObjectsFromArray:(NSMutableArray *)arrDetails];
//        [self.collectionView reloadData];
        
        [self createiCaView];
    } getDataFail:^(NSError *err) {
        
    }];
}
-(UICollectionView *)collectionView{

    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize  = CGSizeMake(20, 20);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        [_collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"myCell"];
    }
    return _collectionView;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    GirlsImageInfo *girlsImageInfo = _arrData[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:girlsImageInfo.imgUrl] placeholderImage:[UIImage imageNamed:@"baby"]];
//    imageView.image = [UIImage imageNamed:@"baby"];
    [cell.contentView addSubview:imageView];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return CGSizeMake(120, 120);
    }
    return CGSizeMake(50, 50);

}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{

    
}


////实现长按复制 粘贴 剪切 需要实现下面的这3个方法
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}
//
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
//    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]
//        || [NSStringFromSelector(action) isEqualToString:@"paste:"]||[NSStringFromSelector(action) isEqualToString:@"cut:"])
//        return YES;
//    return NO;
//    
//}
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
//    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]){
//    
//        NSLog(@"100");
//    }else if([NSStringFromSelector(action) isEqualToString:@"paste:"]){
//    
//        NSLog(@"200");
//    } else
//    {
//    
//        NSLog(@"300");
//
//    }
//}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 10, 5, 10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
// 允许选中时，高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 设置是否允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    
}








-(void)createiCaView{
    
    self.iCaView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 100, screenW, screenH-64)];
    
    self.iCaView.delegate = self;
    self.iCaView.dataSource = self;
    self.iCaView.type = iCarouselTypeCustom;
    self.iCaView.pagingEnabled = YES;
    
    self.iCaView.backgroundColor =[GlobalFile defBackgroundColor];
    
    
    [self.view addSubview:self.iCaView];
    
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _arrData.count;
    
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, screenW-50, screenH-10)];
        
    }
    view.backgroundColor = [UIColor whiteColor];
    GirlsImageInfo *girlsImageInfo = _arrData[index];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW-50,screenW-50/76*50)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:girlsImageInfo.imgUrl] placeholderImage:[UIImage imageNamed:@"baby"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    [view addSubview:imageView];
    return view;
}
-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.iCaView.itemWidth * 1.4, 0.0, 0.0);
}



@end
