//
//  RefreshStateHeader.m
//  YTRefresh
//
//  Created by Heaven on 16/2/25.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshStateHeader.h"

@interface RefreshStateHeader()
/** 所有状态对应的文字 */
@property (nonatomic, strong) NSMutableDictionary *stateTitles;

@end

@implementation RefreshStateHeader

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(RefreshState)state {
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 取日历
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey {
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果lastUpdateTimeLabel隐藏，直接返回
    if (self.lastUpdatedTimeLabel.hidden == YES) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *component1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *component2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([component1 day] == [component2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([component1 year] == [component2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
    } else {
        self.lastUpdatedTimeLabel.text = @"最后更新：无记录";
    }
}

#pragma mark - 重写父类方法
- (void)prepare {
    [super prepare];
    
    // 初始化文字
    [self setTitle:RefreshHeaderIdleText forState:RefreshStateIdle];
    [self setTitle:RefreshHeaderPullingText forState:RefreshStatePulling];
    [self setTitle:RefreshHeaderRefreshingText forState:RefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    } else {
        CGFloat stateLabelH = self.height * 0.5;
        // 状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.x = 0;
            self.stateLabel.y = 0;
            self.stateLabel.width = self.width;
            self.stateLabel.height = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.x = 0;
            self.lastUpdatedTimeLabel.y = stateLabelH;
            self.lastUpdatedTimeLabel.width = self.width;
            self.lastUpdatedTimeLabel.height = self.height - self.lastUpdatedTimeLabel.y;
        }
    }
}

- (void)setState:(RefreshState)state {
    
    RefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}

#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel {

    if (_lastUpdatedTimeLabel == nil) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel label]];
    }
    return _lastUpdatedTimeLabel;
}

@end
