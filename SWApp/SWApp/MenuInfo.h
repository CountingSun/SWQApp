//
//  MenuInfo.h
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuInfo : NSObject
@property (nonatomic,assign) NSInteger menuID;
@property (nonatomic,copy) NSString *menuName;
@property (nonatomic,copy) NSString *menuIcon;

-(instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon;

@end
