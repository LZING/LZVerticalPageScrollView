//
//  secondViewController.m
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import "LZSecondViewController.h"

@interface LZSecondViewController ()

@end

@implementation LZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self setScrollViewContentSize:CGSizeMake(320, 10000)];
    self.scrollView.contentSize = CGSizeMake(320, 10000);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
    view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((300-80)/2.f, (200-30)/2.f, 80, 30)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"第二页";
    self.navigationItem.title = @"第二页";
    [view addSubview:label];
    [self.scrollView addSubview:view];
    
    self.view.backgroundColor=[UIColor whiteColor];
}

@end
