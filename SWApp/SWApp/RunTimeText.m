//
//  RunTimeText.m
//  SWApp
//
//  Created by hhsoft on 16/4/16.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "RunTimeText.h"
#import <objc/runtime.h>
#import "MyLabel.h"


@interface RunTimeText ()

@end

@implementation RunTimeText

-(void)viewDidLoad{
    [super viewDidLoad];
//    [self runTimeText];
    self.view.backgroundColor = [UIColor whiteColor];
//    MyLabel *label = [[MyLabel alloc]init];
//    [label drawRect:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:label];
    [self label];
//    [self text4];
    [self print99Table];
    
}
//UILabel跑马灯
-(void)label{

    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 400, 30)];
    
    showLabel.text = @"噜啦啦噜啦啦噜啦噜啦噜，噜啦噜啦噜啦噜啦噜啦噜~~~";
    
    [self.view addSubview:showLabel];
    
    CGRect frame = showLabel.frame;
    
    //开始的位置
    frame.origin.x = -400;
    
    showLabel.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    
    [UIView setAnimationDuration:8.8f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationRepeatAutoreverses:NO];
    
    [UIView setAnimationRepeatCount:999999];
    
    frame = showLabel.frame;
    //结束的位置
    frame.origin.x = 800;
    
    showLabel.frame = frame;
    
    [UIView commitAnimations];
}
-(NSArray *)array{
    
    NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];

    return array;
}
-(void)text1{
    NSMutableArray *arrResult = [[NSMutableArray alloc]initWithCapacity:self.array.count];
    
    //开辟新的内存空间，然后判断是否存在，若不存在则添加到数组中，得到最终结果的顺序不发生变化。效率分析：时间复杂度为O ( n2 )：
    for (NSString *item in self.array) {
        if (![arrResult containsObject:item]) {
            [arrResult addObject:item];
        }
    }
    //集合操作可以通过valueForKeyPath来实现的，去重可以一行代码实现：但是返回的结果是无序的，与原来的顺序不同。
//    array = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",arrResult);

}
//利用NSDictionary去重，字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
-(void)text2{

    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc]initWithCapacity:self.array.count];
    for (NSString *item in self.array) {
        [resultDict setObject:item forKey:item];
        
    }
    NSArray *resultArray = [resultDict allValues];
    NSLog(@"%@",resultArray);
    //如果需要按照原来的升序排序，可以这样：
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    NSLog(@"%@", resultArray);
}
//第三种方法：利用集合NSSet的特性(确定性、无序性、互异性)，放入集合就自动去重了。但是它与字典拥有同样的无序性，所得结果顺序不再与原来一样。如果不要求有序，使用此方法与字典的效率应该是差不多的。效率分析：时间复杂度为O (n)：
-(void)text3{
    NSSet *set = [NSSet setWithArray:self.array];
    NSArray *resultArray = [set allObjects];
    NSLog(@"%@", resultArray);
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    NSLog(@"%@", resultArray);
}
/**
 *  可以直接使用有序集合
 */
-(void)text4{
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self.array];
    NSLog(@"%@", set.array);

}
-(void)textLabel{

    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 300, 30)];
    [self.view addSubview:textLabel];
    textLabel.backgroundColor = [UIColor grayColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"今日特价价格200"];
//更改某range字体颜色
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,3)];
    //字添加下划线
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6,3)];
    //字添加删除线
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:NSMakeRange(6,3)];

    textLabel.attributedText = attributedString;
}
/**
 *  强制转换objc_msgSend函数类型为带三个参数且返回值为void函数，然后才能传三个参数。此实战内容是，动态创建一个类，并创建成员变量和方法，最后赋值成员变量并发送消息。其中成员变量的赋值使用了KVC和object_setIvar函数两种方式，这些东西大家举一反三就可以了。

 */
