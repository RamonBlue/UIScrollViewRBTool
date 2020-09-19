# UIScrollViewRBTool 简单的UIScrollView竖排工具
## 简述: 项目中小型滑动页面很多,用tableView略显笨重,封装一个UIScrollView竖排工具

* 自动管理contentSize,添加子view自动竖向排列(添加规则同autoLayout),支持更改宽高约束

```
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
 ```

![GIF](https://upload-images.jianshu.io/upload_images/1211432-e077b445f6fe3b2b.gif?imageMogr2/auto-orient/strip)

* 支持指定位置插入子view

```
[self.scrollView insertView:({
    UIView *view = [UIView new];
    view.backgroundColor = [self randomColor];
    view;
}) beforeView:self.toolView afterView:nil withHeight:35 width:CGFLOAT_MIN top:20 bottom:20 left:30 right:30 centerX:NO];
```

![GIF](https://upload-images.jianshu.io/upload_images/1211432-ed46667460a43738.gif?imageMogr2/auto-orient/strip)

* 支持子view移除

```
[self.scrollView removeView:view withPadding:30];
```

![GIF](https://upload-images.jianshu.io/upload_images/1211432-d030a8af50d1bd50.gif?imageMogr2/auto-orient/strip)

* 一个简单示例

![GIF](https://upload-images.jianshu.io/upload_images/1211432-727a83250872bd49.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


