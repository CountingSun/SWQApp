//
//  SystemEngine.m
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "SystemEngine.h"
#import "MenuInfo.h"

@implementation SystemEngine
+(NSMutableArray *)arrMenu{
    MenuInfo *menu0 = [[MenuInfo alloc]initWithMenuID:0 menuName:@"第一" menuIcon:@"user"];
    MenuInfo *menu1 = [[MenuInfo alloc]initWithMenuID:1 menuName:@"第二" menuIcon:@"user"];
    MenuInfo *menu2 = [[MenuInfo alloc]initWithMenuID:2 menuName:@"第三" menuIcon:@"user"];
    MenuInfo *menu3 = [[MenuInfo alloc]initWithMenuID:3 menuName:@"第四" menuIcon:@"user"];
    MenuInfo *menu4 = [[MenuInfo alloc]initWithMenuID:4 menuName:@"第五" menuIcon:@"user"];
    MenuInfo *menu5 = [[MenuInfo alloc]initWithMenuID:5 menuName:@"第六" menuIcon:@"user"];
    MenuInfo *menu6 = [[MenuInfo alloc]initWithMenuID:6 menuName:@"第七" menuIcon:@"user"];
    MenuInfo *menu7 = [[MenuInfo alloc]initWithMenuID:7 menuName:@"图片处理" menuIcon:@"user"];

    NSMutableArray *arrMenu = [[NSMutableArray alloc]initWithObjects:menu0,menu1,menu2,menu3,menu4,menu5,menu6,menu7, nil];
    return arrMenu;
}
@end
