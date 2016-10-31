//
//  ViewController.m
//  ScrollCycle
//
//  Created by 李景景 on 16/10/27.
//  Copyright © 2016年 Linkstores. All rights reserved.
//

#import "ViewController.h"
#import "LSScrollCycleView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface ViewController ()<LSScrollCycleViewDelegate>

@property (nonatomic, strong) LSScrollCycleView                 *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

}

- (void)setupUI
{
    self.scrollView = [[LSScrollCycleView alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100 , 400)];
    self.scrollView.imgArr = @[@"0.jpg", @"1.jpg", @"2.jpg"];
    self.scrollView.dotsColor = [UIColor blueColor];
    self.scrollView.currentDotColor = [UIColor purpleColor];
    self.scrollView.delegate = self;
    
    //轮播间隔
//    self.scrollView.timeInterval = 1;
    
    
    [self.view addSubview:self.scrollView];
    
}

#pragma mark - LSScrollCycleViewDelegate
- (void)scrollCycleView:(LSScrollCycleView *)cycleView clickedWithIndex:(NSInteger)index
{
    NSLog(@"%zd", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
