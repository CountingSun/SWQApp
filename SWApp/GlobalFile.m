//
//  GlobalFile.m
//  SWApp
//
//  Created by hhsoft on 16/7/30.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "GlobalFile.h"

@implementation GlobalFile
/**
 *  默认的背景色
 *
 *  @return
 */
+(UIColor *)defBackgroundColor{

    return [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
}

+(UIColor *)defaultThemeColor{

    return [UIColor redColor];
}
/**
 *  判断程序是不是第一次启动
 *
 *  @return <#return value description#>
 */
+(BOOL)isDefaults{

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"第一次启动");
        return YES;
    }else{
        NSLog(@"不是第一次启动");
        return NO;
    }

}
/**
 *  健康资讯类别
 *
 *  @return
 */
+(NSString *)healthUrl{

    return @"http://apis.baidu.com/tngou/info/classify?";
}
/**
 *  根据颜色返回图片
 *
 *  @param size
 *  @param color
 *
 *  @return
 */
+(UIImage *)getImageWithSize:(CGSize)size color:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}
/**
 *  加载动画时间
 *
 *  @return 自己定义的加载动画
 */
+(NSInteger)animationDuration{
    
    return 1;
}

/**
 *  正在加载的动画的四幅图片
 *
 *  @return
 */
+(NSArray *)arrLoadingImage
{
    NSMutableArray *arrImage=[NSMutableArray arrayWithCapacity:0];
    for (int i=1; i<=4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"loadingImage%@.png",[NSNumber numberWithInt:i]]];
        [arrImage addObject:image];
    }
    return [NSArray arrayWithArray:arrImage];
}

/**
 *  加载失败的图片
 *
 *  @return
 */
+(UIImage *)loadDataFailImage
{
    return [UIImage imageNamed:@"loadingFailed.png"];
}
/**
 *  没有数据的图片
 *
 *  @return
 */
+(UIImage *)loadingNoDataImage{
    
    return [UIImage imageNamed:@"loadingImageNoData.png"];
}
+(NSString *)loadWaitMessage{
    return @"正在加载,请稍后...";
}
+(NSString *)loadingIsNoMessage{
    return @"暂时没有可展示的数据哦";
}
+(NSString *)loadingErrorMessage{
    return @"加载失败, 请点击屏幕重试";
}
#pragma mark- 收集的一些方法

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
//世界时间转换为本地时间
+ (NSDate *)worldDateToLocalDate:(NSDate *)date
{
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:date];
    
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [date dateByAddingTimeInterval:offset];
    
    return localDate;
}
//字符串转时间
+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
//把秒转化成时分秒
+ (NSDictionary*)convertSecond2HourMinuteSecond:(int)second
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    int hour = 0, minute = 0;
    
    hour = second / 3600;
    minute = (second - hour * 3600) / 60;
    second = second - hour * 3600 - minute *  60;
    
    [dict setObject:[NSNumber numberWithInt:hour] forKey:@"hour"];
    [dict setObject:[NSNumber numberWithInt:minute] forKey:@"minute"];
    [dict setObject:[NSNumber numberWithInt:second] forKey:@"second"];
    
    return dict;
}

- (NSString*)getTimeString:(NSDictionary*)dict prefix:(NSString*)prefix
{
    int hour = [[dict objectForKey:@"hour"] intValue];
    int minute = [[dict objectForKey:@"minute"] intValue];
    int second = [[dict objectForKey:@"second"] intValue];
    
    NSString* formatter = hour < 10 ? @"0%d" : @"%d";
    NSString* strHour = [NSString stringWithFormat:formatter, hour];
    
    formatter = minute < 10 ? @"0%d" : @"%d";
    NSString* strMinute = [NSString stringWithFormat:formatter, minute];
    
    formatter = second < 10 ? @"0%d" : @"%d";
    NSString* strSecond = [NSString stringWithFormat:formatter, second];
    
    return [NSString stringWithFormat:@"%@%@:%@:%@", prefix, strHour, strMinute, strSecond];
}
+(BOOL)isPhoneNum:(NSString *)mobile{

    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];

}
// 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString*) password

{
    
    NSString*pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}
//正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString*) userName

{
    
    NSString*pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:userName];
    
    return isMatch;
    
}
//邮箱验证
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//银行卡号验证
+ (BOOL)isBankCard:(NSString *)cardNo{
    
    if (cardNo.length < 16) {
        return NO;
    }
    
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[cardNo length];
    // 取了最后一位数
    NSInteger lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
//身份证号验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
+(UIColor *)themeColor{
    return [GlobalFile colorWithRed:54 green:176 blue:243 alpha:1];
}
+(UIColor *)backgroundColor{
    return [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
}
+ (UIImage *)themeColorImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, [GlobalFile themeColor].CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}
+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 0.5);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
    
}
+ (UIColor *) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
    return color;
}

@end
