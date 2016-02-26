//
//  RefreshStateNormalHeader.m
//  YTRefresh
//
//  Created by Heaven on 16/2/25.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshStateNormalHeader.h"

@interface RefreshStateNormalHeader()
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation RefreshStateNormalHeader
#pragma mark - 懒加载
- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        activityIndicatorView.hidesWhenStopped = YES;
        [self addSubview:_activityIndicatorView = activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
//        UIImage *image = [UIImage imageNamed:RefreshSrcName(@"arrow.png")] ?: [UIImage imageNamed:RefreshFrameworkSrcName(@"arrow.png")];
        UIImage *image = [UIImage imageNamed:@"arrow"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.activityIndicatorView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法
- (void)prepare {
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.width * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.height * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 菊花
    if (self.activityIndicatorView.constraints.count == 0) {
        self.activityIndicatorView.center = arrowCenter;
    }
}

- (void)setState:(RefreshState)state {

    RefreshCheckState;

    // 根据不同的状态执行不同操作
    if (state == RefreshStateIdle) {
        if (oldState == RefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:RefreshSlowAnimationDuration animations:^{
                self.activityIndicatorView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是默认状态，就直接返回，进入其他状态
                if (self.state != RefreshStateIdle) return;
                
                self.activityIndicatorView.alpha = 1.0;
                [self.activityIndicatorView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.activityIndicatorView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:RefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == RefreshStatePulling) {
        [self.activityIndicatorView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:RefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == RefreshStateRefreshing) {
        self.activityIndicatorView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.activityIndicatorView startAnimating];
        self.arrowView.hidden = YES;
    }
}

@end
