[Debugging with Xcode 原文链接](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/debugging_with_xcode/chapters/about_debugging_w_xcode.html#//apple_ref/doc/uid/TP40015022)

# 关于使用Xcode调试
查找和排查代码问题是开发过程中的很重要的步骤。Xcode调试器内置强大功能来进行通用调试，并在你的应用程序加载的时候自动运行。调试器能够帮助你：  

* 确定和定位问题
* 检测运行代码的控制流和数据结构来找到原因
* 根据你的代码设计解决方案和编辑
* 运行修改后的应用程序并确保它的修复能够运行

## 预读
你应当对于应用程序设计和编程的概念比较熟悉。最好对于Xcode比较熟悉；参见《Xcode概览》。
## 另请参见

# 快速开始
## 准备调试
两个在调试时最重要的事情是代码的分析逻辑和流程控制，并确保应用程序展现正确的数据。有逻辑问题的应用程序会展示不可预期的行为：没有事情发生，有错误的事情发生或者应用程序崩溃。执行不正确操作的代码通常会给用户展示错误的数据；想象一下，你点击一个计算器1+1，最终得到结果20。当看到一个问题时，你需要进行调试，要确保应用程序的行为如预期一样，并将正确的结果展示给用户。  
假如你运行你的应用程序然后发现你新添加的代码看起来并没有执行。你不知道是你的代码没有被执行还是它没有产生输出。但你知道肯定有错误发生，你有了一个bug。
## 在调试模式下检测应用程序
其他问题的情况可能会更难发现。在调试模式下检测应用程序能给你机会使用调试仪器来监控系统资源的使用。注意图片的形状，考虑什么是你在运行应用程序时期待看到的以及不同部分的代码被调用来运行。举例来说，若你看到在CPU检测中的尖状波或者再内存检测中持续上升的部分，那么很有是因为某些问题所引起的了。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-2a_2x.png)  

点开表格的一项能够打开一个更详细的状态报告。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-3a_2_2x.png)  

无论是你新编写的代码没有按照你的期望运行还是你在调试界面看到了意外状况，你很可能不会立即知道问题的原因。不过，你已经有了以下信息：  

* 你的应用程序在你开始添加新功能之前是运行正常的。
* 直到你使用应用程序的UI运行新代码之前，它的行为都是正确的。
* 你知道你添加到源代码中的新代码是什么。

若要更进一步的隔离原因，你可以设置代码的“断点”。
## 使用断点
断点是一种检测运行中应用程序的常用方式。  
断点会阻断正常运行让你能够通过调试栏控制来单步运行应用程序以便检测每一行代码的控制流程和变量状态。当你的代码遇到断点的时候，调试器会暂停应用程序，切换到Xcode主窗口的需要检测的代码的位置，并居于变量视图和调试导航进程视图来查看暂停的应用程序的状态。断点拥有多个功能来让你修改它的行为使得你更容易获取信息。你可以在应用程序运行之前或运行中添加断点到你的源代码中。  
要插入一个断点：  

1. 在源代码编辑器的源代码中定位。
2. 点击源代码编辑器挨着源代码那行的边槽处来让调试器根据需要暂停你的应用程序。

文件和行断点被创建后，默认是激活状态。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-4_2_2x.png)  

你可以使用调试栏中的控件以多种方式单步执行，如同你在“调试器控件”中所看到的一样。手动单步执行过一段代码是检测你代码的一种清晰方式，而且它可能很耗时。一旦你将一个断点置于你的代码中，你可以以不同的方式将其设置，使其提高调试的效率。点击断点来展示详细菜单，然后选择编辑断点。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-5_2x.png)

你可以将断点配置为根据条件暂停程序。由于你的应用程序是在断点激活的状态下运行的，你可以使用在源代码范围内的应用程序中的任意代码或变量，该位置的断点被会被一个条件所激活。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-6_2x.png)

断点条件在很多地方都有用。举个例子，假设你的功能依赖于一个变量的状态。你会注意到，当一个问题发生，你会检测到变量，而应用程序会停在该断点上，该变量会有一个特殊状态——nil或某个其他的特殊值。一旦你注意到它，你可以设置一个断点条件来检测变量并仅当变量是该值时应用程序才会暂停。  
另一个断点的有用的功能是能够调起一个动作执行。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-7_2x.png)

给定上述情况，当循环次数在增加，变量需要达到一个特定状态，也许你需要知道每次循环执行的时候变量的值。在每次经过循环的时候，你可以设置断点动作来打印变量的描述到控制台（使用LLDB命令 po，po是LLDB为“打印对象”命令提供的缩写）。  
在你的代码中的断点被断点导航器所管理。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-8_2x.png)

使用断点导航器，你可以看到所有在你的代码中设置的断点，编辑它们，激活或禁用它们，并且能够改变它们在Xcode上下文中的操作域。若要激活或禁用一个断点，点击它在断点导航栏或源代码编辑器中的标志；一个变暗的标志表示该断点被禁用了。  
当你使用完断点后，要删除一个断点的话，你需要做以下几种之一即可：  

* 将其拖拽出源代码编辑器边栏。
* 自断点导航栏中选中它然后点击删除。
* 按住control点击它（在源代码编辑器或断电导航栏中）然后选择删除断点。

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-9_2x.png)  

