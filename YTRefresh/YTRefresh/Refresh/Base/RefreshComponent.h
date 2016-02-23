//
//  RefreshComponent.h
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//  刷新控件的基类

#import <UIKit/UIKit.h>
#import "UIView+YTExtension.h"
#import "UIScrollView+YTExtension.h"
#import "UIScrollView+Refresh.h"
#import "RefreshConst.h"

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, RefreshState){
    /** 普通闲置状态 */
    RefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    RefreshStatePulling,
    /** 正在刷新中的状态 */
    RefreshStateRefreshing,
    /** 即将刷新的状态 */
    RefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    RefreshStateNoMoreData
};

/** 进入刷新状态的回调 */
typedef void (^RefreshComponentRefreshingBlock)();

@interface RefreshComponent : UIView
{
    /** 记录scrollView刚开始的inset */
    UIEdgeInsets _scrollViewOriginalInset;
    /** 父控件 */
    __weak UIScrollView *_scrollView;
}

#pragma mark - 刷新回调
/** 正在刷新的回调 */
@property (nonatomic, copy) RefreshComponentRefreshingBlock refreshingBlock;
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
/** 回调对象 */
@property (nonatomic, weak) id refreshingTarget;
/** 回调方法 */
@property (nonatomic, assign) SEL refreshingAction;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

#pragma mark - 刷新状态控制
/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;
/** 刷新状态 一般交给子类内部实现 */
@property (nonatomic, assign) RefreshState state;

#pragma mark - 交给子类们去实现
/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

#pragma mark - 交给子类去访问
/** 记录scrollView刚开始的inset */
@property (nonatomic, readonly, assign) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (nonatomic, readonly, weak) UIScrollView *scrollView;

#pragma mark - 其他
/** 拉拽的百分比(交给子类重写) */
@property (nonatomic, assign) CGFloat pullingPercent;
/** 根据拖拽比例自动切换透明度 */
@property (nonatomic, assign, getter=isAutoChangeAlpha) BOOL autoChangeAlpha RefreshDeprecated("使用automaticallyChangeAlpha属性");
/** 根据拖拽比例自动切换透明度 */
@property (nonatomic, assign, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;

@end

@interface UILabel(Refresh)
+ (instancetype)label;
@end
