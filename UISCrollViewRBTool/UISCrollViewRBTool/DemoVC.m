//
//  DemoVC.m
//  UISCrollViewRBTool
//
//  Created by Mac on 2020/9/19.
//

#import "DemoVC.h"
#import "Masonry.h"
#import "UIScrollView+RBAdd.h"

@interface DemoVC ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DemoVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Private

- (void)setup
{
    self.title = @"插入演示";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    //设置宽度
    [self.scrollView rbSetContentWidth:UIScreen.mainScreen.bounds.size.width];
    
    //添加控件
    [self.scrollView addView:[self headerViewWithTitle:@"基本信息"] withHeight:CGFLOAT_MIN width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self lineView] withHeight:10 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"姓名" placeHolder:@"您的真实姓名"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"所在单位" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"电话号码" placeHolder:@"请填写手机号码"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self headerViewWithTitle:@"其他信息"] withHeight:CGFLOAT_MIN width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self lineView] withHeight:10 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"是否婚配" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"学历" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"爱好" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"家庭住址" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"疾病史" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"光辉事迹" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"禁忌" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"口味" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"偏好" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"发色" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self titleFieldViewWithTitle:@"身高" placeHolder:@"选填"] withHeight:48 width:CGFLOAT_MIN top:0 bottom:0 left:0 right:0 centerX:0];
    [self.scrollView addView:[self commitBtn] withHeight:44 width:240 top:40 bottom:60 left:CGFLOAT_MIN right:CGFLOAT_MIN centerX:YES];
    
}

#pragma mark - Network

#pragma mark - Event


#pragma mark - Setter



#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        self.scrollView = ({
            UIScrollView *scrollView = [UIScrollView new];
            scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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

- (UIView *)headerViewWithTitle: (NSString *)title
{
    UIView *view = [UIView new];
    
    UIView *dotView = [UIView new];
    dotView.backgroundColor = UIColor.redColor;
    dotView.layer.cornerRadius = 5;
    dotView.clipsToBounds = YES;
    [view addSubview:dotView];
    [view addSubview:dotView];
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.width.height.mas_equalTo(10);
        make.top.mas_equalTo(17);
        make.bottom.mas_equalTo(-17);
    }];
    
    UILabel *titleL = [UILabel new];
    titleL.text = title;
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotView.mas_right).offset(5);
        make.centerY.mas_equalTo(dotView);
    }];
    
    return view;
}

- (UIView *)lineView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return view;
}

- (UIView *)titleFieldViewWithTitle: (NSString *)title placeHolder: (NSString *)placeHolder
{
    UIView *view = [UIView new];
    
    UILabel *titleL = [UILabel new];
    titleL.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = title;
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    
    UITextField *field = [UITextField new];
    field.font = titleL.font;
    field.textColor = titleL.textColor;
    field.placeholder = placeHolder;
    [view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(titleL.mas_right);
        make.right.mas_equalTo(-13);
    }];
    
    UIView *lineView = [self lineView];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    return view;
}

- (UIButton *)commitBtn
{
    UIButton *view = [UIButton new];
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    [view setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    view.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [view setTitle:@"提交" forState:UIControlStateNormal];
    view.backgroundColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.65 alpha:1];
    return view;
}

@end
