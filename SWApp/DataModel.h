//
//  DataModel.h
//  SWApp
//
//  Created by hhsoft on 16/4/7.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic,copy) NSString *dataYear;
@property (nonatomic,copy) NSString *datamonth;
@property (nonatomic,copy) NSString *day;
@property (nonatomic,assign) NSInteger dataType;
@property (nonatomic,copy) NSString *dataTitle;
@end
