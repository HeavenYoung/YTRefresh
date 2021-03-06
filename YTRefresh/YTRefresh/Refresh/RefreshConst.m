//
//  RefreshConst.m
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshConst.h"

const CGFloat RefreshHeaderHeight = 54.0;
const CGFloat RefreshFooterHeight = 44.0;
const CGFloat RefreshFastAnimationDuration = 0.25;
const CGFloat RefreshSlowAnimationDuration = 0.4;

NSString *const RefreshKeyPathContentOffset = @"contentOffset";
NSString *const RefreshKeyPathContentInset = @"contentInset";
NSString *const RefreshKeyPathContentSize = @"contentSize";
NSString *const RefreshKeyPathPanState = @"state";

NSString *const RefreshHeaderLastUpdatedTimeKey = @"RefreshHeaderLastUpdatedTimeKey";

NSString *const RefreshHeaderIdleText = @"下拉可以刷新";
NSString *const RefreshHeaderPullingText = @"松开立即刷新";
NSString *const RefreshHeaderRefreshingText = @"正在刷新数据中...";

NSString *const RefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const RefreshAutoFooterRefreshingText = @"正在加载更多的数据...";
NSString *const RefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";

NSString *const RefreshBackFooterIdleText = @"上拉可以加载更多";
NSString *const RefreshBackFooterPullingText = @"松开立即加载更多";
NSString *const RefreshBackFooterRefreshingText = @"正在加载更多的数据...";
NSString *const RefreshBackFooterNoMoreDataText = @"已经全部加载完毕";
