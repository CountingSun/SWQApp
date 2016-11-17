//
//  TextControlViewController.m
//  SWApp
//
//  Created by hhsoft on 16/4/20.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "TextControlViewController.h"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height

@interface TextControlViewController ()<UIWebViewDelegate>
@property (nonatomic,assign) CGFloat intI;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIScrollView *scrollView ;
@end
@implementation TextControlViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self textWebView];
    
}
-(void)textProgressView{
    _intI = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    UIProgressView *prol = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    prol.frame = CGRectMake(20, 100, 200, 30);
    prol.trackTintColor = [UIColor redColor];
    prol.progress = _intI;
    prol.progressTintColor = [UIColor blueColor];
    prol.layer.shadowOffset = CGSizeMake(3, 5);
    prol.layer.shadowOpacity = 5;
    prol.layer.shadowColor = [[UIColor blackColor]CGColor];
    prol.tag = 100;
    [self.view addSubview:prol];
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 60, 30)];
    addButton.backgroundColor = [UIColor blackColor];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *minusButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 60, 30)];
    minusButton.backgroundColor = [UIColor blackColor];
    [minusButton addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:minusButton];
    

    
}
-(void)add{
    _intI = _intI+0.1;
    if(_intI>1){
        _intI = 1;
    }

    UIProgressView *prol = (UIProgressView *)[self.view viewWithTag:100];
    [prol setProgress:_intI animated:YES];
}
-(void)minus{
    _intI = _intI-0.1;
    if(_intI<0){
        _intI = 0;
    }
    UIProgressView *prol = (UIProgressView *)[self.view viewWithTag:100];
    [prol setProgress:_intI animated:YES];
}
-(void)textWebView{
    //背景view
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    _scrollView.backgroundColor = [UIColor cyanColor];
    _scrollView.contentSize = CGSizeMake(screenW, screenH*2);
    [self.view addSubview:_scrollView];
    //颜色可变的layer
    CAGradientLayer *dLayer = [CAGradientLayer layer];
    dLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor purpleColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor];
    dLayer.startPoint = CGPointMake(0, 0);
    dLayer.endPoint = CGPointMake(1, 1);
//    dLayer.locations = @[@0.25,@0.25,@0.25,@0.25];//0-1
    dLayer.frame = CGRectMake(0, 0, screenW, 200);
    dLayer.startPoint = CGPointMake(0, 0.5);
    dLayer.endPoint = CGPointMake(1, 0.5);
    [_scrollView.layer addSublayer:dLayer];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, screenH)];
    NSString *url = @"http://www.tuicool.com/kans/1080622319?pn=7#";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    _webView.delegate = self;
    [_scrollView addSubview:_webView];
    //scrollHeight 为网页内容的实际高度。之后，自然需要关闭 UIWebView 的滚动效果，否则将会影响整体页面滚动
    UIScrollView *tempView=(UIScrollView *)[_webView.subviews objectAtIndex:0];
    tempView.scrollEnabled=NO;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *htmlHeight = [_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    webView.frame = CGRectMake(0, 30, screenW, [htmlHeight floatValue]);
    _scrollView.contentSize = CGSizeMake(screenW, [htmlHeight floatValue]+60);
    //可显示文字的layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"完毕";
    textLayer.fontSize = 14;
    textLayer.frame = CGRectMake(0, [htmlHeight floatValue]+30, screenW, 30);
    textLayer.foregroundColor = [[UIColor redColor]CGColor];
    textLayer.wrapped = YES;
    textLayer.alignmentMode = kCAAlignmentCenter;  //水平对齐方式

    
    [_scrollView.layer addSublayer:textLayer];

}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//
//    
//}
-(void)textString{

//    NSAttributedString
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
