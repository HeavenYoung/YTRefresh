//
//  RefreshAutoStateFooter.h
//  YTRefresh
//
//  Created by Heaven on 16/2/24.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshAutoFooter.h"

@interface RefreshAutoStateFooter : RefreshAutoFooter

/** 显示刷新状态的label */
@property (nonatomic, weak) UILabel *stateLabel;

/** 设置不同状态下的文字 */
- (void)setTitle:(NSString *)title forState:(RefreshState)state;

/** 隐藏刷新状态的文字 */
@property (nonatomic, assign, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;

@end
