//
//  UIScrollView+Refresh.m
//  YTRefresh
//
//  Created by Heaven on 16/2/18.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <objc/runtime.h>
#import "RefreshHeader.h"
#import "RefreshFooter.h"

@implementation NSObject (Refresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (Refresh)
#pragma mark - header
static const char RefreshHeaderKey = '\0';
- (void)setHeader:(RefreshHeader *)header {
    if (header != self.header) {
        // 删除旧的，添加新的
        [self.header removeFromSuperview];
        [self insertSubview:header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"yt_header"]; // KVO
        objc_setAssociatedObject(self, &RefreshHeaderKey,
                                 header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"yt_header"]; // KVO
    }
}

- (RefreshHeader *)header {
    return objc_getAssociatedObject(self, &RefreshHeaderKey);
}

#pragma mark - footer
static const char RefreshFooterKey = '\0';
- (void)setFooter:(RefreshFooter *)footer {

    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self addSubview:footer];
        
        // 存储新的
        [self willChangeValueForKey:@"yt_footer"];
        objc_setAssociatedObject(self, &RefreshFooterKey, footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"yt_footer"];
    }
}

- (RefreshFooter *)footer {
    return objc_getAssociatedObject(self, &RefreshFooterKey);
}

#pragma mark - other
- (NSInteger)yt_totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char RefreshReloadDataBlockKey = '\0';
- (void)setReloadDataBlock:(void (^)(NSInteger))reloadDataBlock {
    [self willChangeValueForKey:@"mj_reloadDataBlock"];
    objc_setAssociatedObject(self, &RefreshReloadDataBlockKey, reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))reloadDataBlock {
    return objc_getAssociatedObject(self, &RefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock {
    !self.reloadDataBlock ? : self.reloadDataBlock(self.yt_totalDataCount);
}

@end

@implementation UITableView (MJRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(yt_reloadData)];
}

- (void)yt_reloadData {
    [self yt_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MJRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(yt_reloadData)];
}

- (void)yt_reloadData {
    [self yt_reloadData];
    
    [self executeReloadDataBlock];
}
@end