-(void)runTimeText{
    //动态创建对象，创建一个Person 继承与NSObject类
    Class People = objc_allocateClassPair([NSObject class], "Person", 0);
    //为该类添加 NSString *_name成员变量
    class_addIvar(People, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    //为该类添加 int _age成员变量

    class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
    //注册方法名为say的方法
    SEL s = sel_registerName("say:");
    //为该类添加名为say的方法
    class_addMethod(People, s, (IMP)sayFunction, "v@:@");
    //注册该类
    objc_registerClassPair(People);
    //创建一个类的实例
    id peopleInstance = [[People alloc]init];
//kvc动态改变 对象personInstance中的实例变量
    [peopleInstance setValue:@"shiwenqinag" forKey:@"_name"];
    //从类中获取成员变量的ivar
    Ivar ageIvar = class_getInstanceVariable(People, "_age");
    //为peopleInstance的成员变量赋值
    object_setIvar(peopleInstance, ageIvar, @"18");
    //调用成员变量中的s方法选择器对应的方法 objc_msgSend(peopleInstance, s, @"大家好!"); // 这样写也可以
//    objc_msgSend(peopleInstance, s, @"大家好!");
    //    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
    
    //当people类或者他的子类的实例还存在 ，则不能调用objc_disposeClassPair这个方法，因此这里要销毁实例对象后才能销毁类
    peopleInstance = nil;
    objc_disposeClassPair(People);

    
}
void sayFunction(id self,SEL _cmd,id some){
NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"_name"],some);
}
/**
 *  将float转化为string并保留小数
 *
 *  @param tfloat 传人的价格
 *  @param count  价格的小数点位数
 *
 *  @return
 */
+ (NSString *) stringFromeFloat:(CGFloat)tfloat decimalPlacesCount:(NSInteger) count {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *positiveFormat = [NSString stringWithFormat:@"%@",@"#####0."];
    for (NSInteger i = 0; i<count; i++) {
        positiveFormat = [positiveFormat stringByAppendingString:@"0"];
    }
    [numberFormatter setPositiveFormat:positiveFormat];
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tfloat]];
}
//查找一个字符串2在字符串1中出现的次数

-(NSUInteger)countOfString:(NSString *)str1 withSubstring:(NSString *)str2
{
    NSArray * arr = [str1 componentsSeparatedByString:str2];
    return [arr count] -1 ;
}
//输入一段字符串，统计其中的单词个数
//比如：输入 I like China 输出：3

-(NSUInteger)countOfWordInString:(NSString *)str
{
    NSArray * arr = [str componentsSeparatedByString:@" "];
    int count = 0;
    for (NSString * obj in arr) {
        if (![obj isEqualToString:@""] ) {
            count++;
        }
    }
    return count;
}
//判断字符串str是否是合法的C变量，比如不能数字开头，只能字符串和_等开头

#define REGULAROFIFFOR3_1 (c >= 'a' && c<='z')||(c>='A'&&c<='Z')||(c=='_')
#define REGULAROFIFFOR3_2 (c >= 'a' && c<='z')||(c>='A'&&c<='Z')||(c>='1'&&c<='9')||(c=='_')
-(BOOL)isCValidVar:(NSString *)str
{
    char c = [str characterAtIndex:0];
    if (!(REGULAROFIFFOR3_1)) {
        return NO;
    }
    for(int i = 1; i < [str length]; i++)
    {
        c = [str characterAtIndex:i];
        if (!(REGULAROFIFFOR3_2)) {
            return NO;
        }
    }
    return YES;
}
//数组排序 arr数组中包含的是NSString字符串单词
//在英语类的App很多时候按照最后一个单词进行排序.
//将数组arr进行按照单词 最后一个字母进行升序排序(注意 最后一个字母)，比如arr中是(hello, world,apple,demo)
//返回是(world, hello,apple, demo) 如果最后一个字母相同，就按照倒数第二个，以此类推

