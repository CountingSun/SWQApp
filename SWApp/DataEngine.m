//
//  DataEngine.m
//  SWApp
//
//  Created by hhsoft on 16/4/7.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "DataModel.h"
#import "GlobalFile.h"
#import "HealthClassInfo.h"
#import "HealthListInfo.h"
#import "HealthDetailInfo.h"
#import "GirlsImageInfo.h"


@implementation DataEngine

-(void)getDataWithPage:(NSInteger)page getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail{
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
    NSString *urlStr= [NSString stringWithFormat:@"http://apis.baidu.com/avatardata/historytoday/lookup?yue=1&ri=1&type=1&page=%@&rows=20&dtype=JOSN&format=false",[NSNumber numberWithInteger:page]];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@", dic);
        
        NSMutableArray *resultDict=[[NSMutableArray alloc]init];
        resultDict=[dic objectForKey:@"result"];
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in resultDict)
        {
            DataModel *dataModel=[[DataModel alloc]init];
            dataModel.datamonth=[dict objectForKey:@"month"];
            dataModel.dataType=[[dict objectForKey:@"type"] integerValue];
            dataModel.dataYear=[dict objectForKey:@"year"];
            dataModel.day=[dict objectForKey:@"day"];
            dataModel.dataTitle=[dict objectForKey:@"title"];
            [array addObject:dataModel];
        }
        NSLog(@"%@",array);
        getDataSucceed(array);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        getDataFail(error);
    }];
}
-(void)getWeatherWithname:(NSString *)name getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail{
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             name, @"city",
                             @"61abf15dbbd76430876e7f191e560006",@"apikey",nil];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
//     post请求
        [manager POST:@"http://apis.baidu.com/heweather/weather/free" parameters:dic constructingBodyWithBlock:^(id  _Nonnull formData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
    
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
    
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            // 请求成功，解析数据
            NSLog(@"%@", responseObject);
    
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    
            NSLog(@"%@", dic);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
            // 请求失败
            NSLog(@"%@", [error localizedDescription]);
        }];

    
}
-(void)getCookWithname:(NSString *)name getDataSucceed:(getDataSucceed)getDataSucceed getDataFail:(getDataFail)getDataFail{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
   
    NSString *urlStr= [NSString stringWithFormat:@"http://apis.baidu.com/tngou/cook/name?name=%@",name];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@", dic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        getDataFail(error);
    }];

}

-(void)getHealthClassSucceed:(getHealthSucceed)getHealthSucceed getDataFail:(getDataFail)getDataFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
    [manager GET:[GlobalFile healthUrl] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictResult = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *arrResult = [dictResult objectForKey:@"tngou"];
        NSMutableArray *arrData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictHealth in arrResult) {
            HealthClassInfo *healthClassInfo = [[HealthClassInfo alloc]init];
            healthClassInfo.healthClassName = [dictHealth objectForKey:@"name"];
            healthClassInfo.healthClassID = [[dictHealth objectForKey:@"id"] integerValue];
            [arrData addObject:healthClassInfo];
        }
        getHealthSucceed(arrData);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
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
                          getDataFail:(getDataFail)getDataFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://apis.baidu.com/tngou/info/list?id=%@&page=%@&rows=%@",[@(healthClassID)stringValue],[@(page)stringValue],[@(pageSize)stringValue]];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictResult = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *arrResult = [dictResult objectForKey:@"tngou"];
        NSMutableArray *arrData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictHealth in arrResult) {
            HealthListInfo *healthListInfo = [[HealthListInfo alloc]init];
            healthListInfo.healthListCount = [[dictHealth objectForKey:@"count"]integerValue];
            healthListInfo.healthListDescription = [dictHealth objectForKey:@"description"];
            healthListInfo.healthListID = [[dictHealth objectForKey:@"id"]integerValue];
            healthListInfo.healthListKeyWorks = [dictHealth objectForKey:@"keywords"];
            healthListInfo.healthListTime = [dictHealth objectForKey:@"time"];
            healthListInfo.healthListTitle = [dictHealth objectForKey:@"title"];
            healthListInfo.healthListImg = [dictHealth objectForKey:@"img"];

            [arrData addObject:healthListInfo];
        }
        getHealthListSucceed(arrData);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
}
/**
 *  获取健康信息详情
 *
 *  @param healthID
 *  @param getHealthDetailSucceed
 *  @param getDataFail
 */
-(void)getHealthDetailWithHealthID:(NSInteger)healthID
            getHealthDetailSucceed:(getHealthDetailSucceed)getHealthDetailSucceed
                       getDataFail:(getDataFail)getDataFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://apis.baidu.com/tngou/info/show?id=%@",[@(healthID)stringValue]];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictResult = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        
        HealthDetailInfo *healthDetailInfo = [[HealthDetailInfo alloc]init];
        healthDetailInfo.healthDetailHtmlStr = [dictResult objectForKey:@"message"];
        healthDetailInfo.healthDetailTitle = [dictResult objectForKey:@"title"];

        getHealthDetailSucceed(healthDetailInfo);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}
/**
 *  获取图片列表
 *
 *  @param page
 *  @param getImgListSuccee
 *  @param getDataFail
 */
-(void)getImgListWithPage:(NSInteger)page
        getImgListSucceed:(getImgListSucceed)getImgListSucceed
              getDataFail:(getDataFail)getDataFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"61abf15dbbd76430876e7f191e560006" forHTTPHeaderField:@"apikey"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://apis.baidu.com/txapi/mvtp/meinv?num=%@",[@(page)stringValue]];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictResult = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *arrImg = [dictResult objectForKey:@"newslist"];
        NSMutableArray *arrData = [[NSMutableArray alloc]init];

        for (NSDictionary *dicr in arrImg) {
            GirlsImageInfo *girlsImageInfo = [[GirlsImageInfo alloc]init];
            girlsImageInfo.imgTitle = [dicr objectForKey:@"title"];
            girlsImageInfo.imgUrl = [dicr objectForKey:@"picUrl"];

            [arrData addObject:girlsImageInfo];
        }
        
        getImgListSucceed(arrData);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

@end
