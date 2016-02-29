//
//  RefreshGifHeader.m
//  YTRefresh
//
//  Created by Heaven on 16/2/29.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshGifHeader.h"

@interface RefreshGifHeader()

/** gif图片 */
@property (nonatomic, weak) UIImageView *gifImageView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@end

@implementation RefreshGifHeader

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(RefreshState)state {
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.height) {
        self.height = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(RefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(RefreshStateIdle)];
    if (self.state != RefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifImageView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifImageView.image = images[index];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.gifImageView.constraints.count) return;
    
    self.gifImageView.frame = self.bounds;
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifImageView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifImageView.contentMode = UIViewContentModeRight;
        self.gifImageView.width = self.width * 0.5 - 90;
    }
}

- (void)setState:(RefreshState)state {
    RefreshCheckState
    
    // 根据不同状态执行不同操作
    if (state == RefreshStatePulling || state == RefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifImageView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifImageView.image = [images lastObject];
        } else { // 多张图片
            self.gifImageView.animationImages = images;
            self.gifImageView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifImageView startAnimating];
        }
    } else if (state == RefreshStateIdle) {
        [self.gifImageView stopAnimating];
    }
}

#pragma mark - 懒加载
- (UIImageView *)gifImageView {
    if (_gifImageView == nil) {
        UIImageView *gifImageView = [[UIImageView alloc] init];
        [self addSubview:_gifImageView = gifImageView];
    }
    return _gifImageView;
}

- (NSMutableDictionary *)stateImages {
    if (_stateImages == nil) {
        _stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations {
    if (_stateDurations == nil) {
        _stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}


@end
