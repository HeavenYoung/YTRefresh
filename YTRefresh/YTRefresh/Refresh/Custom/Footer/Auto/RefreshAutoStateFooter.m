//
//  RefreshAutoStateFooter.m
//  YTRefresh
//
//  Created by Heaven on 16/2/24.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshAutoStateFooter.h"

@interface RefreshAutoStateFooter()

/** 不同状态对应的文字 */
@property (nonatomic, strong) NSMutableDictionary *stateTitles;

@end

@implementation RefreshAutoStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(RefreshState)state {
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 私有方法
- (void)stateLabelClick {
    if (self.state == RefreshStateIdle) {
        [self beginRefreshing];
    }
}

#pragma mark - 重写父类方法
- (void)prepare {
    [super prepare];
    
    // 初始化文字
    [self setTitle:RefreshAutoFooterIdleText forState:RefreshStateIdle];
    [self setTitle:RefreshAutoFooterRefreshingText forState:RefreshStateRefreshing];
    [self setTitle:RefreshAutoFooterNoMoreDataText forState:RefreshStateNoMoreData];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
}

- (void)placeSubviews {

    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(RefreshState)state {
    
    RefreshCheckState
    
    if (self.isRefreshingTitleHidden && state == RefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitles[@(state)];
    }    
}

@end
