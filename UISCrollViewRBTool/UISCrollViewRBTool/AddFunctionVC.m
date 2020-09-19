//
//  AddFunctionVC.m
//  UISCrollViewRBTool
//
//  Created by Mac on 2020/9/19.
//

#import "AddFunctionVC.h"
#import "Masonry.h"
#import "UIScrollView+RBAdd.h"

@interface AddFunctionVC ()

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *toolView;

@end

@implementation AddFunctionVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Private

- (void)setup
{
    self.title = @"添加演示";
    self.view.backgroundColor = UIColor.whiteColor;
    
    //设置宽度
    [self.scrollView rbSetContentWidth:UIScreen.mainScreen.bounds.size.width];
    //左侧,宽高固定
    [self.scrollView addView:({
        UILabel *view = UILabel.new;
        view.backgroundColor = [UIColor colorWithRed:0.9 green:0.5 blue:0.6 alpha:1];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont systemFontOfSize:14];
        view.text = @"左侧,固定宽高";
        view;
    }) withHeight:35 width:120 top:20 bottom:0 left:30 right:CGFLOAT_MIN centerX:NO];
    //左右固定,高固定
    [self.scrollView addView:({
        UILabel *view = UILabel.new;
        view.backgroundColor = [UIColor colorWithRed:0.5 green:0.9 blue:0.6 alpha:1];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont systemFontOfSize:14];
        view.text = @"左右固定,高固定";
        view;
    }) withHeight:35 width:CGFLOAT_MIN top:20 bottom:0 left:30 right:30 centerX:NO];
    //右侧,宽固定
    [self.scrollView addView:({
        UILabel *view = UILabel.new;
        view.backgroundColor = [UIColor colorWithRed:0.6 green:0.5 blue:0.9 alpha:1];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont systemFontOfSize:14];
        view.numberOfLines = 0;
        view.text = @"右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定,右侧,宽固定";
        view;
    }) withHeight:CGFLOAT_MIN width:120 top:20 bottom:0 left:CGFLOAT_MIN right:30 centerX:NO];
    //工具块
    [self.scrollView addView:({
        UILabel *view = UILabel.new;
        self.toolView = view;
        view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont systemFontOfSize:14];
        view.textColor = UIColor.whiteColor;
        view.numberOfLines = 0;
        view.text = @"工具块";
        view;
    }) withHeight:100 width:CGFLOAT_MIN top:20 bottom:0 left:30 right:30 centerX:NO];
    //居中,宽高不固定
    [self.scrollView addView:({
        UISwitch *view = [UISwitch new];
        view.on = YES;
        [view addTarget:self action:@selector(switchEvent:) forControlEvents:UIControlEventValueChanged];
        view;
    }) withHeight:CGFLOAT_MIN width:CGFLOAT_MIN top:20 bottom:0 left:CGFLOAT_MIN right:CGFLOAT_MIN centerX:YES];
    //随意添加撑高度
    for (NSInteger i = 0; i < 10; i++)
    {
        [self.scrollView addView:({
            UILabel *view = UILabel.new;
            view.textAlignment = NSTextAlignmentCenter;
            view.font = [UIFont systemFontOfSize:14];
            view.text = [NSString stringWithFormat:@"高度填充%zd", i + 1];
            view.layer.borderColor = view.textColor.CGColor;
            view.layer.borderWidth = 1;
            view;
        }) withHeight:35 width:CGFLOAT_MIN top:20 bottom:60 left:30 right:30 centerX:NO];
    }
}

#pragma mark - Network

#pragma mark - Event

- (void)switchEvent: (UISwitch *)sender
{
    [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sender.on? 100: 0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Setter

#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        self.scrollView = ({
            UIScrollView *scrollView = [UIScrollView new];
            self.scrollView = scrollView;
            scrollView.backgroundColor = UIColor.whiteColor;
            [self.view addSubview:scrollView];
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            scrollView;
        });
    }
    return _scrollView;
}

@end
