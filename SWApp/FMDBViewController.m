//
//  FMDBViewController.m
//  SWApp
//
//  Created by hhsoft on 16/4/8.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDatabase.h"
#import "AddressInfo.h"

#define DBNAME    @"personinfo.sqlite"
#define ID        @"id"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height

@interface FMDBViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *dataTable ;
@property (nonatomic,strong) NSMutableArray *arrData;

@end

@implementation FMDBViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    db = [FMDatabase databaseWithPath:database_path];
    
    [super viewDidLoad];
    [self selectData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertData)];

    // Do any additional setup after loading the view.
}


-(UITableView *)dataTable{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (_dataTable == nil) {
        _dataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        _dataTable.delegate =  self ;
        _dataTable.dataSource = self;
        [self.view addSubview:_dataTable];
        [_dataTable setTableFooterView:v];
        
    }
    return _dataTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfo *addressInfo = _arrData[indexPath.row];
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@ 年龄：%@  地址：%@",addressInfo.name,addressInfo.age,addressInfo.address];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}

- (void)loadView{
    [super loadView];
//    [self selectData];
    
//    UIButton *openDBBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect=CGRectMake(60, 60, 200, 50);
//    openDBBtn.frame=rect;
//    [openDBBtn addTarget:self action:@selector(createTable) forControlEvents:UIControlEventTouchDown];
//    [openDBBtn setTitle:@"createTable" forState:UIControlStateNormal];
//    [self.view addSubview:openDBBtn];
//    
//    
//    UIButton *insterBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect2=CGRectMake(60, 130, 200, 50);
//    insterBtn.frame=rect2;
//    [insterBtn addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchDown];
//    [insterBtn setTitle:@"insert" forState:UIControlStateNormal];
//    [self.view addSubview:insterBtn];
//    
//    
//    UIButton *updateBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect3=CGRectMake(60, 200, 200, 50);
//    updateBtn.frame=rect3;
//    [updateBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchDown];
//    [updateBtn setTitle:@"update" forState:UIControlStateNormal];
//    [self.view addSubview:updateBtn];
//    
//    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect4=CGRectMake(60, 270, 200, 50);
//    deleteBtn.frame=rect4;
//    [deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchDown];
//    [deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
//    [self.view addSubview:deleteBtn];
//    
//    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect5=CGRectMake(60, 340, 200, 50);
//    selectBtn.frame=rect5;
//    [selectBtn addTarget:self action:@selector(selectData) forControlEvents:UIControlEventTouchDown];
//    [selectBtn setTitle:@"select" forState:UIControlStateNormal];
//    [self.view addSubview:selectBtn];
//    
//    
//    UIButton *multithreadBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGRect rect6=CGRectMake(60, 410, 200, 50);
//    multithreadBtn.frame=rect6;
//    [multithreadBtn addTarget:self action:@selector(multithread) forControlEvents:UIControlEventTouchDown];
//    [multithreadBtn setTitle:@"multithread" forState:UIControlStateNormal];
//    [self.view addSubview:multithreadBtn];
    
    
}


- (void)createTable{
    //sql 语句
    if ([db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [db close];
        
    }
}

-(void) insertData{
    if ([db open]) {
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                               TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
        BOOL res = [db executeUpdate:insertSql1];
        NSString *insertSql2 = [NSString stringWithFormat:
                                @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                                TABLENAME, NAME, AGE, ADDRESS, @"李四", @"12", @"济南"];
        BOOL res2 = [db executeUpdate:insertSql2];
        if (res2) {
            
        }
        
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [db close];
        
    }
    
}

-(void) updateData{
    if ([db open]) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
                               TABLENAME,   AGE,  @"15" ,AGE,  @"13"];
        BOOL res = [db executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [db close];
        
    }
    
}

-(void) deleteData{
    if ([db open]) {
        
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'",
                               TABLENAME, ADDRESS, @"济南"];
        BOOL res = [db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [db close];
        
    }
    
}



-(void) selectData{
    
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
//        if (_arrData == nil) {
            _arrData = [[NSMutableArray alloc]init];
//        }
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            AddressInfo *addressInfo = [[AddressInfo alloc]init];

            int Id = [rs intForColumn:ID];
            NSString * name = [rs stringForColumn:NAME];
            NSString * age = [rs stringForColumn:AGE];
            NSString * address = [rs stringForColumn:ADDRESS];
            addressInfo.name = name;
            addressInfo.age = age;
            addressInfo.address = address;
            addressInfo.dataID =Id;
            [_arrData addObject:addressInfo];
            
//            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
        NSLog(@"%lu",(unsigned long)_arrData.count);
        [self.dataTable reloadData];
        [db close];
    }
    
}
-(void) multithread{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    dispatch_async(q1, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                
                NSString *insertSql1= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];
                
                NSString * name = [NSString stringWithFormat:@"jack %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];
                
                
                BOOL res = [db2 executeUpdate:insertSql1, name, age,@"济南"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });
    
    dispatch_async(q2, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                NSString *insertSql2= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];
                
                NSString * name = [NSString stringWithFormat:@"lilei %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];
                
                BOOL res = [db2 executeUpdate:insertSql2, name, age,@"北京"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
