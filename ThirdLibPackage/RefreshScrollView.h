//
//  RefreshScrollView.h
//  test
//
//  Created by mgfjx on 2017/11/3.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RefreshScrollView;

@protocol RefreshDelegate <NSObject>

@optional
    - (void)headerRefreshing:(RefreshScrollView *)scrollView ;
    - (void)footerRefreshing:(RefreshScrollView *)scrollView ;

@end

@interface RefreshScrollView : UIScrollView

@property (nonatomic, assign) BOOL canPullDown ;
@property (nonatomic, assign) BOOL canPullUp ;
@property (nonatomic, weak) id<RefreshDelegate> mj_delegate ;

- (void)startHeaderRefreshing ;
- (void)startFooterRefreshing ;
- (void)stopHeaderRefreshing ;
- (void)stopFooterRefreshing ;

@end
