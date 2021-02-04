[Graphics & Animation Starting Point](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Graphics_iPhone/index.html#//apple_ref/doc/uid/TP40007300)

iOS提供了多种不同的框架来为你的应用添加图形和动画。UIKit是一个OC的API，它提供了基本的2D绘制，图片处理，以及提供动画的方式来展现用户的界面对象。Core Graphics是一个基于C的API，它为矢量图形，位图和PDF内容提供了支持。Core Animation是另一个OC的API，它为用户界面添加流畅的动作和动态的反馈。OpenGL ES是一个OpenGL的移动版本，它为2D和3D绘制提供了高性能。OpenGL ES包含了EAGL，一个OC的API，它整合了OpenGL ES和Core Animation 以及 UIKit。  

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Graphics_iPhone/Art/animation_gs.jpg)

# 快速建立和运行

要在你的用户界面中使用UIKit进行基本的图形操作：  

* 阅读《iOS 视图编程指南》来理解例如视图层级，iOS原生坐标系统，以及你可以在视图上执行的操作等内容。
* 阅读《iOS 绘制和打印指南》来学习如何使用UIKit操作绘制任务。《CGContext参考》描述了你能够用来绘制的大部分函数。
* 阅读《UIImageview类参考》和《UIImage类参考》来在你的应用程序上使用图片。若要允许用户能够放大图片，阅读《UIScrollView类参考》和《 UIScrollViewDelegate协议参考》。  

当你需要更多的2D绘制功能时，使用Core Graphics 框架。它是绘制矢量图，线，图形，模型，渐变，图片甚至PDF文档的主力。  

* 阅读《Quart 2D概览》来了解如何在Core Graphics中进行绘制工作。（Quartz 2D是在Core Graphics中用于2D绘图引擎的术语。）要查找如何执行指定绘制任务——举例来说，创建一个模型，路径或者渐变——阅读在《Quartz 2D编程指南》中的适当章节。

Core Animation是UIKit框架用来布局和转换它的类的编程接口。如果你的应用程序需要细粒度的控制动画，请使用Core Animation。  

* 阅读《iOS视图编程指南》中的“动画”章节来让你开始动画视图。
* “MoveMe”示例应用程序包含了动画视图的例子并展示了如何设置关键帧动画。

使用OpenGL ES来开发游戏和其他的由GPU提供的需要高级绘图功能的应用程序。  

* 阅读《OpenGL ES概览》，由Khronos提供，它是维护OpenGL ES规范的行业标准。
* 下一步，在Xcode中查看“GLSprite”示例应用程序。

# 成为专家

了解更多UIKit类的详情，参见《UIKit框架参考》。  
了解更多Core Graphics详情，参见 Core Graphics框架参考。
要更深入的理解动画，阅读《Core Animation编程指南》和参考“MoveMe”示例应用。  
有关如何在iOS上最好的利用OpenGL ES，阅读《OpenGL ES编程指南》。更多关于OpenGL ES的详情，参见《OpenGL ES 框架参考》。