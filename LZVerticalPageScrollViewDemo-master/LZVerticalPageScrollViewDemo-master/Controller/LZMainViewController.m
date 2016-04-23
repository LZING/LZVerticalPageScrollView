//
//  mainViewController.m
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import "LZMainViewController.h"
#import "LZSecondPageViewController.h"
@interface LZMainViewController ()

@end

@implementation LZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"第一页";
    self.secondViewController = [[LZSecondPageViewController alloc] init];
    self.secondViewController.mainViewController = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 注意：contentsize.height必须要大于bounds.size.height，否则不能滚动，也就无法回到父view
    [self setScrollViewContentSize:CGSizeMake(320, 800)];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 750)];
//    view.backgroundColor = [UIColor blueColor];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((300-80)/2.f, (400-30)/2.f, 80, 30)];
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"第一页";

//    [view addSubview:label];
//    [self.scrollView addSubview:view];
    
}

@end
