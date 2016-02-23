//
//  RefreshFooter.h
//  YTRefresh
//
//  Created by Heaven on 16/2/18.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshComponent.h"

@interface RefreshFooter : RefreshComponent
/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(RefreshComponentRefreshingBlock)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;
- (void)noticeNoMoreData RefreshDeprecated("使用endRefreshingWithNoMoreData");

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property (nonatomic, assign) CGFloat ignoredScrollViewContentInsetBottom;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO） */
@property (nonatomic, assign, getter=isAutomaticallyHidden) BOOL automaticallyHidden;

@end
