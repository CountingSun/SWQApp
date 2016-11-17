//
//  ClassAndListViewController.m
//  SWApp
//
//  Created by hhsoft on 16/7/30.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "ClassAndListViewController.h"
#import "SegmentedView.h"
#import "ColorViewController.h"
#import "ClassViewController.h"
#import "ControllerModel.h"

@interface ClassAndListViewController ()<UIScrollViewDelegate,ClassButtonDelegate>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableDictionary *dictController;
@property (nonatomic,strong) NSString *strIdentifier;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableArray *arrController;
@property (nonatomic,assign) NSInteger oldIndex;
@property (nonatomic,strong)UIViewController *controller;
@property (nonatomic,strong)UIViewController *oldController;
@property (nonatomic,strong) NSString *oldStrIdentifier;
@property (nonatomic,strong) SegmentedView *segmentedView;

@end
@implementation ClassAndListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)addClassButtonWithtitleArr:(NSMutableArray *)titleArr{

    _segmentedView = [[SegmentedView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) arrTitle:self.arrTitle];
    _segmentedView.classButtonDelegate = self;
    [self.view addSubview:_segmentedView];
    [self setupScrollView];

}
-(void)addClassButtonWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor titleFont:(UIFont *)titleFont{
    _segmentedView = [[SegmentedView alloc]initWithFrame:frame arrTitle:arrTitle selectColor:selectColor unSelectColor:unSelectColor titleFont:titleFont];
    _segmentedView.classButtonDelegate = self;
    [self.view addSubview:_segmentedView];
    [self setupScrollView];

    
}
-(void)addClassButtonWithFrame:(CGRect)frame arrTitle:(NSMutableArray *)arrTitle selectColor:(UIColor *)selectColor unSelectColor:(UIColor *)unSelectColor spViewSelectColor:(UIColor *)spViewSelectColor spViewUnSelectColor:(UIColor *)spViewUnSelectColor titleFont:(UIFont *)titleFont{
    _segmentedView = [[SegmentedView alloc]initWithFrame:frame arrTitle:arrTitle selectColor:selectColor unSelectColor:unSelectColor spViewSelectColor:spViewSelectColor spViewUnSelectColor:spViewUnSelectColor titleFont:titleFont];
    _segmentedView.classButtonDelegate = self;
    [self.view addSubview:_segmentedView];
    [self setupScrollView];


    
}
-(void)setDefaultSelectIndex:(NSInteger)index{
    [_segmentedView setDefSelectIndex:index];
}

-(void)reloDataWithArrTitle:(NSMutableArray *)arrTitle{
    [_segmentedView reloDataWithArrTitle:arrTitle];
    
}
- (void)setupScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(self.arrTitle.count * self.view.frame.size.width,0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
}
#pragma mark --- <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
-(void)reloadData{
    [_segmentedView reloDataWithArrTitle:self.arrTitle];
    self.scrollView.contentSize = CGSizeMake(self.arrTitle.count * self.view.frame.size.width,0);

    [self reloadViewControllerAtIndex:_index];
}
-(UIViewController *)dequWithIdentifier:(NSString *)identifier{
    if (_arrController == nil) {
        _arrController = [[NSMutableArray alloc]init];
    }
    __block UIViewController *viewController;
    _strIdentifier =identifier;
    [_arrController enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ControllerModel *controllerModel = _arrController[idx];
        if (controllerModel.identifier == _strIdentifier) {
            viewController =controllerModel.viewController;
        }
    }];
    
    return viewController;
}
-(void)reloadViewControllerAtIndex:(NSInteger)index{

    if (_delegate) {
        _controller = [_delegate viewController:self atIndex:index identifier:_strIdentifier];
        [self addChildViewController:_controller];
        [self.scrollView addSubview:_controller.view];
        [_arrController enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ControllerModel *controllerModel = (ControllerModel *)obj;
            if (_controller == controllerModel.viewController) {
                [_arrController removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
        

    }
    _controller.view.frame =CGRectMake(index*self.view.frame.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    if (_oldController != nil) {
        
            ControllerModel *model = [[ControllerModel alloc]init];
            model.viewController =_oldController;
            model.identifier =_oldStrIdentifier;
            [_arrController addObject:model];

    }
    _oldController = _controller;
    _oldStrIdentifier = _strIdentifier;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
-(void)classButtonClickOnIndexPath:(NSIndexPath *)indexPath{
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.frame.size.width *indexPath.row;
    [self.scrollView setContentOffset:offset animated:YES];
    if (_oldIndex == indexPath.row) {
        if (_delegate) {
//                _controller = [_delegate viewController:self atIndex:indexPath.row identifier:_strIdentifier];
        }
    }else{
        [self reloadViewControllerAtIndex:indexPath.row];
        
    }
    _oldIndex = indexPath.row;
    
    

    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
