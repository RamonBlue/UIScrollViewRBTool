//
//  UIScrollView+RBLayout.h
//  Culture
//
//  Created by Lan on 2018/1/15.
//  Copyright © 2018年 SummerTea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView(RBAdd)

/**
 最先调用,设置宽度,同时移除用以下代码添加的所有子视图
 */
- (void)rbSetContentWidth: (CGFloat)width;

/**
 ---竖排工具---
 布局规则同autolayout, CGFLOAT_MIN代表不设置
 
 height:    CGFLOAT_MIN为不设置高度,根据内容扩展
 width:    CGFLOAT_MIN为不设置宽度,根据内容扩展
 top:    距离上一个view底部的距离
 bottom:    如果此view是scrollView添加的最后一个view,代表与scrollView底部的间距
 left:    CGFLOAT_MIN为不设置左侧距离
 right:    CGFLOAT_MIN为不设置右侧距离
 centerX:    YES为水平居中
 
 优先级centerX > left > right
 */
- (void)addView: (UIView *)view
     withHeight: (CGFloat)height
          width: (CGFloat)width
            top: (CGFloat)top
         bottom: (CGFloat)bottom
           left: (CGFloat)left
          right: (CGFloat)right
        centerX: (BOOL)centerX;

#pragma mark - 扩展方法

/**
 beforeView和afterView赋值一个即可
 都不赋值,作用同addView:xxxxxxxxx
 */
- (void)insertView: (UIView *)view
        beforeView: (UIView *)beforeView
         afterView: (UIView *)afterView
        withHeight: (CGFloat)height
             width: (CGFloat)width
               top: (CGFloat)top
            bottom: (CGFloat)bottom
              left: (CGFloat)left
             right: (CGFloat)right
           centerX: (BOOL)centerX;

/**
 移除一个view,移除后占位空间为padding
 */
- (void)removeView: (UIView *)view withPadding: (CGFloat)padding;

@end

