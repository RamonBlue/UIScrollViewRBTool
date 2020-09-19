//
//  UIScrollView+RBLayout.m
//  Culture
//
//  Created by Lan on 2018/1/15.
//  Copyright © 2018年 SummerTea. All rights reserved.
//

#import "UIScrollView+RBAdd.h"
#import "Masonry.h"
#import <objc/objc.h>
#import <objc/runtime.h>

static char *const RB_BOTTOM_CONS_KEY = "RB_BOTTOM_CONS_KEY";
static char *const RB_TOP_CONS_KEY = "RB_TOP_CONS_KEY";
static char *const RB_VIEWS_ARRAY_KEY = "RB_VIEWS_ARRAY_KEY";

@implementation UIScrollView(RBAdd)

#pragma mark - Private

- (void)setLastBottomCons: (MASConstraint *)cons
{
    [self setBottomCons:cons forView:self];
}

- (MASConstraint *)getLastBottomCons
{
    return [self getBottomConsForView:self];
}

- (void)setBottomCons: (MASConstraint *)cons forView: (UIView *)view
{
    objc_setAssociatedObject(view, RB_BOTTOM_CONS_KEY, cons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MASConstraint *)getBottomConsForView: (UIView *)view
{
    return objc_getAssociatedObject(view, RB_BOTTOM_CONS_KEY);
}

- (void)setTopCons: (MASConstraint *)cons forView: (UIView *)view
{
    objc_setAssociatedObject(view, RB_TOP_CONS_KEY, cons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MASConstraint *)getTopConsForView: (UIView *)view
{
    return objc_getAssociatedObject(view, RB_TOP_CONS_KEY);
}

- (NSMutableArray *)getViewsArray
{
    NSMutableArray *arrayM = objc_getAssociatedObject(self, RB_VIEWS_ARRAY_KEY);
    if (!arrayM)
    {
        arrayM = [NSMutableArray array];
        objc_setAssociatedObject(self, RB_VIEWS_ARRAY_KEY, arrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arrayM;
}

#pragma mark - Public

- (void)rbSetContentWidth:(CGFloat)width
{
    NSMutableArray *mySubViews = [self getViewsArray];
    for (NSInteger i = mySubViews.count - 1; i >= 0; i--)
    {
        UIView *subView = mySubViews[i];
        [subView removeFromSuperview];
    }
    [self setLastBottomCons:nil];
    [mySubViews removeAllObjects];
    
    UIView *stick = [UIView new];
    [mySubViews addObject:stick];
    stick.backgroundColor = [UIColor clearColor];
    [self addSubview:stick];
    [stick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(0.1);
        MASConstraint *bottomCons = make.bottom.mas_equalTo(0);
        [self setLastBottomCons:bottomCons];
        [self setBottomCons:bottomCons forView:stick];
    }];
}

- (void)addView: (UIView *)view
     withHeight: (CGFloat)height
          width: (CGFloat)width
            top: (CGFloat)top
         bottom: (CGFloat)bottom
           left: (CGFloat)left
          right: (CGFloat)right
        centerX:(BOOL)centerX
{
    [self insertView:view beforeView:nil afterView:nil withHeight:height width:width top:top bottom:bottom left:left right:right centerX:centerX];
}

- (void)insertView: (UIView *)view
        beforeView: (UIView *)beforeView
         afterView: (UIView *)afterView
        withHeight: (CGFloat)height
             width: (CGFloat)width
               top: (CGFloat)top
            bottom: (CGFloat)bottom
              left: (CGFloat)left
             right: (CGFloat)right
           centerX: (BOOL)centerX
{
    if (!view)
    {
        return;
    }
    
    NSMutableArray *mySubViews = [self getViewsArray];
    if (!mySubViews.count)
    {
        //没调用 rbSetContentWidth: 不执行
        return;
    }
    
    if (afterView == mySubViews.lastObject)
    {
        afterView = nil;
    }
    
    //加view
    [self addSubview:view];
    
    //修改约束
    if (beforeView)
    {
        if (![mySubViews containsObject:beforeView])
        {
            return;
        }
        
        NSInteger index = [mySubViews indexOfObject:beforeView];
        UIView *theBeforeView = mySubViews[index - 1];
        UIView *theAfterView = beforeView;
        [mySubViews insertObject:view atIndex:index];
        
        MASConstraint *bottomCons = [self getBottomConsForView:theBeforeView];
        [bottomCons uninstall];
        MASConstraint *topCons = [self getTopConsForView:theAfterView];
        [topCons uninstall];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *topCons = make.top.mas_equalTo(theBeforeView.mas_bottom).offset(top);
            [self setTopCons:topCons forView:view];
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *bottomCons = make.bottom.mas_equalTo(theAfterView.mas_top).offset(-bottom);
            [self setBottomCons:bottomCons forView:view];
        }];
        
    }
    else if(afterView)
    {
        if (![mySubViews containsObject:afterView])
        {
            return;
        }
        
        NSInteger index = [mySubViews indexOfObject:afterView];
        UIView *theBeforeView = afterView;
        UIView *theAfterView = mySubViews[index + 1];
        [mySubViews insertObject:view atIndex:index + 1];
        
        MASConstraint *bottomCons = [self getBottomConsForView:theBeforeView];
        [bottomCons uninstall];
        MASConstraint *topCons = [self getTopConsForView:theAfterView];
        [topCons uninstall];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *topCons = make.top.mas_equalTo(theBeforeView.mas_bottom).offset(top);
            [self setTopCons:topCons forView:view];
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *bottomCons = make.bottom.mas_equalTo(theAfterView.mas_top).offset(-bottom);
            [self setBottomCons:bottomCons forView:view];
        }];
    }
    else
    {
        //获取上一个view
        UIView *lastView = mySubViews.lastObject;
        [mySubViews addObject:view];
        MASConstraint *bottomCons = [self getLastBottomCons];
        [bottomCons uninstall];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *topCons = make.top.mas_equalTo(lastView.mas_bottom).offset(top);
            [self setTopCons:topCons forView:view];
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *bottomCons = make.bottom.mas_equalTo(-bottom);
            [self setLastBottomCons:bottomCons];
            [self setBottomCons:bottomCons forView:view];
        }];
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (height != CGFLOAT_MIN)
        {
            make.height.mas_equalTo(height);
        }
    }];
    
    if (width != CGFLOAT_MIN)
    {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
        if (centerX)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
            }];
        }
        else if(left != CGFLOAT_MIN)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
            }];
        }
        else if(right != CGFLOAT_MIN)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-right);
            }];
        }
    }
    else
    {
        if (centerX)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
            }];
        }
        else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (left != CGFLOAT_MIN)
                {
                    make.left.mas_equalTo(left);
                }
                if (right != CGFLOAT_MIN)
                {                
                    make.right.mas_equalTo(-right);
                }
            }];
        }
    }
}

