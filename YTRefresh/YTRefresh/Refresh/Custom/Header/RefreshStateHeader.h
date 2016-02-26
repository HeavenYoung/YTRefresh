//
//  RefreshStateHeader.h
//  YTRefresh
//
//  Created by Heaven on 16/2/25.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshStateHeader : RefreshHeader
#pragma mark - 刷新时间相关
/** 控制更新时间的文字 */
@property (nonatomic, copy) NSString *(^lastUpdatedTimeText)(NSDate *lasUpdatedTime);
/** 显示上次刷新时间的label */
@property (nonatomic, weak) UILabel *lastUpdatedTimeLabel;

#pragma mark - 状态相关
/** 显示刷新状态的label */
@property (nonatomic, weak) UILabel *stateLabel;
/** 设置不同状态下的文字 */
- (void)setTitle:(NSString *)title forState:(RefreshState)state;

@end
