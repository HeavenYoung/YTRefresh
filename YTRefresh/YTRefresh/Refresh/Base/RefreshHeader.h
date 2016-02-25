//
//  RefreshHeader.h
//  YTRefresh
//
//  Created by Heaven on 16/2/23.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshComponent.h"

@interface RefreshHeader : RefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(RefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 用来存储上一次下拉刷新成功时间的Key */
@property (nonatomic, copy) NSString *lastUpdatedTimeKey;
/** 上次下拉刷新成功的时间 */
@property (nonatomic, strong, readonly) NSDate *lastUpdatedTime;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

@end
