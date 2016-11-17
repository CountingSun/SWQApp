//
//  ClassAndListViewController.m
//  SWApp
//
//  Created by hhsoft on 16/7/30.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "ClassAndListViewController.h"
#import "SegmentedView.h"
#import "LableInfo.h"
#import "ColorViewController.h"
#import "ClassViewController.h"

@interface ClassAndListViewController ()<UIScrollViewDelegate,ClassButtonDelegate>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableDictionary *dictController;
@property (nonatomic,strong) NSString *strIdentifier;
@property (nonatomic,assign) NSInteger index;
@end
@implementation ClassAndListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _index = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addClassButtonWithtitleArr:self.arrTitle];

}
-(NSMutableArray *)arrTitle{
    if (_arrTitle == nil) {
        _arrTitle = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i<20; i++) {
            LableInfo *lableInfo = [[LableInfo alloc]init];
            lableInfo.labelID = i;
            lableInfo.labelIsSelect = NO;
            lableInfo.labelName = [NSString stringWithFormat:@"菜单%@",[@(i) stringValue]];
            [_arrTitle addObject:lableInfo];
        }

    }
    
    return _arrTitle;
}
-(void)addClassButtonWithtitleArr:(NSMutableArray *)titleArr{

    SegmentedView *segmentedView = [[SegmentedView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) arrTitle:self.arrTitle];
    segmentedView.backgroundColor = [UIColor redColor];
    segmentedView.classButtonDelegate = self;
    [segmentedView reloDataWithArrTitle:self.arrTitle];
    [self.view addSubview:segmentedView];
    [self setupScrollView];

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
    [self reloadViewControllerAtIndex:_index];
}
-(UIViewController *)dequWithIdentifier:(NSString *)identifier{
    if (_dictController == nil) {
        _dictController = [[NSMutableDictionary alloc]init];
    }
    _strIdentifier =identifier;
    UIViewController *viewController = [_dictController objectForKey:_strIdentifier];

    return viewController;
}
-(void)reloadViewControllerAtIndex:(NSInteger)index{

    UIViewController *controller;
    if (_delegate) {
        controller = [_delegate viewController:self atIndex:index identifier:_strIdentifier];
        [_dictController setObject:controller forKey:_strIdentifier];
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
    }
    controller.view.frame = _scrollView.bounds;

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
//    _index = index;
//    [self reloadViewControllerAtIndex:index];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)classButtonClickEventWithLableInfo:(LableInfo *)lableInfo indexPath:(NSIndexPath *)indexPath{

    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.frame.size.width *indexPath.row;
    [self.scrollView setContentOffset:offset animated:YES];
    [self reloadViewControllerAtIndex:indexPath.row];

   

}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
