//
//  RefreshConst.h
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define RefreshLog(...) NSLog(__VA_ARGS__)
#else
#define RefreshLog(...)
#endif

// 过期提醒
#define RefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define RefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define RefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define RefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define RefreshLabelTextColor RefreshColor(90, 90, 90)

// 字体大小
#define RefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 图片路径
#define RefreshSrcName(file) [@"Refresh.bundle" stringByAppendingPathComponent:file]
#define RefreshFrameworkSrcName(file) [@"Frameworks/Refresh.framework/Refresh.bundle" stringByAppendingPathComponent:file]

// 常量
UIKIT_EXTERN const CGFloat RefreshHeaderHeight;
UIKIT_EXTERN const CGFloat RefreshFooterHeight;
UIKIT_EXTERN const CGFloat RefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat RefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const RefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const RefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const RefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const RefreshKeyPathPanState;

UIKIT_EXTERN NSString *const RefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const RefreshHeaderIdleText;
UIKIT_EXTERN NSString *const RefreshHeaderPullingText;
UIKIT_EXTERN NSString *const RefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const RefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const RefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const RefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const RefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const RefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const RefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const RefreshBackFooterNoMoreDataText;

// 状态检查
#define RefreshCheckState \
RefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
