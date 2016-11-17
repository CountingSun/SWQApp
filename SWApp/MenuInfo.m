//
//  MenuInfo.m
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo
-(instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon{

    if (self == [super init]) {
        _menuID = menuID;
        _menuName = menuName;
        _menuIcon = menuIcon;
    }
    return self;
}
@end
