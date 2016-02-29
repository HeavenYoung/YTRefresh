//
//  RefreshGifHeader.h
//  YTRefresh
//
//  Created by Heaven on 16/2/29.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshStateHeader.h"

@interface RefreshGifHeader : RefreshStateHeader

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(RefreshState)state;
- (void)setImages:(NSArray *)images forState:(RefreshState)state;

@end
