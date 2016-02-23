//
//  UIScrollView+YTExtension.m
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "UIScrollView+YTExtension.h"

@implementation UIScrollView (YTExtension)

- (void)setInsetTop:(CGFloat)insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = insetTop;
    self.contentInset = inset;
}

- (CGFloat)insetTop {
    return self.contentInset.top;
}

- (void)setInsetLeft:(CGFloat)insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = insetLeft;
    self.contentInset = inset;
}

- (CGFloat)insetLeft {
    return self.contentInset.left;
}

- (void)setInsetBottom:(CGFloat)insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = insetBottom;
    self.contentInset = inset;
}

- (CGFloat)insetBottom {
    return self.contentInset.bottom;
}

- (void)setInsetRight:(CGFloat)insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = insetRight;
    self.contentInset = inset;
}

- (CGFloat)insetRight {
    return self.contentInset.right;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth {
    CGSize size = self.contentSize;
    size.width = contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)contentSizeWidth {
    return self.contentSize.width;
}

- (void)setContentSizeHeight:(CGFloat)contentSizeHeight {
    CGSize size = self.contentSize;
    size.height = contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)contentSizeHeight {
    return self.contentSize.height;
}

@end
