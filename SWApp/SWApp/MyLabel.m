//
//  MyLabel.m
//  SWApp
//
//  Created by hhsoft on 16/4/21.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel
//NSAttributedString继承于NSObject，并且不支持任何draw的方法，那我们就只能自己draw了。
-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
//    
//    NSAttributedString *attriString = [self getAttributedString];
//    
//    //在代码中我们调整了CTM(current transformation matrix)，这是因为Quartz 2D的坐标系统不同
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextConcatCTM(ctx, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, rect.size.height), 1.f, -1.f));
//    
//    //CTFramesetter是CTFrame的创建工厂，NSAttributedString需要通过CTFrame绘制到界面上，得到CTFramesetter后，创建path（绘制路径），然后得到CTFrame，最后通过CTFrameDraw方法绘制到界面上。
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriString);
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, rect);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
//    CFRelease(path);
//    CFRelease(framesetter);
//    
//    CTFrameDraw(frame, ctx);
//    CFRelease(frame);
    
     //------------------------------------------------------------------------
     //----------------取消注释，同样可以实现UILabel上展示不同样式的文字--------------
     //------------------------------------------------------------------------
     CATextLayer *textLayer = [CATextLayer layer];
     textLayer.string = [self getAttributedString];
     textLayer.frame = rect;//可调整位置
     textLayer.backgroundColor = [UIColor purpleColor].CGColor;
     [self.layer addSublayer:textLayer];
}

-(NSMutableAttributedString *)getAttributedString{
    //创建一个NSMutableAttributedString
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"Come on,baby!Come on,baby!Come on,baby!"];
    //把this的字体颜色变为红色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)[UIColor redColor].CGColor
                        range:NSMakeRange(0, 4)];
    //把is变为黄色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)[UIColor yellowColor].CGColor
                        range:NSMakeRange(5, 16)];
    //改变this的字体，value必须是一个CTFontRef
    [attriString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,14,NULL))
                        range:NSMakeRange(0, 4)];
    //给this加上下划线，value可以在指定的枚举中选择
    [attriString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:kCTUnderlineStyleThick]
                        range:NSMakeRange(0, 4)];
    
    /*
     换行的实现
     
     如果想要计算NSAttributedString所要的size，就需要用到这个API：
     CTFramesetterSuggestFrameSizeWithConstraints，用NSString的sizeWithFont算多行时会算不准的，因为在CoreText里，行间距也是你来控制的。
     设置行间距和换行模式都是设置一个属性：kCTParagraphStyleAttributeName，这个属性里面又分为很多子
     属性，其中就包括
     kCTLineBreakByCharWrapping
     kCTParagraphStyleSpecifierLineSpacingAdjustment
     设置如下：
     */
    
    
    /*
     //-------------取消注释，实现换行-------------
     
     CTParagraphStyleSetting lineBreakMode;
     CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
     lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
     lineBreakMode.value = &lineBreak;
     lineBreakMode.valueSize = sizeof(CTLineBreakMode);
     //行间距
     CTParagraphStyleSetting LineSpacing;
     CGFloat spacing = 4.0;  //指定间距
     LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
     LineSpacing.value = &spacing;
     LineSpacing.valueSize = sizeof(CGFloat);
     
     CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
     CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   //第二个参数为settings的长度
     [attriString addAttribute:(NSString *)kCTParagraphStyleAttributeName
     value:(id)paragraphStyle
     range:NSMakeRange(0, attriString.length)];
     */
    
    return attriString;
}

@end
