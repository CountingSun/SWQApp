//
//  ControllerModel.m
//  SWApp
//
//  Created by hhsoft on 16/8/2.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "ControllerModel.h"

@implementation ControllerModel
-(UIViewController *)viewController{

    if (_viewController == nil) {
        _viewController = [[UIViewController alloc]init];
    }
    return _viewController;
}
@end
