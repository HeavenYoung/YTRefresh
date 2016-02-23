//
//  UIScrollView+YTExtension.h
//  YTRefresh
//
//  Created by Heaven on 16/2/17.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YTExtension)

@property (nonatomic, assign) CGFloat insetTop;
@property (nonatomic, assign) CGFloat insetLeft;
@property (nonatomic, assign) CGFloat insetBottom;
@property (nonatomic, assign) CGFloat insetRight;

@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) CGFloat contentOffsetY;

@property (nonatomic, assign) CGFloat contentSizeWidth;
@property (nonatomic, assign) CGFloat contentSizeHeight;

@end
