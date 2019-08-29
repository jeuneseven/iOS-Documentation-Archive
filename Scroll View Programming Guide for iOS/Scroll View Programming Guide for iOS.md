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

你可能想要沿着scroll view的内容的边缘添加边距，通常需要在顶部和底部添加，那么控制器以及工具栏就不会挡住内容了。要添加边距的话，使用 contentInset 属性来给scroll view的内容指定一个缓冲区域。考虑它的一个方法是，在不更改子视图大小或视图内容大小的情况下，使滚动视图内动区域变大。  
contentInset属性是一个UIEdgeInsets结构体，有top, bottom, left, right字段。图1-3展示了contentInset 和 contentSize 所指示的内容。  

图 1-3 contentSize 和 contentInset 所代表的内容

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/contentSize_contentInset.jpg)  

如图1-3所示，指定 contentInset 属性 (64,44,0,0) 的结果是在顶部的内容上增加了64像素的区域（20像素给状态栏，44像素给导航控制器）以及底部增加了44像素（工具栏的高度）。给 contentInset 设置这些值就能够展示导航控制以及工具栏到屏幕上了，还能够滚动展示scroll view的整个内容区域。  

清单1-3 设置 contentInset 属性  

	- (void)loadView {
	    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
	    scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	    self.view=scrollView;
	    scrollView.contentSize=CGSizeMake(320,758);
	    scrollView.contentInset=UIEdgeInsetsMake(64.0,0.0,44.0,0.0);
	 
	    // do any further configuration to the scroll view
	    // add a view, or views, as a subview of the scroll view.
	 
	    // release scrollView as self.view retains it
	    self.view=scrollView;
	    [scrollView release];
	}

图1-4展示了给contentInset的top和bottom设置值之后的结果。当滚动到顶部时（像左边所展示的那样），屏幕会为导航栏和状态栏留出空间。右边的图展示了内容滚动到底部时给工具栏留出的空间。两种情况下你都能看到内容滚动的时候会穿过导航栏和工具栏，而当内容完全滚动到顶部或底部时，所有内容都是可见的。

图1-4 给contentInset的top和bottom设置值之后的结果

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/contentInset_results.jpg)

不过，改变contentInset的值在当你的scroll view展示滚动指示器的时候会有一个意外的边际效果。当用户将内容拖到屏幕的顶部或底部的时候，滚动指示器会滚动到contentInset定义的所有区域，比如在导航控制器和工具栏中。  
要校正这点，你必须设置scrollIndicatorInsets属性。和contentInset属性一样，scrollIndicatorInsets属性也被定义为一个UIEdgeInsets结构体。设置垂直方向的内边距值会限制垂直滚动指示器在展示的时候会越过该区域展示，这也会导致水平滚动指示器显示在contentInset区域之外展示。  
在不设置contentInset和scrollIndicatorInsets属性能够让滚动指示器在导航控制器和工具栏之上展示，但这不是需要的结果。但是设置scrollIndicatorInsets值能够将内容匹配contentInset的值来修复这个问题。  
正确的loadView方法的实现参见清单1-4，添加了额外的配置scroll view 的 scrollIndicatorInsets 初始化相关的代码。

清单1-4 设置scroll view的contentInset和scrollIndicatorInsets属性  

	- (void)loadView {
	    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
	    scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	    scrollView.contentSize=CGSizeMake(320,758);
	    scrollView.contentInset=UIEdgeInsetsMake(64.0,0.0,44.0,0.0);
	    scrollView.scrollIndicatorInsets=UIEdgeInsetsMake(64.0,0.0,44.0,0.0);
	 
	    // do any further configuration to the scroll view
	    // add a view, or views, as a subview of the scroll view.
	 
	    // release scrollView as self.view retains it
	    self.view=scrollView;
	    [scrollView release];
	}

