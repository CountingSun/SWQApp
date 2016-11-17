//
//  AddViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/15.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 60, 30)];
    [cancelButton setTintColor:[UIColor colorWithWhite:128/255.0f alpha:1]];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setTitle:@"Χ 取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];

}
-(void)cancelButtonPressed:(UIButton *)cancelButton{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
