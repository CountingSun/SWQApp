//
//  HealthListInfo.h
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthListInfo : NSObject
@property (nonatomic,assign) NSInteger healthListID;
@property (nonatomic,copy) NSString *healthListKeyWorks;
@property (nonatomic,assign) NSInteger healthListCount;
@property (nonatomic,copy) NSString *healthListTime;
@property (nonatomic,copy) NSString *healthListTitle;
@property (nonatomic,copy) NSString *healthListDescription;
@property (nonatomic,copy) NSString *healthListImg;

@end