# 滚动滚动视图的内容
最常见的初始化一个scroll view的滚动的方法是直接让用户触摸屏幕并拖拽他/她的手指来操作。滚动内容随后会滚动以响应动作。该收拾被称作拖拽手势。  
拖拽手势的变种是弹开手势。弹开手势是一种用户的手指刚开始与屏幕接触的快速移动，拖拽的方向与滚动方向相同，然后离开屏幕的过程。这种手势不仅仅会引起滚动，它还会触发一种动能，基于用户的拖拽动作的速度，会在手势完成之后继续滚动。滚动会在一段时间之后减速。弹开手势能够让用户只用一个动作就移动一大段距离。在减速的任意时刻。用户都能够触摸屏幕来停止滚动。所有的这些行为都在UIScrollView中内置，并且无需开发者实现。  
不过有时候需要应用程序以代码的形式滚动内容，举例来说，展示一个文档的一个指定部分。在这种情况下，UIScrollView提供了所需要的方法。  
UIScrollView的代理协议 UIScrollViewDelegate 提供了各种方法让你的应用程序能够跟踪滚动过程，根据你的应用程序所需来响应特殊需求。  
## 以编码方式滚动
滚动一个scroll view的内容并非只是为了响应用户的手指拖拽或轻触屏幕。当你的应用程序需要滚动到一个特定内容位移时，就需要一个特定的矩形区域暴露出来（或者滚动到scroll view的顶部）。UIScrollView提供了方法来执行所有的这些事件。  
### 滚动到一个特定的位置
滚动到一个指定的左上方区域（contentOffset属性）可以以两种方式完成。setContentOffset:animated: 方法会将内容滚动到指定的内容位移。若动画参数设置为YES，那么滚动将以动画的方式从当前位置滚动到指定的位置，并且是以恒定的速率。若动画参数设置为NO，滚动会立即发生，并且不会伴有动画。不论哪种情况，代理都会发送 scrollViewDidScroll: 消息。若动画被禁止，或者你直接通过设置contentOffset属性来改变内容的位移，代理会只接收到一次 scrollViewDidScroll: 消息。若动画开启，代理会在动画的过程中接收到一系列的 scrollViewDidScroll: 消息。当动画完成时，代理接收到一个  scrollViewDidEndScrollingAnimation: 消息。  
### 将一个矩形区域可视化
还可以滚动到一个矩形区域让其可见。这在应用程序需要展示一个当前在可视区域之外的控件到可视视图上时尤其有用。scrollRectToVisible:animated: 方法会滚动指定矩形区域让其在scroll view 中可见。若动画参数设置为YES，矩形区域会以恒定速度滚动到视图中。与 setContentOffset:animated: 一样，若动画被禁用，代理会收到一个scrollViewDidScroll: 消息。若动画开启，代理会在动画的过程中收到一连串的scrollViewDidScroll: 消息。而在 scrollRectToVisible:animated: 这种情况下，scroll view的tracking和dragging属性也是NO。  
若 scrollRectToVisible:animated: 动画是开启的，代理会收到一条 scrollViewDidEndScrollingAnimation: 消息，通知scroll view已经到达指定位置并完成了动画。  
### 滚动到顶部
若状态栏是可见的，那么scroll view也能够滚动到内容的顶部以响应状态栏的点击。这种情况经常出现在应用程序提供垂直数据的展示的情况下。举例来说，“照片”应用就支持滚动到顶，无论是在相簿选择的列表视图还是照片缩略图的浏览中以及大部分的 UITableView 实现（UIScrollView的子类）都支持滚动到顶。  
你的应用程序可以通过实现 scroll view 的代理方法 scrollViewShouldScrollToTop: 并返回YES来开启这个功能。如果屏幕上一次有多个 scroll view，则通过返回 scroll view进行滚动，该代理方法能够允许对某个scroll view滚动到顶部进行细粒度的控制。  
当滚动完成时，代理方法会发送一条 scrollViewDidScrollToTop: 消息，说明是哪个 scroll view。
## 滚动时会发送代理消息
在滚动发生时，scroll view会使用tracking, dragging, decelerating和zooming等属性跟踪状态。此外，contentOffset属性定义了在scroll view边界左上角可见的内容中的点。下表描述了每个状态属性：  

状态属性  | 描述
------------- | -------------
tracking  | 若用户的手指接触设备屏幕时为YES。
dragging  | 若用户的手指接触屏幕并移动了为YES。
decelerating  | 在滑动手势之后，若scroll view开始减速为YES，或是在scroll view的frame之外拖拽时也为YES。
zooming  | 若scroll view 检测到捏合手势来改变 zoomScale 属性时为YES。
contentOffset  | CGPoint类型的值，定义了scroll view边界的左上角。

不必轮询这些属性来确定正在进行的操作，因为scroll view 会向代理发送详细的消息序列，指示滚动操作的进度。这些方法允许你的应用程序根据需要进行相应。代理方法可以查询这些状态属性，以确定接收消息的原因或scroll view当前的位置。

### 简单的方式：跟踪一个滚动事件的开始和结束
如果你的应用程序只对滚动过程的开始和结束感兴趣，你可以只实现代理方法的很少的一个子集方法即可。  
实现 scrollViewWillBeginDragging: 方法来接收拖拽将要开始的通知。  
要判断何时滚动完成，你需要实现两个代理方法： scrollViewDidEndDragging:willDecelerate: 和 scrollViewDidEndDecelerating:。无论是当代理接收到 scrollViewDidEndDragging:willDecelerate: 消息，decelerate参数为NO，还是代理接收到scrollViewDidEndDecelerating: 方法都代表滚动完成。无论哪种情况，滚动都完成了。
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