-(NSArray *)sortWord:(NSArray *)arr
{
    NSMutableArray * marr = [NSMutableArray arrayWithArray:arr];
    [marr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        long objLen1 = [obj1 length];
        long objLen2 = [obj2 length];
        long top = objLen1<objLen2 ? objLen1:objLen2;
        for ( int i = 1 ; i < top; i++) {
            NSComparisonResult result = [[obj1 substringWithRange:NSMakeRange(objLen1-i, 1)] compare:[obj2 substringWithRange:NSMakeRange(objLen2-i, 1)]];
            if (result != 0) {
                return result;
            }
        }
        return NSOrderedSame;
    }];
    return marr;
}
//取得文件的扩展名
//比如 传入字符串 @"/home/apple/oc.txt" 返回:@"txt"
//传入字符串 @"/usr/apple/ios.m" 返回:@"m"

- (NSString *)extensionOfFilePath:(NSString *)path
{
    NSArray * arr = [path componentsSeparatedByString:@"."];
    return [arr objectAtIndex:[arr count]-1];
}
//6.将一个字符串数组中的元素组合成一个合法路径
//已知一个数组存放的是目录名字，要求组合成一个合法路径
//比如:数组中存放的是 home apple iOS
//返回 /home/apple/iOS

- (NSString *)joinPathOfComponents:(NSArray *)comp
{
    NSMutableString * mstr = [[NSMutableString alloc]init];
    for (id obj in comp) {
        [mstr appendFormat:@"/%@",obj];
    }
    return mstr;
}
//7.用NSLog打印九九乘法表

- (void)print99Table
{
    for(int i = 0 ; i < 10; i++)
    {
        for (int j = 0 ;  j < 10 ; j++) {
            NSLog(@"%d x %d = %d",i,j,i*j);
        }
    }
}
//8.将C++的标识符转成OC的标识符
//C++的标识符和OC一样由数字字母下划线组成，打头的不是数字。当标识符超过一个单词，C++采用全字母小写，单词间用下划线连接的书写规范，如:apple_ios
//OC采用除第一个单词外，其余单词首字母大写的书写规范，如：appleios
//传入C++标识符，返回OC标识符

