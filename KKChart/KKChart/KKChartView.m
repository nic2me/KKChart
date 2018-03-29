//
//  KKChartView.m
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//

#import "KKChartView.h"
@interface KKChartView()

@end
@implementation KKChartView
-(instancetype)initWithFrame:(CGRect)frame withGrid:(BOOL)showBackgroundGrid
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.gridColor = [UIColor redColor];
    self.isShowGrid = showBackgroundGrid;
    [self initialData];
    return self;
}
-(void)initialData
{
    [self reloadData];
}
- (void)reloadData
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self setNeedsDisplay];
    });
    
}
-(void)drawRect:(CGRect)rect
{
    [self drawRectangleLines:rect];
    
}
//画矩形框架
-(void)drawRectangleLines:(CGRect)selfRect
{
    float lineHeight = selfRect.size.height;
    float lineWidth = selfRect.size.width;
    float itemWidth  = 4.0;
    NSInteger verticleLineNumbers = (int)(selfRect.size.width/itemWidth);
    NSInteger horizonLineNumbers  = (int)(selfRect.size.height/itemWidth);
    
    if(_isShowGrid)
    {
        //画垂直的竖线
        for (int i=0; i<verticleLineNumbers; i++) {
            float  linePositon_x= i*itemWidth;
            
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextMoveToPoint(context, linePositon_x, 0);
            CGContextAddLineToPoint(context, linePositon_x, lineHeight);
            CGContextSetStrokeColorWithColor(context, HHColor(239, 239, 239).CGColor);
            CGContextSetLineWidth(context, 0.5);
            CGContextClosePath(context);
            CGContextStrokePath(context);
        }
        //画水平的横线
        for (int i=0; i<horizonLineNumbers; i++) {
            float linePosition_y = i*itemWidth;
            
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextMoveToPoint(context, 0, linePosition_y);
            CGContextAddLineToPoint(context, lineWidth, linePosition_y);
            CGContextSetStrokeColorWithColor(context, HHColor(239, 239, 239).CGColor);
            CGContextSetLineWidth(context, 0.5);
            CGContextClosePath(context);
            CGContextStrokePath(context);
        }
    }
    //第一行和最后一行画两条黑线，和背景区别开
    UIView  *line_first = [[UIView alloc]initWithFrame:CGRectMake(0, 0, lineWidth, .5)];
    line_first.backgroundColor = HHColor(196, 196, 196);
    [self addSubview:line_first];
    UIView  *line_last = [[UIView alloc]initWithFrame:CGRectMake(0, lineHeight, lineWidth, .5)];
    line_last.backgroundColor = HHColor(196, 196, 196);
    [self addSubview:line_last];
}
@end
