//
//  RefreshStateNormalHeader.h
//  YTRefresh
//
//  Created by Heaven on 16/2/25.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "RefreshStateHeader.h"

@interface RefreshStateNormalHeader : RefreshStateHeader
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/** 箭头 */
@property (nonatomic, weak) UIImageView *arrowView;

@end