- (NSString *)objcIdentifierFromCppIdentifier:(NSString *)idf
{
    NSArray * arr = [idf componentsSeparatedByString:@"_"];
    NSMutableString * mstr = [[NSMutableString alloc]init];
    for (id obj in arr) {
        if ([arr indexOfObject:obj] != 0 ) {
            NSMutableString * tmstr = [NSMutableString stringWithString:obj];
            [tmstr replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c",[tmstr characterAtIndex:0]-32]];
            [mstr appendString:tmstr];
        }else
        {
            [mstr appendString:obj];
        }
    }
    return mstr;
}
//9、剔除字符串中的全部空格
//传入: @"welcome to china”
//返回:@"welcometochina”

-(NSString *)stringWithoutSpaceInString:(NSString *)string
{
    NSArray * arr = [string componentsSeparatedByString:@" "];
    NSMutableString * mstr = [[NSMutableString alloc]init];
    for (id obj in arr) {
        [mstr appendString:obj];
    }
    return mstr;
}
//10、计算两个字符串所表示数字的和
//传入:@"123" @"459"
//返回:@"482"

-(NSString *)sumOfNumber:(NSString *)string1 andNumber:(NSString *)string2
{
    return [NSString stringWithFormat:@"%.0lf",[string1 doubleValue]+[string2 doubleValue]];
}
//11.计算两个字符串所表示数字的乘积
//传入:@"15" @"15"
//返回:@"255"

-(NSString *)productOfNumber:(NSString *)string1 andNumber:(NSString *)string2
{
    return [NSString stringWithFormat:@"%.0lf",[string1 doubleValue]*[string2 doubleValue]];
}
//12、将字符串后移
//将字符串向右移动指定位数，首尾循环
//如:string传入@ "welcometochina”, bits传入5
//返回:@“chinawelcometo”

-(NSString *)displacemetString:(NSString *)string forBits:(NSUInteger)bits
{
    NSMutableString * mstr = [[NSMutableString alloc]initWithString:string];
    NSString * str = [string substringFromIndex:[string length]-bits];
    [mstr replaceCharactersInRange:NSMakeRange(bits, [mstr length]-bits) withString:[mstr substringWithRange:NSMakeRange(0, [mstr length]-bits)]];
    [mstr replaceCharactersInRange:NSMakeRange(0, bits) withString:str];
    return mstr;
}
//13、传入两个字符串，找出第二个字符串中每个字符在第一个字符串中出现的次数
//传入:@"hello" @"abel"
//返回:@"a:0 b:0 e:1 l:2"

- (NSString *)timesInString:(NSString *)str1 withCharactersInString:(NSString *)str2
{
    NSMutableString * mstr = [[NSMutableString alloc]init];
    for(int i = 0 ; i < [str2 length]; i++)
    {
        NSString * charStr = [str2 substringWithRange:NSMakeRange(i, 1)];
        NSArray * tarr = [str1 componentsSeparatedByString:charStr];
        [mstr appendFormat:@"%@:%u ",charStr,[tarr count]-1];
    }
    return  mstr;
}
//14.按照新规则比较两个字符串的大小
//比较两个字符串的大小，首先比较两个字符串最后一个字符，如果最后一个字符相等，比较倒数第二个字符，如果字符相同，更长的大，依次类推，s1大返回1，s2大返回-1，相等返回0
//传入@"abc" @"abd" 返回-1
//传入@"abc" @"zabc" 返回-1
//传入@"abc" @"abc" 返回0

-(int)reverseWordsInString:(NSString *)str1 andOtherString:(NSString *)str2
{
    int length = (int)([str2 length]>[str1 length]?[str1 length]:[str2 length]);
    for (int i = length -1; i >= 0; i--) {
        if ([str1 characterAtIndex:i] > [str2 characterAtIndex:i]) {
            return 1;
        }else if([str1 characterAtIndex:i] < [str2 characterAtIndex:i]){
            return -1;
        }
    }
    return 0;
}
//15.将字符串中单词按照出现次数排序，每个单词只出现一次，源字符串中单词用下划线连接，生成字符串也应用下滑线连接
//如传入:@"good_good_study_good_study"
//返回:@"good_study"

- (NSString *)sortStringByNumberOfWordsFromString:(NSString *)str
{
    NSArray * arr = [str componentsSeparatedByString:@"_"];
    NSMutableArray * tgtArr = [[NSMutableArray alloc]init];
    NSMutableDictionary * countDict = [[NSMutableDictionary alloc]init];
    int count = 0;
    for (id obj in arr) {
        if (![tgtArr containsObject:obj]) {
            [tgtArr addObject:obj];
        }
    }
    for (id obj in tgtArr) {
        for (id obj2 in arr) {
            if (obj == obj2) {
                count++;
            }
        }
        [countDict setObject:[[NSNumber alloc]initWithInt:count] forKey:obj];
        count = 0;
    }
    [tgtArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [countDict[obj1] intValue] <[countDict[obj2] intValue];
    }];
    return [tgtArr componentsJoinedByString:@"_"];
}
//16.传入两个字符串，第二个字符串是一串连续数字，将第一个字符串（不超过9个字符），按照第二个字符串中所标示顺序重新排序
//传入:@"abcdef" @"465231"
//返回:@"dfebca”

-(NSString *)sortString:(NSString *)string asOrder:(NSString *)order
{
    NSMutableString * mstr = [[NSMutableString alloc]initWithString:string];
    NSMutableString * mstr2 = [[NSMutableString alloc]initWithString:order];
    
    for (int i = 0; i < [mstr length]; i++) {
        char c = [mstr characterAtIndex:i];
        for (int j = 0; j < [mstr2 length]; j++) {
            if ([mstr2 characterAtIndex:j] == i+49 ) {
                [mstr2 replaceCharactersInRange:NSMakeRange(j, 1) withString:[NSString stringWithFormat:@"%c",c]];
                break;
            }
        }
    }
    return mstr2;
}

-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

@end
