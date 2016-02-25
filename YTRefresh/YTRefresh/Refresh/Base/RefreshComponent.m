//
//  RefreshComponent.m
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshComponent.h"

@interface RefreshComponent()
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation RefreshComponent
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 准备工作
        [self prepare];
        // 初始化状态(普通闲置状态)
        self.state = RefreshStateIdle;
    }
    return self;
}

- (void)prepare {

    // 基本属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self placeSubviews];
}

- (void)placeSubviews {};

- (void)willMoveToSuperview:(UIView *)newSuperview {

    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView, return
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 旧的父控件移除监听
    [self removeObservers];
    
    if (newSuperview) { // 新的父控件
        // 设置宽度
        self.width = newSuperview.width;
        // 设置位置
        self.x = 0;
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        // 添加监听
        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.state == RefreshStateWillRefresh) {
        self.state = RefreshStateRefreshing;
    }
}

#pragma mark - KVO
- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:RefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:RefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:RefreshKeyPathPanState options:options context:nil];
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentSize];;
    [self.pan removeObserver:self forKeyPath:RefreshKeyPathPanState];
    self.pan = nil;
}

// KVO隐式代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    // 遇到这些情况就直接返回
    // 交互不可用
    if (!self.userInteractionEnabled) return;
    // 隐藏
    if (self.hidden) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:RefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    if ([keyPath isEqualToString:RefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:RefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

#pragma mark - 公共方法
#pragma mark 设置回调对象和回调方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

#pragma mark - 进入刷新状态
- (void)beginRefreshing {

    [UIView animateWithDuration:RefreshFastAnimationDuration animations:^{
        self.alpha = 1.0f;
    }];
    self.pullingPercent = 1.0f;
    // 只要正在刷新，就完全显示
    if (self.window) {
        self.state = RefreshStateRefreshing;
    } else {
        // 防止当前正在刷新中时调用本方法使得header insert回置失败
        if (self.state != RefreshStateRefreshing) {
            self.state = RefreshStateWillRefresh;
            // 刷新(防止从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
        }
    }
}

#pragma mark - 结束刷新状态 
- (void)endRefreshing {
    // 把刷新状态置为闲置状态
    self.state = RefreshStateIdle;
}

#pragma mark - 是否在刷新
- (BOOL)isRefreshing {
    return self.state == RefreshStateRefreshing || self.state == RefreshStateWillRefresh;
}

#pragma mark 自动切换透明度
- (void)setAutoChangeAlpha:(BOOL)autoChangeAlpha {
    self.automaticallyChangeAlpha = autoChangeAlpha;
}

- (BOOL)isAutoChangeAlpha {
    return self.isAutomaticallyChangeAlpha;
}

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha {
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if (self.isRefreshing) return;
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    } else {
        self.alpha = 1.0;
    }
}

#pragma mark 根据拖拽进度设置透明度
- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) return;
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

#pragma mark - 内部方法
- (void)executeRefreshingCallback {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            RefreshMsgSend(RefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
    });
}

@end

@implementation UILabel(MJRefresh)
+ (instancetype)label {
    UILabel *label = [[self alloc] init];
    label.font = RefreshLabelFont;
    label.textColor = RefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

@end