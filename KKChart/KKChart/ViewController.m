//
//  ViewController.m
//  KKChart
//
//  Created by 茹赟 on 2018/3/30.
//  Copyright © 2018年 茹赟. All rights reserved.
//
#define screen_width self.view.bounds.size.width
#import "ViewController.h"
#import "KKChartView.h"
@interface ViewController ()
@property (nonatomic,strong) KKChartView *chartView;
@property (nonatomic,strong) UIButton   *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(screen_width/2-50, 100, 100, 40)];
    [_button setTitle:@"随机画曲线" forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor blueColor]];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(startFun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    float position_x = 10.0;
    float position_y = _button.frame.origin.y+200;
    float height= 100;
    //以下两种初始化方式都可以
//    _chartView = [[KKChartView alloc] initWithFrame:CGRectMake(position_x, position_y, screen_width-2*position_x, height)];
    _chartView = [[KKChartView alloc] initWithFrame:CGRectMake(position_x, position_y, screen_width-2*position_x, height) withArray:[self randomArray]];
    [self.view addSubview:_chartView];
}
-(NSMutableArray *)randomArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<40; i++) {
        int x = arc4random() % 100;
        float randomValue = x/1.0;
        [array addObject:[NSNumber numberWithFloat:randomValue]];
    }
    return array;
}
-(void)startFun
{
    [_chartView setDataArray:[self randomArray]];
    //_chartView.curveColor = [UIColor blueColor];
    //_chartView.isShowGrid = NO;
}
@end
