//
//  ImageTextViewController.m
//  SWApp
//
//  Created by hhsoft on 2016/11/11.
//  Copyright © 2016年 swq. All rights reserved.
//




/*
 敲了好长时间才把 CIFilter 大部分的滤镜敲打完毕（就是好奇，也看看效果啥的）。也就是属于一遍敲打一边学习。（因为接触CIFilter的时候没有考虑到主线程的问题，所以都是在drawrect中画的。性能不好，也不想给你们看我敲的东西了，自己看着都觉着写的什么玩意）正好有这个机会，把我的学习经验跟大家分享一下，大家可以少走弯路。大家一起学习 Core Imgae （ 就当是无事了解一下也是好的啊），走上一条不“归路”……
 
 文／myScorpion（简书作者）
 原文链接：http://www.jianshu.com/p/2b54d18d111e
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 1.写在"CIFilter"前边关于"Core Image"的基础知识
 2.那些你应该知道常用"CIFilter"滤镜
 3."CIFilter"中的重要矩阵——"卷积矩阵"
 4.在"CIFilter"中的一些小技巧
 
 
 Core Image 基础知识
 
 
 #首先 —— 我们要明白，当我们操作 || 改变 Image 的时候，我们其实操作的是DATA数据`
 如果我们需要将图片转换为Data数据类型。那么我们可以这样做：
 
 UIImage *tempImage = [UIImage imageNamed:@"test_new"];
 CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(tempImage.CGImage));
 #ps:打印这个数据 " <0c71a5ff 0c70a5ff 0d71a5ff 0c71a5ff
 0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff>"
 随便截取一段打印的数据，每一个item代表一个颜色："R-G-B-A".
 了解了这个："**图片某像素颜色的抓取** && **图片颜色RGBA进行矩阵修改**"那就看起来就容易多了。
 
 #当然你还要注意的就是 UIImage | CGImage | CIImage 之间的区别
 其实归结到底，他们只是不同的框架下得产物，同样也正因为不同的框架，使得他们的操作发生了质的变化。
 •UIImage : 负责UIKit中的图片展示&数据管理。(CPU计算)
 •CGImage: CoreGraphic中对图片的"旋转、缩放 & 挖取"工作。（GPU计算）
 •CIImage : 描述一个如何产生一个图像，但其本身本身并不包含图像数据，
 它代表的是图像数据或者生成图像数据的流程（如"滤镜的输出"）
 #Core Image 的优势：
 最大化利用其所运行之上的硬件的。每个滤镜实际上的实现，即-"内核"，是由一个
 GLSL(即 OpenGL 的着色语言) 的子集来书写的.当多个滤镜连接成一个滤镜图表，
 Core Image 便把内核串在一起来构建一个可在 GPU 上运行的高效程序
 "事实上，图像处理和渲染就是将渲染到窗口的像素点进行许多的浮点运算，"
 "那么GPU (图形处理器) 可以高效的完成。"
 */
#import "ImageTextViewController.h"

@interface ImageTextViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) CIContext *context;
@property (nonatomic,strong) CIFilter *filter;
@property (nonatomic,strong) CIImage *beginImage;
@property (nonatomic,strong) CIImage *outputImage;
@property (nonatomic,strong) UIImage *showImage;

@end

@implementation ImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self coreImage];
    self.imageView.frame = CGRectMake(0, 64, 200, 200);
    self.imageView.image = [UIImage imageNamed:@"baby"];
    [self creactControlButtonWitharrTitle:self.arrTitle];
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 20)];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    slider.value = 0.5;
    
    [self.view addSubview:_imageView];
    
    [self disposeImage];
}
-(NSMutableArray *)arrTitle{

    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"menu1",@"menu2",@"men3",@"menu4", nil];
    
    return arr;
}
-(void)creactControlButtonWitharrTitle:(NSMutableArray *)arrTitle{
    CGFloat buttonW = self.view.frame.size.width/arrTitle.count;
    
    for (NSInteger i = 0; i<arrTitle.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonW*i, 350, buttonW, 40)];
        [button setTitle:arrTitle[i] forState:0];
        button.tag = i;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 1;
        
        
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
}
-(void)buttonEvent:(UIButton *)button{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        switch (button.tag) {
            case 0:
            {
                _filter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues:kCIInputImageKey, _beginImage, nil];

                
                
            }
                break;
            case 1:{
                _filter = [CIFilter filterWithName:@"CICategoryTileEffect" keysAndValues:kCIInputImageKey, _beginImage, nil];

                
            }
                break;
            case 2:{
                
                _filter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues:kCIInputImageKey, _beginImage, nil];

            }
                break;

            default:{
                _filter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues:kCIInputImageKey, _beginImage, nil];

                
            }
                break;
        }

        _outputImage = [_filter outputImage];
        CGImageRef cgimg = [_context createCGImage:_outputImage fromRect:[_outputImage extent]];
        _showImage = [UIImage imageWithCGImage:cgimg];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = _showImage;
            CGImageRelease(cgimg);
        });
        
    });

    
}
-(void)sliderValueChange:(UISlider *)slider{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [_filter setValue:@(slider.value) forKey:@"inputIntensity"];
        _outputImage = [_filter outputImage];
        CGImageRef cgimg = [_context createCGImage:_outputImage fromRect:[_outputImage extent]];
        _showImage = [UIImage imageWithCGImage:cgimg];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = _showImage;
            CGImageRelease(cgimg);
        });
        
    });
    
    
}

-(UIImageView *)imageView{

    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
-(void)disposeImage{
    NSLog(@"开始处理图片");

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 处理耗时操作的代码块...
        UIImage *image = [self outputImageWithFilterName:@"baby"];
        if(image){
        
            NSLog(@"处理图片完成");

        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = image;
            NSLog(@"刷新ui");
        });
        
    });

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)coreImage{

    UIImage *image = [UIImage imageNamed:@"baby"];
    CFDataRef imageDataRef = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSLog(@"%@",imageDataRef);
}

- (UIImage *)outputImageWithFilterName:(NSString *)filterName {
    
    // 1
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"baby@2x" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    
    // CGImage 是一个C接口，即使有ARC，也需要你自己来做内存管理
    /*
    CIImage *beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath]; // 1
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, @"inputIntensity", @0.8, nil];
    
    CIImage *outputImage = [filter outputImage]; // 2
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]]; // 3
    UIImage *newImage = [UIImage imageWithCGImage:cgimg]; self.imageView.image = newImage; // 4
    CGImageRelease(cgimg);
     */
    _beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath]; // 1
    _context = [CIContext contextWithOptions:nil];
    _filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, _beginImage, @"inputIntensity", @0.8, nil];
    _outputImage = [_filter outputImage]; // 2
    CGImageRef cgimg = [_context createCGImage:_outputImage fromRect:[_outputImage extent]]; // 3
    _showImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);

    return _showImage;

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
