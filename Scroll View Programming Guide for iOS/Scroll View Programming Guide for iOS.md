[Scroll View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008179)

# 介绍
## 关于滚动视图编程
当内容需要被展示和操作，但整个屏幕不够的时候，就需要iOS应用中的Scroll view了。Scroll view有两个主要用途：  

* 让用户拖拽他们想要展示的内容区域
* 让用户使用捏合手势放大或缩小展示内容区域

下图展示了一个 UIScrollView 类的典型使用方式。子视图是一个UIImageView，它包含一张小男孩的图片。当用户拖拽他/她在屏幕上的手指时，图片的视角就会进行移动，正如你在图片中看到的那样，滚动指示器就展现出来了。当用户手指离开时，指示器就消失了。

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/NSImageView_UIScrollView.jpg)

### 概览
UIScrollView 类提供了以下功能：  

* 滚动不能够适应整个屏幕的内容
* 放大或缩小内容，能够让你的应用程序支持标准的捏合手势来放大缩小
* 限制一次只能够滚动到一屏幕内容（paging模式）

UIScrollView 类对其展示的内容无需指定特定视图；它只是直接滚动其子视图。这种简单的模式之所以可行是因为在iOS上scroll view没有对初始滚动做额外的控制。

#### 基本的视图滚动是很容易实现的
滚动可以通过拖拽或轻触手势触发，而无需子类化或者代理。无需使用代码的方式设置UIScrollView实例的内容大小，整个界面都能够在界面编辑器中创建和设计。  

```
相关章节：创建和配置scroll views
```

#### 使用代理来支持捏合缩放手势
添加基本的捏合或缩放手势支持，就需要scroll view使用代理方式了。代理类必须遵循UIScrollViewDelegate协议，并实现协议方法，告诉scroll view 哪个子视图应该缩放。对于最小和最大的放大倍数，你必须指定一个或者两个都指定。  
若你的应用程序需要支持双击放大，两个手指触摸来放大和简单的单指触摸滚动和轻触（还有标准的捏合手势）你需要在你的内容视图中实现代码来处理这些功能。

```
相关章节：使用捏合手势来支持基本的放大功能
```

#### 要支持捏合和触摸手势的缩放，需要在内容视图中实现代码
若你的应用程序需要支持双击放大，两个手指触摸来放大和简单的单指触摸滚动和轻触（还有标准的捏合手势）你需要在你的内容视图中实现代码。  

```
相关章节：通过轻触来放大
```

#### 要支持分页模式，你需要三个子视图
要支持分页模式，无需子类化或者代理就能实现。你需要指定内容尺寸以及开启分页模式。你可以只使用三个子视图就能够实现大部分的分页应用，因此能够节省内存控件增加性能。

```
相关章节：使用分页模式来滚动
```
### 预备知识
在阅读本文之前，请阅读《iOS App编程指南》来理解开发iOS应用程序的基本过程。最好再阅读一下《iOS视图控制器编程指南》来了解视图控制器的基本信息，它通常是和scrollview结合使用的。
### 如何使用本文档
本文档剩余的章节会带你浏览越来越复杂的任务，比如处理轻触-放大技术，理解代理所扮演的角色和消息队列，以及在你的应用程序中嵌套scroll view。
### 另请参见
你会发现以下的示例代码工程对于你自己的table view实现是很好的示例模型：  

* Scrolling 展示了基本的滚动功能。
* PageControl: Using a Paginated UIScrollView 展示了使用分页模式的scroll view。
* ScrollViewSuite 这些高级示例展示了轻触滚动技术以及其他的值得关注的高级功能项目，包括以高效的内存管理方式来平铺较大的精细的图片。

# 创建和配置滚动视图
Scroll view和其他视图的创建一样，通过代码或界面构建器都可以。只有一些额外的配置来达到基本的滚动功能。
## 创建滚动视图
scroll view可以和其他任意视图一样创建插入到一个控制器或一个视图层级当中。只需要额外的两个步骤即可完成scroll view的配置：  

