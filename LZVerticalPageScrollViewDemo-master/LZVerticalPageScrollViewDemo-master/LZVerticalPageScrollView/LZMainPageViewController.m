//
//  LZMainPageViewController.m
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import "LZMainPageViewController.h"
#import "LZPullDownRefreshView.h"
#import "LZPullUpRefreshView.h"
#import "LZSecondPageViewController.h"

@interface LZMainPageViewController ()<LZPullUpRefreshViewDelegate, LZPullUpRefreshViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong)LZPullUpRefreshView *pullUpRefreshView;
@property(nonatomic) float contentInsetTop;

@end

@implementation LZMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifdef __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.isResponseToScroll = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_scrollView==nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.delegate = self;
        
        [self.view addSubview:self.scrollView];
    }
    // make sure scroll enabled
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self addRefreshView];
    [self addSubPage];
    
    self.contentInsetTop = self.scrollView.contentInset.top;
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
#ifdef __IPHONE_7_0
    //iOS7必须执行
    [self.view layoutSubviews];
#endif
    
}

- (void)addRefreshView {
    if (self.pullUpRefreshView == nil) {
        float originY = self.scrollView.contentSize.height - 50;
        self.pullUpRefreshView = [[LZPullUpRefreshView alloc]initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, 50.f)];
        self.pullUpRefreshView.backgroundColor = [UIColor yellowColor];
    }
    
    if (!self.pullUpRefreshView.superview) {
        [self.pullUpRefreshView setupWithOwner:self.scrollView delegate:self];
    }
}

- (void)setScrollViewContentSize:(CGSize)size {
    self.scrollView.contentSize = size;
    self.pullUpRefreshView.frame = CGRectMake(0, size.height - 44, self.view.frame.size.width, 44.f);
    self.secondViewController.view.frame = CGRectMake(0, self.scrollView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)addSubPage {
    if (!self.secondViewController) {
        return;
    }
    NSLog(@"%f",self.scrollView.contentSize.height);
    self.secondViewController.view.frame = CGRectMake(0, self.scrollView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView addSubview:self.secondViewController.view];
}

- (void)pullUpRefreshDidFinish {
    [self.pullUpRefreshView stopLoading];
    NSLog(@"%f",self.scrollView.contentSize.height);
    // 上拉分页动画
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(-self.scrollView.contentSize.height, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height );
        self.isResponseToScroll = NO;
        self.scrollView.scrollEnabled = NO;
        self.secondViewController.scrollView.scrollEnabled = YES;
        
        self.pullUpRefreshView.hidden = YES;
    }];
}

- (void)pullDownRefreshDidFinish {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(_contentInsetTop, 0, 0, 0);
        // maintable重绘之后，contentsize要重新加上offset
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height );
    } completion:^(BOOL finished) {
        [self.secondViewController.pullFreshView stopLoading];
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
        self.scrollView.scrollEnabled = YES;
        self.secondViewController.scrollView.scrollEnabled = NO;
        self.isResponseToScroll = YES;
        self.pullUpRefreshView.hidden = NO;
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullUpRefreshView scrollViewWillBeginDragging:scrollView];
    } else {
        [self.secondViewController.pullFreshView scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullUpRefreshView scrollViewDidScroll:scrollView];
    } else {
        [self.secondViewController.pullFreshView scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isResponseToScroll) {
        [self.pullUpRefreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    } else {
        [self.secondViewController.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullUpRefreshView scrollViewDidEndDecelerating:scrollView];
    } else {
    }
}


@end
