//
//  RefreshAutoFooter.h
//  YTRefresh
//
//  Created by Heaven on 16/2/23.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshFooter.h"

@interface RefreshAutoFooter : RefreshFooter

/** 是否自动刷新 */
@property (nonatomic, assign, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (nonatomic, assign) CGFloat appearencePercentTriggerAutoRefresh RefreshDeprecated("请使用automaticallyChangeAlpha属性");

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (nonatomic, assign) CGFloat triggerAutomaticallyRefreshPercent;

@end
