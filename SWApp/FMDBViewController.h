//
//  FMDBViewController.h
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface FMDBViewController : UIViewController
{
    FMDatabase *db;
    NSString *database_path;
    
}

@end
