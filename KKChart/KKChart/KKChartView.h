//
//  KKChartView.h
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//
#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import <UIKit/UIKit.h>
@class KKChartView;
@protocol KKChartViewDelegate <NSObject>

@optional
//此代理方法的作用是，让其他的线跟着同时移动
-(void)moveLineView:(KKChartView *)chartView;
-(void)beginTouch;
-(void)endTouch;

@end
@interface KKChartView : UIView
@property (nonatomic,assign)       id<KKChartViewDelegate> delegate;
//是否显示网格
@property (nonatomic,assign) BOOL isShowGrid;
//曲线颜色，默认红色
@property (nonatomic,strong) UIColor *curveColor;
//曲线数据源，NSNumber类型
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *lineView;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array;
-(void)setDataArray:(NSMutableArray *)array;

-(void)drawValueLine:(float)position;
@end
