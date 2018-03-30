//
//  KKChartView.m
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//

#import "KKChartView.h"
@interface KKChartView()
{
    float maxVerticalValue;
    float minVerticalValue;
    
    //垂直和水平的单位距离
    float   horizontalItemWidth;
    float   verticalItemHeight;
}

@end
@implementation KKChartView
-(instancetype)initWithFrame:(CGRect)frame
{
    return  [self initWithFrame:frame withArray:nil];
}
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    _curveColor = [UIColor redColor];
    _isShowGrid = YES;
    _dataArray = array;
    return self;
}
#pragma 数据源
-(void)setDataArray:(NSMutableArray *)array
{
    _dataArray = array;
    [self reloadData];
}
-(void)setIsShowGrid:(BOOL)isShowGrid
{
    _isShowGrid = isShowGrid;
    [self reloadData];
}
-(void)setCurveColor:(UIColor *)curveColor
{
    _curveColor = curveColor;
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
    [self drawCurve:rect];
}
-(void)drawCurve:(CGRect)rect
{
    if (!_dataArray || !_dataArray.count) {
        return;
    }
    NSMutableArray *tmpValueItemsArray = [_dataArray copy];
    /*获取序列中的最值
     */
    maxVerticalValue = -MAXFLOAT;
    minVerticalValue = MAXFLOAT;
    for (int i=0; i<tmpValueItemsArray.count; i++) {
        NSNumber *num = tmpValueItemsArray[i];
        float x = num.floatValue;
        if (x < minVerticalValue)
        {
            minVerticalValue = x;
        }
        if (x > maxVerticalValue){
            maxVerticalValue = x;
        }
    }
    //水平单位长度
    horizontalItemWidth = rect.size.width/ (_dataArray.count - 1);
    //垂直单位高度
    if (maxVerticalValue==0)
    {
        verticalItemHeight=.0f;
    }else
    {
        verticalItemHeight = rect.size.height/(maxVerticalValue-minVerticalValue);
    }
    /*开始画曲线
     */
    for (int j=0; j<tmpValueItemsArray.count-1; j++)
    {
        float   value = [tmpValueItemsArray[j] floatValue];
        CGPoint point = [self valuePoint:value atIndex:j];//返回某个点的坐标
        float   nextValue = [tmpValueItemsArray[j + 1] floatValue];
        CGPoint nextPoint = [self valuePoint:nextValue atIndex:j + 1];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
        CGContextSetStrokeColorWithColor(context, _curveColor.CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGContextClosePath(context);
        CGContextStrokePath(context);
    }
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
#pragma mark    本类内部使用的方法
- (CGPoint)valuePoint:(float)value atIndex:(int)index
{
    CGPoint retPoint = CGPointZero;
    
    retPoint.x = index * horizontalItemWidth;
    retPoint.y = self.frame.size.height-(value-minVerticalValue)* verticalItemHeight;
    return retPoint;
}
@end
