//
//  GlobalFile.h
//  SWApp
//
//  Created by hhsoft on 16/7/30.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalFile : NSObject
/**
 *  默认的背景色
 *
 *  @return
 */
+(UIColor *)defBackgroundColor;

+(UIColor *)defaultThemeColor;
/**
 *  健康资讯类别
 *
 *  @return
 */
+(NSString *)healthUrl;

/**
 *  加载动画时间
 *
 *  @return 自己定义的加载动画
 */
+(NSInteger)animationDuration;

/**
 *  正在加载的动画的四幅图片
 *
 *  @return
 */
+(NSArray *)arrLoadingImage;
/**
 *  加载失败的图片
 *
 *  @return
 */
+(UIImage *)loadDataFailImage;
/**
 *  没有数据的图片
 *
 *  @return
 */
+(UIImage *)loadingNoDataImage;
/**
 *  等待提示语
 */
+(NSString *)loadWaitMessage;
/**
 *  没有数据提示语
 */
+(NSString *)loadingIsNoMessage;
/**
 *  网络错误提示语
 */
+(NSString *)loadingErrorMessage;
#pragma mark- 收集的一些方法

/**
 *  图片旋转
 *
 *  @param image
 *  @param orientation
 *
 *  @return
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
//世界时间转换为本地时间
+ (NSDate *)worldDateToLocalDate:(NSDate *)date;
//字符串转时间
+ (NSDate *)dateFromString:(NSString *)dateString;
/*=============================app内颜色=============================*/

/**
 *  主题颜色
 */
+(UIColor *)themeColor;
/**
 *  view背景颜色
 */
+(UIColor *)backgroundColor;
/**
 *  系统主题色图片
 *
 *  @return
 */
+ (UIImage *)themeColorImage;
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  自定义image颜色
 *
 *  @return
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 *  颜色
 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;



@end
