//
//  LZSecondPageViewController.m
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import "LZSecondPageViewController.h"
#import "LZPullDownRefreshView.h"

@interface LZSecondPageViewController ()<UIScrollViewDelegate>

@end

@implementation LZSecondPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = NO;
    
    // make sure scroll enabled
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 100);
    [self.view addSubview:self.scrollView];
    
    self.scrollView.frame = self.view.bounds;
    self.view.backgroundColor = [UIColor redColor];
    [self addRefreshView];
}

- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        self.pullFreshView = [[LZPullDownRefreshView alloc]initWithFrame:CGRectMake(0, -50.f, self.view.frame.size.width, 50.f)];
        self.pullFreshView.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.scrollView delegate:(id<LZPullDownRefreshViewDelegate>)self.mainViewController];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)setScrollViewContentSize:(CGSize)size {
    NSLog(@"%@",NSStringFromCGSize(size));
    self.scrollView.contentSize = size;
    self.pullFreshView.frame = CGRectMake(0, size.height - 44, self.view.frame.size.width, 44.f);
    self.mainViewController.view.frame = CGRectMake(0, self.scrollView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
}

@end
