//
//  UIScrollView+Refresh.h
//  YTRefresh
//
//  Created by Heaven on 16/2/18.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshConst.h"

@class RefreshFooter;

@interface UIScrollView (Refresh)

/** 上拉刷新控件 */
@property (nonatomic, strong) RefreshFooter *footer;

#pragma mark - other
- (NSInteger)yt_totalDataCount;

@property (nonatomic, copy) void (^reloadDataBlock)(NSInteger totalDataCount);

@end