你可以同时激活或禁用多个断点。举例来说，在你需要定位代码中不同部分的几个问题时，你就可能需要这么做。  
在断电导航栏中点击断点行会在源代码编辑器中移动到该断点的位置。  
当你放置了一组断点来调试一个问题，但临时需要没有这些断点造成的停顿来运行你的应用程序以便能够达到你需要调试的问题将要发生时的状态。要禁用或激活所有的断点，点击调试栏中的断点激活按钮。  

```
注意：断点激活按钮没有改变设置断点的激活/禁用。所有的断点依旧在该位置，激活或禁用的状态和它们被禁用之前的状态一样。
```

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-qs-11_2x.png)

## 调试器中的控制流

### 调试器中的单步控制

### 通过变量视图截获变量

### 了解控制台

## 在调试器导航中检测回溯

## 通过调试过程进行循环

# 调试工具

## 常用备注

### 调试的五大部分和调试工具

### LLDB和Xcode调试器

### Xcode工具控制

### Xcode调试和Product菜单

## 调试区域

## 断点和断点导航

## 源码编辑器

## 调试导航

## 调试视图层级

## OpenGL ES调试

## Scheme编辑器的调试选项

# 专业调试工作流

## 调试视图层级

## 调试应用程序扩展

## 线程和队列调试

## 内存图调试

## 使用地址清除

## 使用线程清除

## 使用未定义行为清除

## 调试Metal和OpenGL ES

## 使用替代工具链

# 快速查看数据类型
Xcode调试器包含变量快速查看功能，这是一种通过弹出框展示对象变量内容来查看当前对象变量状态的方式，不论是在调试器变量视图中通过点击“快速查看”按钮或是通过点击选中变量的空格键都可以做到。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-ql-qlbuttons_2x.png)

不是所有的操作系统对象类型都能够通过快速查看来展示，不过很多都可以。以下清单列出了操作系统支持快速查看的常用对象类型：  

类分类  | 对象类型
------------- | -------------
图片类  | NSImage、UIImage、NSImageView、UIImageView、CIImage、NSBitmapImageRep
光标类  | NSCursor
颜色类  | NSColor、UIColor
贝塞尔路径类  | NSBezierPath、UIBezierPath
定位类  | CLLocation
视图类  | NSView、UIView
字符串类  | NSString
属性字符串类  | NSAttributedString
数据类  | NSData
URL类  | NSURL
SpriteKit类  | SKSpriteNode、SKShapeNode、SKTexture、SKTextureAtlas

即使是不在该清单中的对象你也可以尝试使用快速查看功能。若快速查看不支持你选中的对象的类型，Xcode会为该对象展示默认快速查看。  

![](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/Art/dwx-ql-default_2x.png)  

你还可以通过给对象类添加渲染方法来扩展自定义对象的快速查看的使用。参见“在Xcode调试器中快速查看自定义类型”来了解如何在你的自定义对象类中实现快速查看。
# 附录：静态分析
在你运行你的应用程序之前，你可以使用静态分析来查找你的代码的bug。静态代码扫描会在短短几秒钟之内尝试上千种可能的方式，报告潜在的隐藏的问题或可能很难复现的问题。这个过程同样能够在你的代码中确定未遵循API使用的部分，比如Foundation，UIKit，和 AppKit等常用库。  
要执行静态代码扫描，请选择Product > Analyze。Xcode静态分析将会解析项目的源代码以及定位以下几种类型的问题：  

* 逻辑缺陷，比如访问了未初始化的变量以及不相关的空指针
* 内存管理缺陷，比如内存分配泄露
* 废弃存储（不再使用的变量）缺陷
* API使用缺陷，未遵循项目使用的框架和库的相关使用方式

在问题导航栏中静态编译会报告相关问题，通过点击项目的导航栏的问题导航按钮即可查看。在问题导航中选择一个静态分析消息会在源代码编译器中展示相关代码。在源代码编辑器中点击相应的消息。使用源代码编辑器上方的静态分析结果栏的弹出菜单来了解缺陷的流程。然后编辑代码来修复缺陷。
## 执行静态代码扫描
查找缺陷——潜在的问题——使用Xcode内置的静态代码扫描来对项目的源代码进行扫描。源代码可能有被编译器忽略的微小问题，但在运行时会展示出来，这样的问题很难定位和修复。  
若要在你的源代码当中使用静态分析查找缺陷：  
  1. 选择Product > Analyze。  
  2. 在问题导航栏，选择一个分析消息。  
  3. 在源代码编辑器中，点击相应的消息。  
  4. 使用源代码编辑器上方的静态分析结果栏的弹出菜单来了解缺陷的流程。  
  5. 编辑代码来修复缺陷。  
你可以通过使用断言，属性或编译指示等指令来禁止分析器产生假阳性信息。  
当你第一次分析一个项目的时候，你可能会发现有大量的问题。不过你要是定期的运行静态扫描并修复其展示的缺陷的话，你会在随后的分析中发现越来越少的问题。尽早分析，经常分析。这对代码有好处。  

```
注意：若静态分析没有报告问题，你不能够假设没有问题。该工具不能够确保检测到源代码的所有问题。
```

```
提示：选择Product > Clean来移除问题导航栏中的静态分析消息。
```