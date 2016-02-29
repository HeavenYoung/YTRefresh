//
//  RefreshHeader.m
//  YTRefresh
//
//  Created by Heaven on 16/2/23.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshHeader()
@property (nonatomic, assign) CGFloat insetTDelta;
@end

@implementation RefreshHeader
#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(RefreshComponentRefreshingBlock)refreshingBlock {
    RefreshHeader *header = [[self alloc] init];
    header.refreshingBlock = refreshingBlock;
    return header;
}

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    RefreshHeader *header = [[self alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

#pragma mark - 父类方法
- (void)prepare {
    [super prepare];
    
    // 设置key
    self.lastUpdatedTimeKey = RefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.height = RefreshHeaderHeight;
}

- (void)placeSubviews {
    [super placeSubviews];
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.y = - self.height - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新
    if (self.state == RefreshStateRefreshing) {
        
        if (self.window == nil) return;
        CGFloat insetTop = - self.scrollView.contentOffsetY > _scrollViewOriginalInset.top ? - self.scrollView.contentOffsetY : _scrollViewOriginalInset.top;
        
        insetTop = insetTop > self.height + _scrollViewOriginalInset.top ? self.height + _scrollViewOriginalInset.top : insetTop;
        self.scrollView.insetTop = insetTop;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetTop;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.contentOffsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.height;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.height;

    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == RefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = RefreshStatePulling;
        } else if (self.state == RefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = RefreshStateIdle;
        }
    } else if (self.state == RefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(RefreshState)state {
    // 检查状态
    RefreshCheckState;
    
    // 根据状态执行不同的操作
    if (state == RefreshStateIdle) {
        if (oldState != RefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:RefreshSlowAnimationDuration animations:^{
            self.scrollView.insetTop += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
        }];
    } else if (state == RefreshStateRefreshing) {
        [UIView animateWithDuration:RefreshFastAnimationDuration animations:^{
            // 增加滚动区域
            CGFloat top = self.scrollViewOriginalInset.top + self.height;
            self.scrollView.insetTop = top;
            
            // 设置滚动位置
            self.scrollView.contentOffsetY = - top;
        } completion:^(BOOL finished) {
            // 执行刷新回调
            [self executeRefreshingCallback];
        }];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

#pragma mark - 公共方法
- (void)endRefreshing {
    if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
    } else {
        [super endRefreshing];
    }
}

- (NSDate *)lastUpdatedTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

@end
