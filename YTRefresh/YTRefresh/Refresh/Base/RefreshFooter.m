//
//  RefreshFooter.m
//  YTRefresh
//
//  Created by Heaven on 16/2/18.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshFooter.h"

@implementation RefreshFooter
#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(RefreshComponentRefreshingBlock)refreshingBlock {
    RefreshFooter *footer = [[self alloc] init];
    footer.refreshingBlock = refreshingBlock;
    return footer;
}

+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    RefreshFooter *footer = [[self alloc] init];
    [footer setRefreshingTarget:target refreshingAction:action];
    return footer;
}

#pragma mark - 重写父类方法
- (void)prepare {
    [super prepare];
    
    // 设置自己的高度
    self.height = RefreshFooterHeight;
    // 默认不会自动隐藏
    self.automaticallyHidden = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setReloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount = 0);
                }
            }];
        }
    }
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData {
    self.state = RefreshStateIdle;
}

- (void)noticeNoMoreData {
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData {
    self.state = RefreshStateIdle;
}

@end
