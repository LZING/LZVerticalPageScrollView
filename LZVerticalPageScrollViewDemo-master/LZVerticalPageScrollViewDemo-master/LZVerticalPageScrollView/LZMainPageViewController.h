//
//  LZMainPageViewController.h
//  LZVerticalPageScrollViewDemo-master
//
//  Created by lzing on 16/4/22.
//  Copyright © 2016年 LZING. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZSecondPageViewController;

@interface LZMainPageViewController : UIViewController

@property(nonatomic, strong) LZSecondPageViewController *secondViewController;
@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic) BOOL isResponseToScroll;
- (void)setScrollViewContentSize:(CGSize)size;

@end
