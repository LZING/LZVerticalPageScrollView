//
//  LZSecondPageViewController.h
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZPullDownRefreshView;

@interface LZSecondPageViewController : UIViewController

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, weak) UIViewController *mainViewController;
@property(nonatomic, strong) LZPullDownRefreshView *pullFreshView;

- (void)setScrollViewContentSize:(CGSize)size;

@end
