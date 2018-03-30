//
//  KKChartView.h
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//
#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import <UIKit/UIKit.h>

@interface KKChartView : UIView
//是否显示网格
@property (nonatomic,assign) BOOL isShowGrid;
//曲线颜色，默认红色
@property (nonatomic,strong) UIColor *curveColor;
//曲线数据源，NSNumber类型
@property (nonatomic,strong) NSMutableArray *dataArray;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array;
-(void)setDataArray:(NSMutableArray *)array;
@end
