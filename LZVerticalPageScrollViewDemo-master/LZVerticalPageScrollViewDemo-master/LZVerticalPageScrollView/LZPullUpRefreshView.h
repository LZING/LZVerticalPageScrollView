//
//  LZPullUpRefreshView.h
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZPullUpRefreshViewDelegate <NSObject>

- (void)pullUpRefreshDidFinish;

@end

@interface LZPullUpRefreshView : UIView

@property (nonatomic, weak) id<LZPullUpRefreshViewDelegate> delegate;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<LZPullUpRefreshViewDelegate>)delegate;
- (void)updateOffsetY:(CGFloat)y;

- (void)startLoading;
- (void)stopLoading;

// 拖动过程中
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

