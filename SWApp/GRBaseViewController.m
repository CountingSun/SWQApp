//
//  GRBaseViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/15.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "GRBaseViewController.h"
#import "SVProgressHUD.h"

@interface GRBaseViewController ()

@end

@implementation GRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeBottom;
}

-(void)showSuccessWithStatus:(NSString *)status{

    [SVProgressHUD showSuccessWithStatus:status];

}
-(void)showWithStatus:(NSString *)status{
    
    [SVProgressHUD showWithStatus:status];
}
-(void)showErrorWithStatus:(NSString *)status{
    
    [SVProgressHUD showErrorWithStatus:status];
}
-(void)dismissWithDelay:(NSInteger)status{
    
      [SVProgressHUD dismissWithDelay:status];

}
-(void)dismiss{
    [SVProgressHUD dismissWithDelay:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
