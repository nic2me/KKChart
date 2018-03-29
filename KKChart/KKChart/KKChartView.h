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
@property (nonatomic,assign) BOOL isShowGrid;
@property (nonatomic,strong) UIColor *gridColor;
-(instancetype)initWithFrame:(CGRect)frame withGrid:(BOOL)showBackgroundGrid;
@end
