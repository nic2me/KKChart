//
//  ViewController.m
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//

#import "ViewController.h"
#import "KKChartView.h"
@interface ViewController ()
@property (nonatomic,strong) KKChartView *chartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    float position_x = 10.0;
    float position_y = 100.0;
    float width = self.view.bounds.size.width;
    float height= 100;
    _chartView = [[KKChartView alloc] initWithFrame:CGRectMake(position_x, position_y, width-2*position_x, height) withGrid:YES];
    [self.view addSubview:_chartView];
}


@end
