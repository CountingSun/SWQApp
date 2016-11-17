//
//  DataEngine.h
//  SWApp
//
//  Created by hhsoft on 16/4/7.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HealthDetailInfo;

typedef void(^getDataSucceed)(NSMutableArray *arr);
//获取健康类别
typedef void(^getHealthSucceed)(NSMutableArray *arrClass);
//获取健康类别下的列表
typedef void(^getHealthListSucceed)(NSMutableArray *arrDetails);

//获取健康信息详情
typedef void(^getHealthDetailSucceed)(HealthDetailInfo *healthDetailInfo);
//获取图片列表
typedef void(^getImgListSucceed)(NSMutableArray *arrDetails);

typedef void(^getDataFail)(NSError *err);

@interface DataEngine : NSObject
-(void)getDataWithPage:(NSInteger)page getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail;
-(void)getWeatherWithname:(NSString *)name getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail;
-(void)getCookWithname:(NSString *)name getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail;
/**
 *  获取健康类别
 *
 *  @param getHealthSucceed
 *  @param getDataFail
 */
-(void)getHealthClassSucceed:(getHealthSucceed)getHealthSucceed getDataFail:(getDataFail)getDataFail;
/**
 *  /获取健康类别下的列表
 *
 *  @param healthClassID
 *  @param page
 *  @param pageSize
 *  @param getHealthListSucceed
 *  @param getDataFail          
 */
-(void)getHealthListWithHealthClassID:(NSInteger)healthClassID
                                 page:(NSInteger)page
                             pageSize:(NSInteger)pageSize
                 getHealthListSucceed:(getHealthListSucceed)getHealthListSucceed
                          getDataFail:(getDataFail)getDataFail;
/**
 *  获取健康信息详情
 *
 *  @param healthID
 *  @param getHealthDetailSucceed
 *  @param getDataFail
 */
-(void)getHealthDetailWithHealthID:(NSInteger)healthID
              getHealthDetailSucceed:(getHealthDetailSucceed)getHealthDetailSucceed
                       getDataFail:(getDataFail)getDataFail;
/**
 *  获取图片列表
 *
 *  @param page
 *  @param getImgListSuccee
 *  @param getDataFail
 */
-(void)getImgListWithPage:(NSInteger)page
   getImgListSucceed:(getImgListSucceed)getImgListSucceed
              getDataFail:(getDataFail)getDataFail;


@end
