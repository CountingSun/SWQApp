//
//  ClassScrollView.m
//  SWApp
//
//  Created by hhsoft on 16/7/27.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "ClassScrollView.h"

@interface ClassScrollView()<UIScrollViewDelegate>
@property (nonatomic,assign) NSInteger controllerCount;

@end
@implementation ClassScrollView
-(instancetype)initWithFrame:(CGRect)frame controllerCount:(NSInteger)count{

    if (self = [super initWithFrame:frame]) {
        _controllerCount = count;
    }
    return self;
}
-(void)initData{

    self.contentSize = CGSizeMake(_controllerCount * self.frame.size.width,0);
    self.pagingEnabled = YES;
    self.scrollEnabled = NO;
    self.bounces = NO;
    UIViewController *controller = [[UIViewController alloc]init];
    
    NSString *identifier = @"ident";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:controller,identifier, nil];
    
    [self addSubview:[dict objectForKey:identifier]];
    
    
}
@end
