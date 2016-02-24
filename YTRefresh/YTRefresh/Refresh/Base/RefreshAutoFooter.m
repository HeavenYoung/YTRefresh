//
//  RefreshAutoFooter.m
//  YTRefresh
//
//  Created by Heaven on 16/2/23.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshAutoFooter.h"

@interface RefreshAutoFooter()

@end

@implementation RefreshAutoFooter

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        
        if (self.hidden == NO) {
            self.scrollView.insetBottom += self.height;
        }
        
        // 设置位置
        self.y = _scrollView.contentSizeHeight;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.insetBottom -= self.height;
        }
    }
}

#pragma mark - 过期方法
- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)appearencePercentTriggerAutoRefresh {
    self.triggerAutomaticallyRefreshPercent = appearencePercentTriggerAutoRefresh;
}

- (CGFloat)appearencePercentTriggerAutoRefresh {
    return self.triggerAutomaticallyRefreshPercent;
}

#pragma mark - 父类方法
- (void)prepare {
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = YES;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {

    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.y = self.scrollView.contentSizeHeight;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {

    [super scrollViewContentOffsetDidChange:change];
    
    // 如果处于非闲置状态, 非自动刷新, 本身高度为0 直接return
    if (self.state != RefreshStateIdle || self.automaticallyRefresh != YES || self.height == 0) return;
    
    if (_scrollView.insetTop + _scrollView.contentSizeHeight > _scrollView.height) { // 内容超过一个屏
        if (_scrollView.contentOffsetY >= _scrollView.contentSizeHeight - _scrollView.height + self.height *self.triggerAutomaticallyRefreshPercent + _scrollView.insetBottom - self.height) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != RefreshStateIdle) return;
    
    if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
        if (_scrollView.insetTop + _scrollView.contentSizeHeight <= _scrollView.height) {  // 不够一个屏
            if (_scrollView.contentOffsetY >= - _scrollView.insetTop) { // 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if (_scrollView.contentOffsetY >= _scrollView.contentSizeHeight + _scrollView.insetBottom - _scrollView.height) {
                [self beginRefreshing];
            }
        }
    }
}

- (void)setState:(RefreshState)state {
    
    // 检查状态
    RefreshCheckState
    
    if (state == RefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    }
}

- (void)setHidden:(BOOL)hidden {
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {
        self.state = RefreshStateIdle;
        self.scrollView.insetBottom -= self.height;
    } else if (lastHidden && !hidden) {
        self.scrollView.insetBottom += self.height;
        
        // 设置位置
        self.y = _scrollView.contentSizeHeight;
    }
}

@end
