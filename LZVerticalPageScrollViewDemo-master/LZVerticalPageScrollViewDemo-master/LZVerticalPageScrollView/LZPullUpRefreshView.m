//
//  LZPullUpRefreshView.m
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import "LZPullUpRefreshView.h"
#define REFRESH_PULL_UP_STATUS @"----------上拉查看本期奖品详情----------"
#define REFRESHER_HEIGHT 44.0f

@interface LZPullUpRefreshView ()

@property (nonatomic, assign) BOOL isDragging;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, weak) UIScrollView *owner;
@property (nonatomic, strong) UILabel *refreshLabel;

@end

@implementation LZPullUpRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, REFRESHER_HEIGHT)];
        self.refreshLabel.backgroundColor = [UIColor clearColor];
        self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        self.refreshLabel.text = REFRESH_PULL_UP_STATUS;
        
        [self addSubview:self.refreshLabel];
    }
    return self;
}

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<LZPullUpRefreshViewDelegate>)delegate {
    self.owner = owner;
    self.delegate = delegate;
    
    [_owner addSubview:self];
}

- (void)updateOffsetY:(CGFloat)y {
    CGRect originFrame = self.frame;
    self.frame = CGRectMake(originFrame.origin.x, y, originFrame.size.width, originFrame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_isLoading && scrollView.contentOffset.y < 0) {
        return;
    } else if (_isDragging && [self contentOffsetBottom:scrollView] <= 0 ) {
        
        //        // Update the arrow direction and label
        //        [UIView beginAnimations:nil context:NULL];
        //
        //        if ([self contentOffsetBottom:scrollView] <= -REFRESHER_HEIGHT) {
        //
        //            // User is scrolling above the footer
        //        }
        //        else {
        //            // User is scrolling somewhere within the footer
        //        }
        //        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isLoading) {
        return;
    }
    // 上拉进入下一页
    if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -REFRESHER_HEIGHT) {
        [self startLoading];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_isLoading) {
        return;
    }
    
    // 上拉进入下一页
    if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -REFRESHER_HEIGHT) {
        [self startLoading];
    }
}
- (void)startLoading {
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    // Refresh action!
    if ([self.delegate respondsToSelector:@selector(pullUpRefreshDidFinish)]) {
        [self.delegate performSelector:@selector(pullUpRefreshDidFinish) withObject:nil];
    }
}

- (void)stopLoading {
    _isLoading = NO;
    
    // Hide the footer
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDuration:0.1];
    //    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    //    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // Reset the footer
    NSLog(@"%f",self.owner.contentSize.height);
    [self setFrame:CGRectMake(0, self.owner.contentSize.height-REFRESHER_HEIGHT, self.frame.size.width, 0)];
}

- (float)contentOffsetBottom:(UIScrollView *)scrollView {
    return scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom);
}


@end
