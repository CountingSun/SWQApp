//
//  HealthDetailViewController.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "HealthDetailViewController.h"
#import "GlobalFile.h"
#import "UIViewController+PromptView.h"
#import "DataEngine.h"
#import "HealthDetailInfo.h"

@interface HealthDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,assign) NSInteger healthID;
@property (nonatomic,strong) HealthDetailInfo *healthDetailInfo;
@end

@implementation HealthDetailViewController
-(instancetype)initWithHealthID:(NSInteger)healthID{

    if (self = [super init]) {
        _healthID = healthID;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile defBackgroundColor];
    [self showPromptOnView:self.view ViewWithFrame:self.view.bounds imageArr:[GlobalFile arrLoadingImage] message:[GlobalFile loadWaitMessage] totalDuration:[GlobalFile animationDuration]];

    [self getHealthDetail];
}
-(void)getHealthDetail{

    [[[DataEngine alloc]init] getHealthDetailWithHealthID:_healthID getHealthDetailSucceed:^(HealthDetailInfo *healthDetailInfo) {
        [self hiddenLoadingView];
        _healthDetailInfo = healthDetailInfo;
        self.navigationItem.title = healthDetailInfo.healthDetailTitle;
        [self.view addSubview:self.webView];

        
    } getDataFail:^(NSError *err) {
        
    }];
}
-(UIWebView *)webView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    NSString *hemlString = [NSString stringWithFormat:@"<head><style>img{width:96%% !important; margin-bottom:2px;}</style></head><center style=\"font-size:20px;font-weight:bold\"></center><div style=\"width: 96%%; font-size: 14px; line-height: 1.4; text-align:left; margin: auto;margin-bottom: 5px;\">%@</div>",_healthDetailInfo.healthDetailHtmlStr];
    
    [webView loadHTMLString:hemlString baseURL:nil];
    
    return webView;
}
#pragma mark -webViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hiddenLoadingView];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