1. 你必须设置contentSize属性给滚动内容的尺寸。这指定了滚动内容的大小。
2. 你比如添加一个视图或一组视图让scroll view用来展示和滚动。这些视图会提供展示内容。

你可以根据你的应用程序所需来选择配置——垂直和水平滚动指示器，拖拽回弹，缩放回弹和滚动的特定约束。
### 在界面编辑器中创建滚动视图

### 以编码方式创建滚动视图
还可以完全通过代码来创建scroll view。这通常在你的控制器类中实现，而且一般在 loadView 方法中。一个简单的实现参见清单1-2.  

清单1-2 通过代码创建scroll view

	- (void)loadView {
	    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
	    scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	    scrollView.contentSize=CGSizeMake(320,758);
	 
	    // do any further configuration to the scroll view
	    // add a view, or views, as a subview of the scroll view.
	 
	    // release scrollView as self.view retains it
	    self.view=scrollView;
	    [scrollView release];
	}

这些代码创建了一个scroll view，尺寸为全屏幕（去掉状态栏），设置了scrollView对象作为控制器的视图，并设置了contentSize属性为320 x 758 像素。这些代码创建的scrollView将可以垂直滚动。  
在这个方法的实现当中还可以有更多的代码，举例来说，可以通过代码插入子视图或者视图并根据需要进行配置。同样的，这些代码假设控制器并没有设置 view。若其设置了，你就需要负责释放已经存在的视图（在设置scroll view 作为控制器的视图之前）。  

## 添加子视图
在你创建和配置scroll view之后，你必须添加一个子视图或者一组子视图来展示内容。是否应该直接在scroll view 中使用单个子视图或是多个子视图，这通常是基于一个要求的设计决策：你的scroll view是否要支持缩放？  
若你要在你的scroll view中支持缩放，常用的技术是使用一个子视图包含整个scroll view的contentSize，然后添加其他的子视图到该视图上。这能够让你指定一个特定的“容器”内容视图作为视图来进行缩放，所有的子视图都可以根据其状态进行缩放。    
若不需要缩放效果的话，那么你的scroll view是使用一个子视图（带或者不带自己的子视图）还是多个子视图就需要根据程序所需来决定了。  

	注意：当返回一个单一子视图时，是常见的情况，你的应用程序可能需要支持允许多个视图在同一个滚动视图中来支持缩放的功能。在那种情况下，你就需要返回适当的子视图并实现代理方法viewForZoomingInScrollView:，这些将在“使用基本的捏合手势来支持基本的缩放”中进行深入讨论。

## 配置滚动视图的内容大小，内容内边距以及滚动指示
contentSize属性是你想要展示在scroll view中的内容的大小。在界面创建器中创建scroll view时，可以设置320 * 758像素的宽高。图1-2中的图片展示了scroll view的内容以及宽高指示器。

图 1-2 contentSize 范围标注的内容  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/contentSize.jpg)  

图 1-3 contentSize 和 contentInset 所代表的内容

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/contentSize_contentInset.jpg)  

# 滚动滚动视图的内容

## 以编码方式滚动

### 滚动到一个特定的位置

### 将一个矩形可视化区域滚动到顶部

## 滚动时会发送代理消息

### 简单的方式：跟踪一个滚动事件的开始和结束

### 完整的代理消息发送顺序

# 基于放大效果使用捏合手势

## 支持捏合缩放手势

## 编码方式的缩放

## 通知代理缩放已经结束

## 当缩放时确保缩放内容sharp

# 通过触摸缩放

## 实现触摸事件代码

### 初始化

### 实现touchesBegan:withEvent:

### 实现touchesEnded:withEvent:

### 实现touchesCancelled:withEvent:

## ScrollViewSuite示例工程

# 使用分页模式滚动

## 配置分页模式

## 配置一个分页滚动视图的子视图

# 嵌套滚动视图

## 相同方向的滚动

## 交叉方向的滚动