- (void)removeView: (UIView *)view withPadding:(CGFloat)padding
{
    if (!view)
    {
        return;
    }
    
    NSMutableArray *mySubViews = [self getViewsArray];
    if (![mySubViews containsObject:view])
    {
        return;
    }
    if (!mySubViews.count)
    {
        //没调用 rbSetContentWidth: 不执行
        return;
    }
    NSInteger index = [mySubViews indexOfObject:view];
    UIView *beforeView = mySubViews[index - 1];
    if (index == mySubViews.count - 1)
    {
        [[self getBottomConsForView:beforeView] uninstall];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-padding);
        }];
        
        [beforeView mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *bottomCons = make.bottom.mas_equalTo(-padding);
            [self setLastBottomCons:bottomCons];
            [self setBottomCons:bottomCons forView:beforeView];
        }];
    }
    else
    {
        [[self getBottomConsForView:beforeView] uninstall];
        UIView *afterView = mySubViews[index + 1];
        [[self getTopConsForView:afterView] uninstall];
        
        [beforeView mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *bottomCons = make.bottom.mas_equalTo(afterView.mas_top).offset(-padding);
            [self setBottomCons:bottomCons forView:beforeView];
        }];
        
        [afterView mas_makeConstraints:^(MASConstraintMaker *make) {
            MASConstraint *topCons = make.top.mas_equalTo(beforeView.mas_bottom).offset(padding);
            [self setTopCons:topCons forView:afterView];
        }];
    }
    
    [mySubViews removeObject:view];
    [view removeFromSuperview];
}

@end
