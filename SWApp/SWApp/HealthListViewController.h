//
//  HealthListViewController.h
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthListViewController : UIViewController
-(instancetype)initWithID:(NSInteger)ID;
-(void)getHealthListWithID:(NSInteger)ID;
@end
