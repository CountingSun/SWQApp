//
//  HHsoftViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/1.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "HHsoftViewController.h"
#import "ColorViewController.h"
#import "ClassViewController.h"
#import <objc/runtime.h>
#import "GlobalFile.h"
#import "DataEngine.h"
#import "HealthClassInfo.h"

#import "PlayerViewController.h"

@interface HHsoftViewController ()<ClassAndListViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic,strong)DataEngine *dataEngine;

@end
@implementation HHsoftViewController

-(void)viewDidLoad{
    self.delegate = self;

    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(rightBarButtonItemClickEvent)];
//    [self get];
    [self getHealthClass];
}
-(void)getHealthClass{

    if (_dataEngine == nil) {
        _dataEngine = [[DataEngine alloc]init];
    }
    [_dataEngine getHealthClassSucceed:^(NSMutableArray *arrClass) {
            if (_arrTitle == nil) {
                _arrTitle = [[NSMutableArray alloc]init];
            }

//        _arrTitle = arrClass;
        __block NSMutableArray *arrtitle = [[NSMutableArray alloc]init];
        [_arrTitle enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HealthClassInfo *healthClassInfo = (HealthClassInfo *)obj;
            [_arrTitle addObject:healthClassInfo.healthClassName];

        }];
        [self addClassButtonWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) arrTitle:_arrTitle selectColor:[UIColor redColor] unSelectColor:[UIColor blackColor] spViewSelectColor:[UIColor redColor] spViewUnSelectColor:[UIColor clearColor] titleFont:[UIFont systemFontOfSize:14]];
        [self setDefaultSelectIndex:0];
        [self reloadData];

    } getDataFail:^(NSError *err) {
        
    }];
}
-(void)rightBarButtonItemClickEvent{
    if (_arrTitle == nil) {
        _arrTitle = [[NSMutableArray alloc]init];
    }
    [_arrTitle removeAllObjects];
        for (NSInteger i = 0; i<40; i++) {
            
            NSString *title = [NSString stringWithFormat:@"菜单%@",[@(i) stringValue]];
            [_arrTitle addObject:title];
        }
        
    [self setDefaultSelectIndex:0];

    [self reloDataWithArrTitle:_arrTitle];

}
-(UIViewController *)viewController:(UIViewController *)viewController atIndex:(NSInteger)index identifier:(NSString *)identifier{
    static NSString *indetifi = @"indn";
    static NSString *classtifi = @"classtifi";
    static NSString *playerIdentifier = @"player";

    if (index<8) {
        ColorViewController *colorViewController = (ColorViewController *)[self dequWithIdentifier:indetifi];
        if (colorViewController == nil) {
            colorViewController = [[ColorViewController alloc]init];
            
        }
        colorViewController.colorInter =index;
        
        return colorViewController;
        
        
    }else if(index<15){
        ClassViewController *classViewController = (ClassViewController *)[self dequWithIdentifier:classtifi];
        if (classViewController == nil) {
            classViewController = [[ClassViewController alloc]init];
            
        }
        
        return classViewController;
        
        
    }else{
        PlayerViewController *playerViewController = (PlayerViewController *)[self dequWithIdentifier:playerIdentifier];
        if (playerViewController == nil) {
            playerViewController = [[PlayerViewController alloc]init];
            
        }
        
        return playerViewController;

    
        
    }
    
}
-(void)get{

    unsigned int count;
    Method *methods = class_copyMethodList([ClassViewController class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSLog(@"方法名:%@",NSStringFromSelector(sel));
    }

}

-(void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}
@end
