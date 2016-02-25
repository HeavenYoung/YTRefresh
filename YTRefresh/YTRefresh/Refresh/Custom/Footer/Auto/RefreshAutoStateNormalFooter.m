//
//  RefreshAutoStateNormalFooter.m
//  YTRefresh
//
//  Created by Heaven on 16/2/24.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshAutoStateNormalFooter.h"

@interface RefreshAutoStateNormalFooter()
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation RefreshAutoStateNormalFooter

#pragma mark - 懒加载
- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
         UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        activityIndicatorView.hidesWhenStopped = YES;
        [self addSubview:_activityIndicatorView = activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {

    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.activityIndicatorView = nil;
    [self setNeedsLayout];
}

#pragma makr - 重写父类的方法
- (void)prepare {
    [super prepare];
    
    // 默认为灰色风格
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.activityIndicatorView.constraints.count) return;
    
    // 菊花的位置
    CGFloat activityCenterX = self.width * 0.5;
    if (!self.isRefreshingTitleHidden) {
        activityCenterX -= 100;
    }
    
    CGFloat activityCenterY = self.height *0.5;
    self.activityIndicatorView.center = CGPointMake(activityCenterX, activityCenterY);
}

- (void)setState:(RefreshState)state {

    RefreshCheckState;

    if (state == RefreshStateIdle || state == RefreshStateNoMoreData) {
        [self.activityIndicatorView stopAnimating];
    } else if (state == RefreshStateRefreshing) {
        [self.activityIndicatorView startAnimating];
    }
}

@end
