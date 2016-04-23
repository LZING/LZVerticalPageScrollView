//
//  LZPullDownRefreshView.h
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZPullDownRefreshViewDelegate <NSObject>

- (void)pullDownRefreshDidFinish;

@end

@interface LZPullDownRefreshView : UIView

@property (nonatomic, weak) id<LZPullDownRefreshViewDelegate> delegate;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<LZPullDownRefreshViewDelegate>)delegate;

- (void)startLoading;
- (void)stopLoading;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
