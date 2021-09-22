[Collection View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

# 介绍
## 关于iOS Collection View

Collection view 是一种使用灵活可变的布局展示一组有序数据元素的方式。通常使用 collection view 来展示类似网格布局的元素，但 iOS 中的 collection view 的能力不仅仅是行和列那么简单。使用 collection view 能够通过定义好的子类精确布局可见元素并能够动态改变，所以你可以实现单元格，堆列，环绕布局，动态的改变布局，或任何你能够想象的布局类型。  
Collection view 将被展示的数据和用来展示数据的可视化元素严格区分开。在大部分情况下，你的应用程序只需要负责管理数据即可。你的应用程序也可以提供视图对象来展示数据。Collection view 会利用你的视图对象并完成它们在屏幕上布局的所有工作。这个过程会结合布局对象来做，布局对象指定了你的视图的位置和可视化属性，它还可以子类化来适合你的应用程序所需。因此，你负责提供数据，布局对象提供布局相关信息，collection view 会将两者结合来完成最终的显示。

### 概览

标准的 iOS collection view 提供了所有你需要实现简单网格所需的行为。你还可以扩展标准类来支持自定义布局并指定这些布局之间的交互。

#### Collection View管理着数据驱动视图的可视化展示

Collection view 会协助你的应用程序所提供的数据驱动的视图的显示。Collection view 只关心如何使用你的视图以及将其以特定方式布局出来。Collection view 只关心你的视图的展示和排版，而不关心其内容是什么。理解了 collection view 与其数据源，布局对象以及你的自定义对象之间的交互对于在你的应用程序中灵活高效的使用 collection view 是很重要的。

```
相关章节：collection view 基础，设计你的数据源和代理
```

#### 流式布局支持网格以及其他面向行的展示

流式布局对象是由 UIKit 提供的混合布局对象。通常使用该对象来实现网格——即行列交错的元素——不过流式布局支持任意类型的线性流式布局。由于它不仅仅为网格所设计，你还可以通过使用它或子类化它来创建各种有意思和灵活的排版内容。流式布局支持不同尺寸的元素，不同间距的元素，自定义段头和段尾，并无需子类化即可自定义边距。子类化能够让你更灵活的使用流式布局的各种功能。

```
相关章节：使用流式布局
```
#### 手势能够被用在cell和布局操作上

像所有的视图一样，你可以将手势附加到 collection view 上来操作该视图的内容。由于 collection view 包含了一组不同的视图，了解一些结合手势到 collection view 的基本技术会有所帮助。你可以使用手势来操作布局属性或 collection view 的单元格。

```
相关章节：接入手势支持
```
#### 自定义布局能够让你不局限于网格

你可以为你的应用程序继承基本的布局对象来实现自定义布局。尽管设计一个自定义布局无需编写大量代码，但如果你能够理解布局是如何工作的，你就能更好更高效的设计你的布局对象。本文的最后一章会集中分析一个示例工程，该工程会实现一整套自定义布局。

```
相关章节：创建自定义布局，自定义布局举例
```
### 预备知识

在阅读本文档之前，你应该对于视图在iOS应用程序中所扮演的角色有一定的理解。如果你是一个iOS开发的新手并对iOS视图结构不太熟悉的话，请先阅读“iOS视图编程指南”。

### 另请参阅

Collection View 与 table view 有一些类似，它们都能够展示有序的数据给用户。table view 的实现与一个标准 collection view（使用给定流式布局）在使用索引、单元格和视图循环的过程时很类似。不过 table view 的展示是沿一个单列布局所展示的，而 collection view 能够支持多种不同的布局。更多关于 table view 的相关信息，参见“iOS table view 编程指南”。

# Collection View基础

要展示其内容到屏幕上，collection view 要与很多不同的对象共同合作。有些对象是自定义的，并必须由你的应用程序所提供。比如，你的应用程序必须提供一个数据源对象来告诉 collection view 有多少元素需要显示。其他对象由 UIKit 所提供并且是 collection view 基础设计的一部分。  
像 table view 一样，collection view 也是数据驱动的对象，它的实现涉及你的应用程序对象的协作。若要理解你的代码需要做什么，你需要了解一些有关一个 collection view 都做了些什么的背景知识。

## 一个 Collection View 就是一组合作的对象

collection view 的设计是将呈现的数据与数据排列和呈现在屏幕上的方式分隔开。尽管你的应用程序需要完全负责管理被展示的数据，但它的可视化部分同样也被很多不同的对象所管理。清单1-1 列出了 UIKit 中的 collection view 相关类以及他们在实现一个 collection view 界面的过程中所扮演的角色。大部分类都被设计为无需通过子类继承即可使用，所以你可以通过使用很少量的代码就能够实现一个 collection view。若你需要更多功能，你可以通过子类扩展。  

清单1-1 实现 collection view 的类和协议  

| 用途  | 类/协议  | 描述 |
|:------------- |:---------------:| -------------:|
| 顶层容器和管理      | UICollectionView UICollectionViewController | UICollectionView 类的对象为你的 collection view 的内容定义了可视化区域。该类由 UIScrollView 扩展而来，可以根据需要包含一大块可滚动区域。该类同样能够协助从布局对象所接收的布局信息来展示数据。UICollectionViewController 类的对象提供了一个 collection view 的视图控制器级别的支持。它的使用是可选的。 |
| 内容管理      | UICollectionViewDataSource 协议 UICollectionViewDelegate 协议 | 数据源对象是与 collection view 相关的最重要的对象，也是你必须提供的。数据源管理着 collection view 的内容，并创建该内容所需要展示的视图。要实现一个数据源对象，你必须创建一个遵循 UICollectionViewDataSource 协议的对象。collection view 的 delegate 对象能够让你从 collection view 获取你想要的信息，并定制化视图的行为。比如，你可以使用代理对象来跟踪 collection view 中的选取和高亮元素。和数据源对象不同，代理对象是可选的。关于如何实现数据源和代理对象的相关信息，参见“设计你的数据源和代理”部分。 |
| 展示      | UICollectionReusableView UICollectionViewCell | 所有在 collection view 中展示的视图必须是 UICollectionReusableView 类的实例对象。该类支持一种collection view使用的循环机制。循环视图（而不是创建新视图）通常会提高性能，尤其是在其滚动的时候。UICollectionViewCell 对象是一种你主要用来展示数据元素的特殊类型的重用视图。 |
|  布局   | UICollectionViewLayout UICollectionViewLayoutAttributes UICollectionViewUpdateItem | UICollectionViewLayout 的子类被称为布局对象，它负责定义单元格的位置，尺寸以及可视化的属性，并在一个 collection view 中重用视图。在布局期间，一个布局对象会创建属性对象（UICollectionViewLayoutAttributes 类的实例对象）来告诉 collection view 在哪以及如何展示单元格和重用视图。布局对象会在有数据元素插入，删除或移动到 collection view 时接收到 UICollectionViewUpdateItem 类的实例发出的消息。你无须自己创建该类的实例对象。有关更多关于布局对象的相关信息，参见“布局对象控制了界面展示” |
|  流式布局   | UICollectionViewFlowLayout UICollectionViewDelegateFlowLayout | UICollectionViewFlowLayout 类是你用来实现网格或其他基于行列式布局的混合布局对象。你可以使用该类本身或结合流式代理对象一起使用，后者能够让你动态的定制化布局信息。 |

图1-1 展示了一个 collection view 的核心对象之间的关系。collection view 会从它的数据源获取有关展示单元格的相关信息。数据源和代理对象是由你的应用程序提供的自定义对象，它们用来管理内容，包括单元格的选中和高亮。布局对象负责决定这些单元格在什么位置显示以及将这些信息以一个或多个布局属性对象的形式发送给 collection view。collection view 随后会合并布局信息与实际的单元格（以及其他视图）来创建最终的展示式样。  

图1-1 合并内容和布局来创建最终的展示  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_objects_2x.png)

当创建一个 collection view 界面的时候，首先你可以将一个 UICollectionView 对象添加到你的故事版或 nib 文件当中。将 collection view 看做一个中央集线器，所有的其他对象都从中发出。在添加完该对象之后，你可以开始配置其他相关对象，比如数据源或代理。所有的配置都是围绕着 collection view 本身的。例如，在不创建 collection view 对象的情况下，你永远不会创建布局对象。

## 重用视图能够提高性能

Collection View 使用了一种视图循环程序来提高性能。当视图移出屏幕的时候，它们将会被从视图移除并被放置到一个重用队列当中（而非被删除）。当新的内容滚动到屏幕上时，被从队列中移除的视图会被重新复用给新的内容。为更好的使用这种循环和重用，所有的被 collection view 所用来展示的视图都必须从 UICollectionReusableView 类所扩展。  
Collection View 支持三种不同类型的重用视图，每种都有特定用途：  

* Cells（单元格）展示了你的 collection view 的主要内容。一个单元格的工作就是负责从你的数据源对象展示一个单一的元素。每个单元格都必须是UICollectionViewCell 类的实例，当然你可以根据需要继承来展示你的内容。单元格对象内置提供了管理它们本身被选中和高亮状态的支持。要想将一个高亮效果添加到一个单元格上，你必须自己编写代码。更多关于实现单元格高亮/选中的相关信息，参见“管理选中和高亮状态”。
* Supplementary views（辅助视图）负责展示关于一个段落的相关信息。像单元格一样，辅助视图也是数据驱动的。不过，辅助视图不像单元格一样被强制实现，它们的使用和放置的位置被布局对象所控制。比如，流式布局支持段头和段尾作为辅助视图的可选项。
* Decoration views（装饰视图）是被布局对象所管理的装饰效果，它不受限于你的数据源对象。举例来说，布局对象通常使用装饰视图来实现一个自定义背景展示。

与 table view 不同，collection view 不会给单元格强加任何特定样式，而辅助视图完全由你的数据源所提供。基本的重用视图类就像空白画板一样供你修改。比如，你可以使用它们来构建小的视图层级，展示图片，甚至可以动态的绘制内容。  
你的数据源对象负责提供与 collection view 相关的单元格和辅助视图。不过，数据源不需要直接创建视图，当有视图请求的时候，你的数据源需要使用collection view 提供的方法从视图队列中提供需要的视图类型即可。无论是从重用队列中检索还是使用一个你提供的类、或从 nib 文件或故事版来创建一个视图，取出的过程应当始终返回一个合法的视图。  
更多关于如何从你的数据源创建和配置视图的相关信息，参见“配置单元格和辅助视图”。

## 布局对象控制了界面展示

布局对象只负责决定 collection view 中的元素位置和样式。你的数据源对象提供了视图和实际内容，但它的大小、位置以及其他可见的属性都是由布局对象所决定的。这种分开负责的方式能够让你动态的改变布局，而无需改变任何你的应用程序所管理的数据对象。  
collection view 所使用的布局过程与应用程序的其他视图的布局相关，但有别于它。换句话说，不要混淆布局对象所做的与在父视图内重新定位子视图的 layoutSubviews 方法所做的。布局对象不会直接接触它所管理的视图，因为它实际上并不拥有任何视图。它会直接生成 collection view 中描述单元格、辅助视图和装饰视图的位置、尺寸和可视化的相关属性。随后 collection view 会将这些属性应用到实际的视图对象上。  
布局对象如何作用于一个 collection view 中的视图是没有限制的。布局对象可以移动一些视图中的一部分而其他部分不动。它还可以只移动视图一点点，或让它们沿屏幕随机移动。它甚至可以不用管周边的视图，只重新布局当中的视图。举例来说，布局对象能够让任意视图放置到视图栈的顶部。唯一真正的限制是布局对象如何影响你希望应用程序拥有的视觉样式。  
图1-2 展示了一个垂直滚动的流式布局是如何对其单元格和辅助视图进行排版的。在垂直滚动流式布局中，内容区域的宽度保持固定，高度随内容增大。为了估算区域，布局对象会一次将视图和单元格进行布局，为它们选择最合适的位置。在流式布局这种情况下，单元格和辅助视图的尺寸会被指定为属性，无论是通过布局对象还是使用代理。计算布局就是使用这些属性将每个视图放置的问题。  

图1-2 布局对象提供了布局相关的度量  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_basics_2x.png)

布局对象不止控制了视图的尺寸和位置。它还指定了其他视图相关的属性，比如透明度，在3D空间中的转换以及相对于其他视图之上或之下的可见性（如果有的话）。这些属性能够让你创建更多有趣的布局。比如，你可以通过将视图放在彼此的顶部并更改其Z轴的顺序来创建单元格堆栈，或者可以在任意轴向上使用转换来对他们进行旋转。  
更多关于布局对象是如何承担 collection view 的布局的相关信息，参见“创建自定义布局”。

## Collection View自动初始化了动画

Collection View 底层内建了动画的支持。当你插入（或删除）元素或段落的时候，collection view 会自动的通过动画来展示改变的视图。比如，当你插入一个元素的时候，元素会在插入点之后为新的元素腾出空间。collection view 能够构建动画是因为它能够监听元素当前的位置以及计算在插入后的最终位置。因此，它能够动画的展示每个元素从最初位置到最终位置。  
除了动画的展示插入、删除和移动操作外，你还能在任意时刻禁用布局并强制重新计算其布局属性。禁用布局不会直接动画展示元素；当你禁用布局的时候，collection view 会以非动画的方式展示它新计算好的位置的元素。而在自定义布局中，你可以使用此行为定期为单元格调整位置，并创建动画效果。

# 设计你的数据源和代理

每个 collection view 都要有一个数据源对象。数据源对象是你的应用程序所展示的内容。它可以是一个从你的应用程序数据模型中取到的对象，也可以是管理 collection view 的视图控制器。对于数据源的唯一要求是必须提供 collection view 所需的相关信息，比如有多少个元素需要显示以及当显示这些视图的时候应当使用哪个视图。  
代理对象是可选的（但推荐使用）对象，它管理着与内容的呈现和交互相关的各个方面。尽管代理的主要任务是管理单元格的高亮和选中，它也可以被扩展为提供额外的信息。比如，流式布局扩展了基本的代理行为来为布局进行定制化，比如单元格的尺寸和它们之间的距离。

## 数据源管理着你的内容

数据源对象是你在使用 collection view 来展示内容时管理内容的对象。数据源对象必须遵循 UICollectionViewDataSource 协议，协议定义了你必须支持的基本行为和方法。数据源的任务就是提供给 collection view 以下问题的答案：  

* collection view 要包含多少个段落？
* 对于一个给定的段落，这个段落要包含多少个元素？
* 对于一个给定的段落或元素，当展示相关内容时，应当使用哪个视图？

段落和元素是 collection view 内容组成的基本元素。一个 collection view 通常至少含有一个段落并很可能包含更多。每个段落依次包含零个或多个元素。元素代表着你要展示的主要内容，而段落将这些元素组织为逻辑上的一组。举例来说，一款照片类应用程序可能使用段落来代表一个单独的相片集合或在同一天中所拍摄的照片集合。  
collection view 查找它所包含的数据时使用 NSIndexPath 对象。当试图定位一个元素的时候，collection view 会使用布局对象提供的索引路径信息提供。对于元素而言，索引路径包含段落号和元素号。对于辅助视图和装饰视图，索引路径包含布局对象所提供的所有信息。辅助视图和装饰视图上的索引路径的意义取决于你的应用程序，尽管第一个索引位置对应数据源当中的特定段落。视图的索引路径更多的是识别性而非表面意义，识别哪个视图是什么类型的是当前需要考虑的。因此举例来说，如果你要使用辅助视图创建段头和段尾，如流式布局中所示，那么索引路径所提供的相关信息就是段落所引用的。  

	注意：尽管标准的索引路径支持多层级，但 collection view 的单元格仅支持两层深度的索引路径，即“段落”和“元素”参数，这个与 UITableView 类的索引路径类似。辅助视图和装饰视图可以根据需要拥有更复杂的索引路径。索引路径大于1的元素被解释为与路径中第一个索引指定的段落相对应。习惯上只需要二级索引，不过辅助视图和装饰视图不受限制。在设计你的数据源时要记住这点。

不论你如何排列数据对象的段落和元素，这些段落和元素的视觉效果依旧由布局对象所决定。不同的布局对象能够展示不同的段落和元素数据，如图2-1所示。在该图中，流式布局对象将垂直段落设计为每个连续段落在之前一个段落之后。自定义布局能够将段落排版为非线性布局，布局的显示与实际数据相分离。  

图2-1 段落的排版根据布局对象的布局所排列  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_sections_2x.png)

### 设计你的数据对象

一个高效的数据源会使用段和元素来帮助组织其基本的数据对象。将你的数据组织成段落和元素将使得实现数据源的方法更为简单。由于数据源的方法经常被调用，你要确保这些方法的实现能够尽可能快的检索数据。  
一种简单的解决方案（当然不是唯一的解决方案）是数据源使用一组嵌套的数组，如图2-2所示。在这种配置下，顶层的数组包含一个或多个代表你的数据源的段落的数组。每个段落的数组又包含该段落的数组元素。在段落中查找元素就变成了查找到该段落的数组然后从该数组查找元素的过程。这种配置能够适当的组织元素的集合以及根据需要检索特定的元素。  

图2-2 使用嵌套数组来管理数据对象  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/ds_data_object_layout_2x.png)  

当设计你的数据结构的时候，你可以从一个简单的数组集合开始，然后根据需要转换到一个更高效的结构上。一般来讲，你的数据对象应当不应该有性能瓶颈。Collection view 访问你的数据源只是为了计算总共有多少个对象，以及为当前屏幕上的元素获取视图。若布局对象只依赖你的数据对象的数据的话，那么当数据源包含上千个对象时，性能将会被严重降低。

### 将你的内容告知 collection view

Collection view 询问你的数据源的问题包括它包含多少段以及每段包含多少项元素。当以下情况发生时，collection view 会要求你的数据源提供信息：  

* collection view 首次展示的时候。
* 你将一个不同的数据源对象赋值给 collection view 时。
* 你显式的调用 collection view 的 reloadData 方法时。
* collection view 的代理使用 performBatchUpdates:completion: 执行 block 或有任何移动、插入或删除的方法执行时。

使用 numberOfSectionsInCollectionView: 方法来提供段落数，使用 collectionView:numberOfItemsInSection: 方法来提供每个段落的项目数。你必须实现 collectionView:numberOfItemsInSection: 方法，不过如果你的 collection view 只有一个段落的话，是否实现 numberOfSectionsInCollectionView: 方法是可选的。两个方法都是通过整形值返回相应的信息。  
如果你如 图2-2 那样实现你的数据源的话，你的数据源方法的实现可以如 清单2-1 那样简单。在这份代码中，_data 变量是一个数据源的自定义成员变量，它存储了顶层段落的数组。通过获取该数组的数量能够得到段落数。通过获取每个子数组的数量能够获取该段落的项目数。（当然，你自己的代码要根据需要检测各种错误来确保返回值有效。）  

清单2-1 提供段落和项目数  

	- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
   		 return [_data count];
	}
 
	- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
   		 NSArray* sectionArray = [_data objectAtIndex:section];
	   	 return [sectionArray count];
	}

## 配置cell和辅助视图

另一个你的数据源要做的重要工作是提供 collection view 要使用的展示你的内容的视图。collection view 不会监听你的应用程序的内容。它只会直接使用你给予它的视图并将当前布局信息应用于它。所以，所有需要通过视图展现的内容都需要你来负责。  
在从你的数据源获取到有多少段落和元素在被管理后，collection view 会要求布局对象提供 collection view 的内容所需的布局属性。在某个时机，collection view 会要求布局对象提供一组元素到一个特定矩形区域（通常是可见的矩形区域）。collection view 会使用该组元素来要求你的数据源提供相应的单元格和辅助视图。要提供这些单元格和辅助视图，你的代码必须做到以下几点：  

1. 将你的模板单元格和视图嵌入到你的故事版文件中。（或者为每种支持的单元格或视图注册一个类或 nib 文件）
2. 在你的数据源中，当被要求时，从队列中取出并配置合适的单元格或视图。

为确保单元格和辅助视图以最高效的方式被利用，collection view 承担了为你创建这些对象的责任。每个 collection view 都会维护一个当前没有被使用的单元格和辅助视图的内部队列。你无需自己创建对象，只需要直接要求 collection view 提供给你想要的视图即可。如果重用队列中有等待被重用的视图，collection view 会立即将其准备好并返回给你。若没有等待被重用的视图，collection view 会使用注册的类或nib文件来创建一个新的视图并返回给你。因此，每次你从队列中取出一个单元格或视图，你都会得到一个已经准备好被使用的对象。  
重用标识符使得可以注册多种不同类型的单元格和辅助视图。重用标识符是一个你用来区分注册的单元格和视图类型的字符串。该字符串的内容只与你的数据源对象相关。但当被要求提供视图或单元格时，你可以使用提供的索引路径来决定你可能需要的视图或单元格类型，然后传递相应的重用标识符给出列方法。

### 注册cell和辅助视图

你可以通过代码的方式或故事版的方式来配置你的 collection view 的单元格和视图。  
**通过故事版来配置单元格和视图。** 当在故事版中配置单元格和视图时，你可以通过拖拽相应的 item 到你的 collection view 并配置它来做到。这会在 collection view 和相应的单元格和视图之间创建一组联系。  

* 对于单元格。从对象库中拖拽一个 Collection View Cell 到你的 collection view 中。给你的单元格设置自定义类和重用标识符以适当的值。
* 对于辅助视图。从对象库中拖拽 Collection Reusable View 到你的 collection view 中。然后设置自定义类和重用标识符以适当的值。

**通过代码配置单元格。** 使用 registerClass:forCellWithReuseIdentifier: 或 registerNib:forCellWithReuseIdentifier: 方法来关联你的单元格和重用标识符。你可以在父视图控制器的初始化过程中调用该方法。  
**通过代码配置辅助视图。** 使用 registerClass:forSupplementaryViewOfKind:withReuseIdentifier: 或  registerNib:forSupplementaryViewOfKind:withReuseIdentifier: 方法来关联每种类型的视图和重用标识符。你可以在父视图控制器的初始化过程中调用该方法。  
在注册单元格的时候只需要一个重用标识符，不过在注册辅助视图时会额外要求你提供一个“类型”字符串。每种布局对象要负责定义它所支持的辅助视图的类型。比如，UICollectionViewFlowLayout 类支持两种类型的辅助视图：段头视图和段尾视图。为区分这两种类型的视图，它定义了字符串常量 UICollectionElementKindSectionHeader 和 UICollectionElementKindSectionFooter。在布局期间，布局对象包含具有该视图类型的其他布局属性的类型字符串。collection view 会通过你的数据源传递信息。你的数据源可以使用两种类型的字符串和重用标识符来决定哪个视图对象应该出列以及返回。  

	注意：若你实现了自定义的布局，你要负责定义你的布局所支持的辅助视图的类型。布局可能支持任意数量的辅助视图，每种都有其自己的类型字符串。更多关于定义自定义布局的相关信息，参见“创建自定义布局”。

注册是一个一次性的事件，它必须放置在你试图出列单元格或视图之前。在你注册之后，你可以根据需要出列任意数量的单元格或视图而无需再注册。我们不推荐你在出列一个或多个元素后再更改注册信息。最好是先注册单元格和视图然后再进行处理。

### 从队列取出和配置cell和视图

当 collection view 要求时，你的数据源对象应当负责提供单元格和辅助视图。UICollectionViewDataSource 协议为这两个目的提供了两个方法：collectionView:cellForItemAtIndexPath: 和 collectionView:viewForSupplementaryElementOfKind:atIndexPath:。由于单元格是 collection view 必须的元素，你的数据源必须实现 collectionView:cellForItemAtIndexPath: 方法，但 collectionView:viewForSupplementaryElementOfKind:atIndexPath: 方法是可选的，并且依赖于布局所使用的类型。不论哪种情况，在实现这些方法时都应遵循一个简单模式：  

1. 使用dequeueReusableCellWithReuseIdentifier:forIndexPath: 或 dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath: 方法出列一个适当类型的单元格或视图。
2. 在指定索引路径使用数据配置视图。
3. 返回视图。

出列的过程被设计为依赖于你创建单元格或视图的过程。只要你提前注册了单元格或视图，出列方法就能够保证永不返回 nil。若在重用队列中没有给定的类型的单元格或视图的话，出列方法会直接使用你的故事版或你在注册时使用的类或 nib 文件来创建一个。  
从出列过程中返回给你的单元格应当为原始状态，并应做好配置新数据的准备。对于必须创建的单元格或视图来说，出列过程会使用正常的过程对其进行创建和初始化——意思就是通过从一个故事版或 nib 文件或创建一个新的实例以及使用 initWithFrame: 方法对其进行初始化来加载视图。相反的，一个不是从这个过程中创建的单元，而是从重用队列中取出的单元很可能包含之前使用的数据的状态。在这种情况下，重用方法会调用 prepareForReuse 方法来给予单元格以时机来将其本身恢复至原始状态。当你实现一个自定义单元格或视图类时，你可以通过重写该方法来将属性重置为默认值以及执行一些额外的清理工作。  
当你的数据源出列一个视图之后，它会使用新的数据配置视图。你可以使用索引路径来传递给你的数据源方法，以便定位到适当的数据对象，然后将其应用在视图上。在你配置视图之后，从你的方法中将其返回，你的工作就结束了。清单2-2 展示了一个如何配置单元格的简单例子。在单元格出列后，方法使用单元格的位置信息设置了单元格的自定义 label，然后将其返回。

清单2-2 配置自定义单元格  

	- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
		   MyCustomCell* newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:MyCellID
                                                                          forIndexPath:indexPath];
 
	   newCell.cellLabel.text = [NSString stringWithFormat:@"Section:%d, Item:%d", indexPath.section, indexPath.item];
   		return newCell;
	}
		
```
注意：当从你的数据源中返回视图时，应始终返回有效视图。即使是出于某种原因被要求的视图不会被显示，而返回了nil，这将会触发断言，你的应用程序将会终止，因为布局对象需要这些方法返回有效的视图。
```

## 插入，删除和移动段落和单元格

要插入，删除或移动一个段落或元素，请遵循以下步骤：  

1. 更新数据源对象的数据
2. 调用 collection view 的相应方法来插入或删除段落或元素。

在你更新完你的数据，通知 collection view 改变之前的时间点。collection view 会假设你的数据源包含正确的数据。如果不是这样的话，collection view 可能会从你的数据源接收到错误的数据集合或请求不存在的元素，从而让你的应用程序崩溃。  
当你通过编码的方式添加，删除或移动一个单元格的时候，collection view 的方法会自动的为这些改变创建动画。不过，若你想要一起展示动画效果的话，你必须将所有的插入，删除或移动的调用放入一个 block 中，然后将其传递给 performBatchUpdates:completion: 方法。批量更新的过程会随后以动画的形式同时展示所有的变更，你可以自由的将插入，删除或移动的调用放入同一个block中。  
清单2-3 展示了如何执行一组批量更新来删除当前选中的元素的简单例子。传递给 performBatchUpdates:completion: 方法的 block 首先调用自定义方法来更新数据源。然后告知 collection view 来删除元素。更新 block 和你提供的 completion block 都会被同步执行。  

清单2-3 删除选中的元素  

	[self.collectionView performBatchUpdates:^{
	   NSArray* itemPaths = [self.collectionView indexPathsForSelectedItems];
 
	   // Delete the items from the data source.
	   [self deleteItemsFromDataSourceAtIndexPaths:itemPaths];
 
	   // Now delete the items from the collection view.
	   [self.collectionView deleteItemsAtIndexPaths:itemPaths];
	} completion:nil];

## 管理选中和高亮的状态
Collection view 默认支持单一元素的可选，并可以配置为支持多个元素的可选或禁用可选。Collection view 会监听它区域内的触摸事件，然后高亮或选中相应的单元格。大部分情况下，Collection view 会只修改一个单元格的属性来表示它被选中或高亮；它不会改变多个单元格的展现状态，不过有一个例外。若一个单元格的 selectedBackgroundView 属性包含一个有效视图的话，collection view 会在单元格被高亮或选中时展示该视图。  

清单2-4 设置背景视图来表示状态变更  

	UIView* backgroundView = [[UIView alloc] initWithFrame:self.bounds];
	backgroundView.backgroundColor = [UIColor redColor];
	self.backgroundView = backgroundView;
 
	UIView* selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
	selectedBGView.backgroundColor = [UIColor whiteColor];
	self.selectedBackgroundView = selectedBGView;

collection view 的代理为collection view提供了以下方法来实现高亮和选中：  

* collectionView:shouldSelectItemAtIndexPath:
* collectionView:shouldDeselectItemAtIndexPath:
* collectionView:didSelectItemAtIndexPath:
* collectionView:didDeselectItemAtIndexPath:
* collectionView:shouldHighlightItemAtIndexPath:
* collectionView:didHighlightItemAtIndexPath:
* collectionView:didUnhighlightItemAtIndexPath:

这些方法给予你各种时机来改变collection view的高亮/选中行为达到想要的效果。  
举个例子，如果你更倾向于自己绘制单元格的选中状态，你可以将 selectedBackgroundView 属性设置为 nil，然后使用你的代理对象将可视化变化应用于单元格。你可以在 collectionView:didSelectItemAtIndexPath: 方法中应用可见变化，在 collectionView:didDeselectItemAtIndexPath: 方法中将其移除。  
如果你更倾向于自己绘制高亮状态，你可以重写 collectionView:didHighlightItemAtIndexPath: 和  collectionView:didUnhighlightItemAtIndexPath: 代理方法，使用它们来应用在你的高亮中。若你同样指定了视图给 selectedBackgroundView 属性，你应该将你的变更应用于单元格的内容视图以确保你的变更是可见的。清单2-5 展示了使用内容视图的背景色来改变高亮的简单方式。  

清单2-5 将一个临时高亮赋值给单元格  

	- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   		 UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
	   	 cell.contentView.backgroundColor = [UIColor blueColor];
	}
 
	- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   		 UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
	    cell.contentView.backgroundColor = nil;
	}

单元格的高亮状态和选中状态有一个微小但重要的区别。高亮状态是一个过渡状态，你可以在用户的手指还在触摸设备时将可见的高亮应用于单元格。只有当 collection view 在跟踪单元格的触摸时，该状态才能被设置为 YES。当触摸事件停止后，高亮状态会返回值 NO。相反的，选中状态只会在一系列的触摸事件终止后才会改变——尤其是当这些触摸事件表示用户想要选中单元格时。  
图2-3 展示了当用户触摸一个未选中的单元格时发生的一系列步骤。初始的按下事件会引发 collection view 改变单元格的高亮状态为 YES，不过这么做不会自动的改变单元格的展示效果。若最终的抬起事件也发生在单元格中的话，高亮状态会返回 NO，collection view 会改变选中状态为 YES。当用户改变选中状态时，collection view 会显示单元格中的 selectedBackgroundView 属性，不过这是 collection view 唯一作用于单元格的可见改变。其他的可见变化必须由你的代理对象实现。

图2-3 跟踪单元格的触摸事件  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cell_selection_semantics_2x.png)

无论用户选中还是不选中一个单元格，单元格的选中状态都是最后才改变的。单元格的触摸总是首先引起单元格高亮状态的更改。只有在触摸顺序结束后并且高亮状态在该顺序结束后作用于单元格后，才会引起单元格选中状态的变更。当你设计单元格时，你应当确保你的单元格的高亮和选中状态的可见效果不要冲突。

## 展示单元格的编辑菜单

当用户在单元格上执行长按操作时，collection view 会展示一个编辑菜单给该单元格。编辑菜单可以用来裁剪，拷贝和粘贴 collection view 中的单元格。在编辑菜单展示之前可能会遇到几种情况：  

* 代理必须实现所有关于处理动作事件的三个方法：  

	collectionView:shouldShowMenuForItemAtIndexPath:

	collectionView:canPerformAction:forItemAtIndexPath:withSender:

	collectionView:performAction:forItemAtIndexPath:withSender:
* 对于显示的单元格，collectionView:shouldShowMenuForItemAtIndexPath: 方法必须返回YES。
* collectionView:canPerformAction:forItemAtIndexPath:withSender: 方法对于需要的动作处理当的至少一个要必须返回 YES。collection view 支持以下动作：  
	 cut:  
	 
	 copy: 
	 
	 paste:

若条件都满足，并且用户从菜单中选择了一个动作，collection view 会调用代理的 collectionView:performAction:forItemAtIndexPath:withSender: 方法来执行展示的动作。  
清单2-6 展示了如何隐藏菜单的一个元素。在该例中，collectionView:canPerformAction:forItemAtIndexPath:withSender: 方法将裁剪元素从编辑菜单中隐去了。它允许粘贴和拷贝元素，以便用户能够插入内容。  

清单2-6 有选择的隐藏编辑菜单的动作  
	
	- (BOOL)collectionView:(UICollectionView *)collectionView
        canPerformAction:(SEL)action
        forItemAtIndexPath:(NSIndexPath *)indexPath
        withSender:(id)sender {
		   // Support only copying and pasting of cells.
		   if ([NSStringFromSelector(action) isEqualToString:@"copy:"]
		      || [NSStringFromSelector(action) isEqualToString:@"paste:"])
		      return YES;
 
		   // Prevent all other actions.
		   return NO;
	}

更多关于作用于剪切板命令的相关信息，参见“iOS文本编辑指南”。

## 在布局之间进行转换

最简单的在布局之间进行转换的方式是使用 setCollectionViewLayout:animated: 方法。不过，如果你对于转换过程需要更多的控制或者希望可交互的话，请使用 UICollectionViewTransitionLayout 对象。  
UICollectionViewTransitionLayout 类是一种特殊类型的布局，它在转换到一个新的布局时会作为 collection view 的布局对象。通过转换布局对象，你可以将对象以非线性布局，使用不同的时间算法，或根据触摸事件进行移动。标准类提供线性转换到新的布局，不过，与 UICollectionViewLayout 类相同，UICollectionViewTransitionLayout 类可以被子类化来创建任意需要的效果。如果这么做的话，你需要实现同样的方法来创建自定义布局，并能够让你的实现适应用户的输入，一般来说是手势输入。关于如何创建自定义不对象的更多信息，参见“创建自定义布局”。  
UICollectionViewLayout 类提供了几个方法来跟踪布局切换之间的事件。UICollectionViewTransitionLayout 对象会通过 transitionProgress 属性来跟踪切换的完成状态。在切换发生时，你的代码应定时更新该属性来展示切换的进程。举例来说，使用 UICollectionViewTransitionLayout 类时可以结合手势对象一起使用，你可以用来在布局切换中使用，也能够让你创建可交互的切换。同时，如果你实现了自定义切换布局对象的话，UICollectionViewTransitionLayout 类提供了两个方法来跟踪你的布局相关的值：updateValue:forAnimatedKey:  和 valueForAnimatedKey: 方法。这两个方法会跟踪你在切换的过程中与布局沟通的重要信息的设置和变更的浮点值。举例来说，若你使用捏合手势来切换布局的话，你可以使用这两个方法来告知转换的布局对象该在什么位置将视图的位移从一个转到另一个。  
在你的应用程序中包含 UICollectionViewTransitionLayout 对象有以下步骤：  

1. 使用 initWithCurrentLayout:nextLayout: 方法创建标准类的实例对象或你自己的自定义类。
2. 通过定时修改 transitionProgress 属性来沟通切换的过程。不要忘记在改变切换过程之后使用 collection view 的 invalidateLayout 方法来禁用布局。
3. 实现你的 collection view 的代理方法 collectionView:transitionLayoutForOldLayout:newLayout: 返回切换的布局对象。
4. 可选用 updateValue:forAnimatedKey: 方法来修改你的布局的值来展示关于你的布局对象的值的变化。在这种情况下，该值为0。

# 使用布局

你可以在你的 collection view 中使用固定的布局对象来对元素进行排版，即 UICollectionViewFlowLayout 类。流式布局实现了一种基于行的中断式布局，意思是布局对象将单元格以行为基线布局，一行能放多少单元格就放多少。当当前行没有空间留给布局对象时，会创建一个新行继续布局过程。图3-1 展示了垂直滚动的流式布局的样子。在这种情况下，每行都在之前行之后水平布局。在一个段落中的单元格能够被段头和段尾视图随意包裹。  

图3-1 使用流式布局对段和单元格进行布局  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_horiz_headers_2x.png)

你可以使用流式布局来实现网格，但你可以用它做的更多。线性布局的概念可以应用到很多不同的设计上。举例来说，你可以沿着滚动方向创建单行元素并调整间距，而非网格化的布局元素。单元格也能够拥有不同的尺寸，这会与传统的网格式不同，它会有更多的不对称性，但它仍然是线性布局。可能性很多。  
你可以通过编码的方式，也可以通过 Xcode 中的界面编辑器来配置流式布局。配置流式布局的步骤如下：  

1. 创建流式布局对象将其赋值给你的 collection view。
2. 配置单元格的宽高。
3. 根据需要设置行间距和单元格之间的间距。
4. 若你想要段头或段尾，设置它们的尺寸。
5. 设置布局的滚动方向。

```
重要：你至少要指定单元格的宽高。若你不指定，你的单元格的宽高将被设置为0，并且不可用。
```
## 自定义流式布局属性
流式布局对象会暴露几个属性来配置你的内容的展示。当设置这些属性时，这些属性将会被应用到布局的所有元素上。比如，使用流式布局对象的 itemSize 属性设置单元格的尺寸会让所有的单元格拥有同样的尺寸。  
如果你想动态的改变单元格的间距或大小，你可以使用 UICollectionViewDelegateFlowLayout 协议的方法。你需要在赋值给 collection view 的代理对象的位置实现这些方法。若给定的方法存在，流式布局对象会调用该方法而非使用固定的值。你可以通过该方法返回 collection view 中所有元素的适当的值。
### 在流式布局中指定元素的尺寸
若在 collection view 中的所有元素都是相同的尺寸，赋值给流式布局对象的 itemSize 属性以相应的宽高值即可。（以像素点设定元素的尺寸。）这是为内容不可变的元素设置布局对象的最快方式。  
若你想为你的单元格设定不同的尺寸，你必须实现 collection view 代理中的 collectionView:layout:sizeForItemAtIndexPath: 方法。你可以使用提供的索引路径信息来返回相应元素的尺寸。在布局期间，流式布局对象会将元素集中于同一垂直线上，如图3-2 所示。该行的高或宽最终由该方向的最大元素所决定。  

图3-2 流式布局中的不同尺寸的元素  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_horiz_layout_uneven_2x.png)

```
注意：当你指定单元格的不同尺寸时，单行元素的个数可以与其他行不同。
```
### 指定元素之间的间距和行间距

使用流式布局，你可以指定同一行元素之间的最小间距以及相连行之间的最小间距。要注意，你提供的间距仅仅是最小间距。由于流式布局对象的布局内容的方式，在布局时可能会远大于你所指定的元素之间的距离。布局对象可能在元素布局后为不同尺寸时直接增加实际的行间距。  
在布局时，流式布局对象会持续给当前行添加元素，直到没有足够的空间留给一个整个的元素。若该行足够容纳一个整数数量的元素而没有额外的空间的话，那么元素之间的空间将会等于最小间距。若在行尾还有额外控件，布局对象会增加元素之间的间距直到元素能够均匀的分布在一行之内，如图3-3 所示。增加间距会改变整体元素的效果，并防止每行末尾有较大的空隙。  

图3-3 元素之间实际的间距可能远比最小间距要大  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_item_spacing_2x.png)

对于行间距，流式布局对象会使用元素间距相同的技术。若所有的元素是相同大小，流式布局会使用行间距值的最小值并且一行中的所有元素都与下一行中的元素平均间隔。若元素尺寸不同，那么每个单独元素之间的实际距离是可变的。  
图3-4 展示了当元素为不同尺寸时，行间距为最小值的情况。由于元素尺寸不同，流式布局对象会选取每行中滚动方向上最大的元素。举例来说，在垂直滚动布局下，它会查找每行最高的元素。然后将这些元素之间的距离设置给最小值。若元素在一行的不同部分，如图所示，实际上的行间距将会比最小行间距看起来大的多。  

图3-4 若元素尺寸不同行间距可变  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_line_spacing_2x.png)

通过流式布局的属性，你可以使用固定间距值或动态间距值。行间距和元素之间的间距被基于段来处理。因此，行间距和元素间距在给定的段落中对于所有的元素而言相同，但不同的段落可能不同。你可以使用流式布局对象的 minimumLineSpacing 和 minimumInteritemSpacing 属性设置静态间距，或者使用 collection view 的 collectionView:layout:minimumLineSpacingForSectionAtIndex: 和 collectionView:layout:minimumInteritemSpacingForSectionAtIndex: 方法来设置。  

### 使用段落内边距来拉伸你的内容的边距

段落内边距可以作为调整布局单元格间距的一种方式。你可以使用内边距来在段头视图之后和段尾视图之前插入空间。你也可以使用内边距来在内容的四边来插入空间。图3-5展示了在一个垂直滚动流式布局中内边距是如何影响一些内容的效果。  

图3-5 段落内边距改变了布局单元格的可用间距  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_section_insets_2x.png)  

由于内边距减少了布局单元格的可用间距，你可以用它来限制一行的单元格的数量。在不滚动的方向设定内边距是一种压缩每行间距的方法。若你将该信息与适当的单元格大小所结合，你就能控制每行单元格的数量。

## 要知道何时该子类化流式布局

虽然使用流式布局无需子类化就能够高效的使用，有时候你还是需要将其子类化以便获取你需要的行为。列表3-1 列出了实现所需要的效果所必须的一些继承 UICollectionViewFlowLayout 的方案。  

列表3-1 继承 UICollectionViewFlowLayout 的一些情境  

情境  | 继承的一些提示
------------- | -------------
 你要添加新的辅助视图或装饰视图到你的布局中 | 标准的流式布局类只支持段头段尾视图，不支持装饰视图。想要支持额外的辅助视图和装饰视图，你需要至少重写以下方法：layoutAttributesForElementsInRect: (必须) layoutAttributesForItemAtIndexPath: (必须)  layoutAttributesForSupplementaryViewOfKind:atIndexPath: (支持新的辅助视图) layoutAttributesForDecorationViewOfKind:atIndexPath: (支持新的装饰视图) 在 layoutAttributesForElementsInRect: 方法中，你可以调用super来获取单元格的布局属性，然后将属性添加到任意指定的矩形区域的新的辅助视图或装饰视图中。使用其他方法来根据需要提供属性。更多关于在布局期间为视图提供属性的相关信息，参见“创建布局属性”以及“在给定矩形区域为元素提供布局属性”。
 你要调整流式布局返回的布局属性 | 重写 layoutAttributesForElementsInRect: 方法，然后将布局属性返回。在实现该方法时应当调用super，修改由父类提供的属性，然后将其返回。关于深度探讨这些方法所承担的工作，参见“创建布局属性”和“在给定矩形区域为单元格提供布局属性”。
 你要为你的单元格和视图添加新的布局属性 | 创建 UICollectionViewLayoutAttributes 的自定义子类并添加你需要的属性代表你的自定义布局信息。子类化 UICollectionViewFlowLayout 并重写 layoutAttributesClass 方法。在你的该方法实现中返回你的自定义子类。你还应该重写 layoutAttributesForElementsInRect: 方法，layoutAttributesForItemAtIndexPath: 方法，以及其他的返回布局属性的方法。在你的自定义实现中，你应当为你定义的自定义属性设置值。
 你要为插入或删除的单元格指定初始或最终位置 | 默认的，在单元格被插入或删除时会有一个简单的淡出动画。若要创建自定义动画，你必须重写部分或所有以下方法：initialLayoutAttributesForAppearingItemAtIndexPath: initialLayoutAttributesForAppearingSupplementaryElementOfKind:atIndexPath: initialLayoutAttributesForAppearingDecorationElementOfKind:atIndexPath: finalLayoutAttributesForDisappearingItemAtIndexPath: finalLayoutAttributesForDisappearingSupplementaryElementOfKind:atIndexPath: finalLayoutAttributesForDisappearingDecorationElementOfKind:atIndexPath: 在你的这些方法的实现中，要设定你需要的属性给插入或移除的视图。流式布局对象会使用你提供的属性来动画的展示插入和删除。若你重写这些方法，我们推荐你也重写 prepareForCollectionViewUpdates: 和 finalizeCollectionViewUpdates 方法。你可以使用这两个方法来跟踪在当前循环中是哪些单元格被插入和删除了。更多关于插入和删除是如何工作的，参见“让插入和删除的动画更有趣”。

还有一些实例中，正确的做法是从头开始创建自定义布局。在你决定这么做之前，花时间考虑一下这么做是否确实必要。流式布局提供了为适配多种不同的布局多种可定制的行为，它很容易使用，并且包含了大量的优化使得其更加高效。不过，这么说并不意味着你不应该创建自定义布局，因为某些情况下，这么做是有意义的。流式布局限定了滚动方向是单一的，所以如果你的布局包含的内容超出了屏幕在两个方向上的界限，那么这时就有必要实现自定义布局了。如上所述，如果你的布局不是网格或换行的布局的话，或者如果你的布局中的元素频繁的移动，而子类化流式布局比你自己创建的布局要复杂的话，那么创建自定义布局就是一个正确的决定。
更多关于创建自定义布局，参见“创建自定义布局”。

# 接入手势支持

你可以通过使用手势识别来给你的 collection view 添加大量的交互。给 collection view 添加手势识别，当手势发生时使用它来触发事件。对于 collection view，有两种事件你可能需要实现：  

* 你需要触发 collection view 布局信息的改变事件。
* 你需要直接操作单元格和视图。

你应当将手势识别添加到 collection view 上——而非一个特定的单元格或视图上。UICollectionView 类扩展于 UIScrollView，所以将你的手势识别添加到 collection view 上不会干扰其他跟踪的手势。此外，由于 collection view 会存取你的数据源和你的布局对象，你仍然应该存取所有你需要操作的单元格和视图的相关信息。

## 使用手势修改布局信息

手势识别提供了一种简单的方式来动态的修改布局参数。举例来说，你可以使用捏合手势来改变自定义布局中单元格之间的距离。配置一个手势识别的过程是相对比较简单的。  

1. 创建手势识别。
2. 将手势识别添加到 collection view 上。
3. 使用手势识别的处理方法来更新布局参数以及禁用布局对象。

你可以使用 alloc/init 这种创建其他对象的过程来创建手势识别。在初始化期间，你需要指定目标对象和动作方法以供手势触发时调用。然后调用 collection view 的 addGestureRecognizer: 方法来将其添加到视图上。大部分的实际工作将会发生在你初始化时指定的方法中。  
清单4-1 展示了附加在 collection view 上的捏合手势调用方法的例子。在该例中，捏合所产生的数据被用来改变自定义布局的单元格之间的距离。布局对象实现了自定义的 updateSpreadDistance 方法，该方法会验证新的距离值然后将其存储，用在随后的布局过程中。动作方法随后会将布局设置为失效，然后强制其基于新的值更新单元格的位置。  

清单4-1 使用手势识别改变布局值  

	- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
	    if ([sender numberOfTouches] != 2)
   		     return;
 
	   // Get the pinch points.
	   CGPoint p1 = [sender locationOfTouch:0 inView:[self collectionView]];
	   CGPoint p2 = [sender locationOfTouch:1 inView:[self collectionView]];
 
	   // Compute the new spread distance.
	    CGFloat xd = p1.x - p2.x;
	    CGFloat yd = p1.y - p2.y;
	    CGFloat distance = sqrt(xd*xd + yd*yd);
 
	   // Update the custom layout parameter and invalidate.
	   MyCustomLayout* myLayout = (MyCustomLayout*)[[self collectionView] collectionViewLayout];
  		 [myLayout updateSpreadDistance:distance];
	   [myLayout invalidateLayout];
	}

更多关于创建手势识别以及将其添加到视图上的相关信息，参见“iOS事件处理指南”。

## 使用默认的手势行为

UICollectionView 类会监听单点触摸事件来初始化其高亮和选中的代理方法。若你想添加自定义触摸或长按手势到 collection view 上的话，要将你的手势识别的相关配置与 collection view 已经使用的值进行区分配置。举例来说，你可能要配置一个手势识别来只响应双击事件。  
清单4-2 你如何让 collection view 响应你的手势而非单元格的选中/高亮。由于 collection view 不会使用手势识别来初始化其代理方法，你的自定义手势识别可以通过延迟注册其他触摸事件（通过设置你的手势识别的 delaysTouchesBegan 属性为YES）或者通过取消触摸事件）（通过设置你的手势识别的 cancelsTouchesInView 属性为YES）来让你的自定义手势识别拥有比默认的选中监听更高的优先级。当一个触摸事件注册后，它首先会检测看你的手势识别是否有优先权。若输入对于你的手势识别非法，代理方法将会按照正常情况被调用。  

清单4-2 优先考虑你的手势识别

	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
	tapGesture.delaysTouchesBegan = YES;
	tapGesture.numberOfTapsRequired = 2;
	[self.collectionView addGestureRecognizer:tapGesture];

## 操作单元格和视图

你如何使用手势识别来操作单元格和视图是取决于你要操作的类型。简单的插入和删除能够被放置在标准手势识别中的事件方法中执行。但如果你打算做更复杂的操作，你可能需要定义自定义手势识别来跟踪你自己的触摸事件了。  
一种类型的操作是需要一个自定义手势识别来将一个移动单元格从你的 collection view 中的一个位置移动到另一个位置。最直接的移动一个单元格的方式是从 collection view 中删除它（临时的），使用手势识别来在该单元格的可见周围拖拽，然后在触摸事件结束时将该单元格插入新的位置。所有这些都需要你自行控制触摸事件，与布局对象合作来决定新的插入位置，操作数据源的改变，然后将新的单元格插入到新的位置。  
更多关于创建自定义手势的相关信息，参见“iOS事件处理指南”。

# 创建自定义布局

在你开始构建自定义布局之前，要考虑下这是否真的必要。UICollectionViewFlowLayout 类提供了多种有效的功能并且已经对于效率进行了优化，以及适配了多种不同标准布局。为数不多的需要考虑实现一个自定义布局是如下几种情况：  

* 你的布局看上去不是网格或换行类的布局（一种将单元格放置到一行直到放满的布局，然后换行将单元格继续放置）或需要在不同方向上滚动。
* 你需要频繁的改变所有单元格的位置，以便修改现有的流式布局比创建自定义布局更有效率。

好消息是，从暴露的 API 来看，实现一个自定义布局并不困难。最难的部分是执行计算布局中单元格的位置。当你知道了这些单元格的位置之后，将这些信息直接提供给 collection view 就可以了。

## 继承 UICollectionViewLayout

要自定义布局，你需要继承 UICollectionViewLayout类，它将为你的设计提供一个新的起点。在你的实现体中，只需要少数的几个方法来为你的布局对象提供核心行为。其他的方法是让你用来根据需要重写修改布局行为的。核心方法处理以下重要工作：  

* 指定可滚动内容区域的大小
* 为单元格和视图提供属性对象以便 collection view 放置每个单元格和视图。

尽管你可以创建一个功能性的实现核心方法的布局对象，不过你要是也实现一些可选的方法，你的布局将会更有吸引力。  
布局对象使用数据源提供的信息来创建 collection view 的布局。你的布局需要通过调用 collectionView 属性来与数据源进行沟通，该属性在所有的布局方法中均可访问。要知道在布局过程中，你的 collection view 知道什么，不知道什么。由于布局过程是在底层进行的，collection view 不能够跟踪布局或视图的位置。所以即使是布局对象也不能限制你调用任何 collection view 的方法，也不要依赖 collection view 来计算布局所需的数据以外的任何内容。

### 理解核心布局过程

Collection view 会直接与你的自定义布局对象合作来管理整体的布局过程。当 collection view 判断需要布局信息时，它会要求你的布局对象提供的。举例来说，collection view 会在第一次展示或其调整尺寸的时候要求提供布局信息。你也可以通过显式的调用布局对象的 invalidateLayout 方法来告诉 collection view 更新布局。该方法会抛弃已经存在的布局信息并强制布局对象生成新的布局信息。  

```
注意：要小心不要将布局对象的 invalidateLayout 方法和 collection view 的 reloadData 方法混淆。调用 invalidateLayout 方法不会必定引起 collection view 抛弃其已经存在的单元格和子视图。当然，在移动或和添加或删除元素时，它会强制布局对象重新计算所有需要的布局属性。若数据源中的数据改变了，reloadData 方法更为适当。不论你如何初始化一个布局的更新，实际的布局过程都是一样的。
```

在布局过程中，collection view 会调用你的布局对象的特定方法。这些方法会给予你机选单元格位置的时机以及提供给 collection view 所需的主要信息。其他方法也可能会被调用，但这些方法会以以下顺序在布局过程中一直被调用：  

* 使用 prepareLayout 方法执行需要提供的布局信息的预先计算。
* 使用 collectionViewContentSize 方法基于你的初始化计算返回整体区域的大小。
* 使用 layoutAttributesForElementsInRect: 方法返回特定矩形区域中单元格和视图的属性。

图5-1展示了你该如何利用之前的这些方法来创建你的布局信息。  

图5-1 布局你的自定义内容  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_process_2x.png)

prepareLayout 方法会给你机会来执行布局中单元格和视图的位置的计算。你至少应该在该方法中计算内容区域的整体大小，这就是你要在第二步中返回给  collection view 的。  
Collection view 会使用内容大小来对其滚动区域进行配置。举例来说，如果你计算的内容区域从横向和纵向都超过了当前设备的屏幕边界，scroll view会调整成在两个方向同时都能够滚动。与 UICollectionViewFlowLayout 不同，它不会默认调整布局区域在一个方向上滚动。  
在当前滚动位置，collection view 会调用你的 layoutAttributesForElementsInRect: 方法来询问在一个特定区域内的单元格和视图的属性，这可能和可见矩形区域相同，也可能不同。在返回该信息之后，核心布局过程实际上就完成了。  
在布局完成后，在你或者 collection view 禁用布局之前，单元格和视图的属性会维持不变。调用你的布局对象的 invalidateLayout 方法会让布局过程再次开始，从调用 prepareLayout 方法开始。collection view 会在滚动期间自动禁用你的布局。若用户滚动其内容区域，collection view 会调用布局对象的 shouldInvalidateLayoutForBoundsChange: 方法，若该方法返回YES的话，禁用布局。  

```
注意：要记住，调用 invalidateLayout 方法不会立即开始布局更新过程。该方法仅仅是将布局标记为数据改变了，并需要更新。在下一个视图更新循环中，collection view 会检测是否有布局改变了，并更新。实际上，你可以调用 invalidateLayout 连续多次，而不会立即触发布局更新。
```

### 创建布局属性

你布局的属性对象是 UICollectionViewLayoutAttributes 由类的实例负责。这些实例能够以多种不同的方法在你的应用中创建。当你的应用不处理上千个元素的时候，创建这些实例的同时准备布局就很正常了，因为布局信息能够被缓存并且引用，而非滚动的时候计算。如果计算所有的属性的代价超过在缓存到应用中的好处的话，则在请求属性时创建属性同样容易。  
无论如何，当创建 UICollectionViewLayoutAttributes 类的新的实例时，使用以下类方法之一：  

- layoutAttributesForCellWithIndexPath:
- layoutAttributesForSupplementaryViewOfKind:withIndexPath:
- layoutAttributesForDecorationViewOfKind:withIndexPath:

你必须使用基于正在展示的视图的类型来选择正确的类方法，因为 cv 会使用该信息来从数据源对象请求适当的视图类型。使用不正确的方法会导致 cv 在错误的位置创建错误的视图，并且你的布局也不会如期望那样得到展示。  
在创建每个属性对象之后，给相关的视图设置对应属性。最低限度的，设置视图在布局中的大小和位置。对于视图在布局中重叠的情况，给 zIndex 属性赋值来确保一个覆盖视图的固定顺序。其他属性能够让你控制可见或 cell、view的展示以及根据需要进行改变。如果标准属性类不能复合你的应用所需，你可以继承它进行扩展来存储其他关于每个视图的信息。当子类化一个布局属性的时候，就需要你实现 isEqual: 方法来比较你的自定义属性了，因为 cv 使用该方法来进行操作。  
更多关于布局属性的相关信息，参见《UICollectionViewLayoutAttributes 类参考》。

### 为布局做准备

在布局周期的开始，布局对象会在开始布局过程之前调用 prepareLayout。该方法是你计算稍后通知你布局的信息的机会。prepareLayout 方法不需要实现一个自定义布局，但它提供一个时机来初始化必须的计算。在该方法调用之后，你的布局必须有足够的信息来计算 cv 的内容大小，即下一步布局的过程。不过，。有关 prepareLayout 方法应该如何实现的示例，参见《为布局做准备》。

### 在给定矩形区域为单元格提供布局属性

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_visible_elements_2x.png)

### 按照请求提供布局属性

### 连接你的自定义布局

## 让你的自定义属性更有吸引力

### 通过辅助视图提升内容

### 在你的自定义布局中包含装饰视图

### 让插入和删除动画更有趣

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_insert_animations_2x.png)

### 提升你的布局的滚动体验

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_target_scroll_offset_2x.png)

## 实现自定义布局的一些建议

# 自定义布局举例

创建一个自定义的 CV 布局是一个简单并且直接的需求，但实现过程的细节可能会非常不同。你的布局必须给每个在你的 cv 中包含的视图提供布局属性对象。这些属性的创建顺序依赖于你的应用程序的本质。在一个 cv 中可能存在上千上万个元素，直接计算和缓存布局属性是一个耗时的过程，所以这让只在需要特定元素的时候才创建属性变得比较合理。对于拥有少量元素的应用，一次性的计算布局信息并将其缓存来在属性被请求的时候引用能够节省你的应用的大量的不需要的重新计算的时间。本章节中的示例属于第二种分类。
记住我们提供的示例代码并非创建一个自定义布局的最终方式。在你在你开始创建你的自定义布局之前，花时间来设计实现一个能够在大部分情况下让你的应用获得最佳性能的结构。有关自定义布局的过程的概念的概览，参见《创建自定义布局》一章。  
由于本章节以一种特殊的顺序展示了自定义布局的实现，。要查看这些信息，参见《cv 基础》和《设计你的数据源和代理》两章。

## 概念

这个可以运行的示例的目的是为了展示实现一个自定义布局，它演示了类似 图6-1 中的图表这种分层级的树形信息。示例提供了代码的截图，并配有代码的注释，并伴随着你达到的自定义化过程中的点。cv 的每个段落形成了一个树形机构中的一个层级节点：段落0只包含了一个 NSObject cell。段落1包含了所有的 NSObject 的子cell。段落2包含了所有这些子 cell 的子 cell，以此类推。每个 cell 都是一个自定义 cell，有一个 label 用于关联类名，cell 之间的联系是补充视图。由于链接视图类必须判断有多少个链接需要绘制，它需要访问我们数据源中的数据。所有实现这些链接作为补充视图而非装饰视图就变的合理了。

图 6-1 类层级  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/example_final_screen_2x.png)

## 初始化

创建一个自定义布局的第一步是子类 UICollectionViewLayout 类。这么做能过给你在构建一个自定义布局的时候提供必要的基础。  
对于本例，一个自定义的协议对于在布局和某个元素之间通信是很有必要的。如果一个特定元素的属性需要从数据源知道额外的信息，最好给自定义布局实现一个协议而非初始化一个链接给数据源。你最终的布局应该更加健壮和可充用；它不会附加在一个特定的数据源上，而是响应实现这个协议的任何对象。    
清单 6-1 展示了自定义布局头文件必须的代码。现在，任何实现 MyCustomProtocol 协议的类都能够利用自定义布局了，布局能够查询类所需要的信息。

清单 6-1 链接到自定义协议  

	@interface MyCustomLayout : UICollectionViewLayout
	@property (nonatomic, weak) id<MyCustomProtocol> customDataSource;
	@end

	@interface MyCustomLayout()

其次，由于 cv 的元素的数量将会管理的非常低，自定义布局会利用一个缓存系统来存储布局属性在准备布局和接收 cv 向其请求的时候存储的值生成的信息。清单 6-2 展示了我们布局的三个私有属性，将要维持以及 init 方法。layoutInformation 字典存储了所有在我们 cv 中的所有类型的视图的布局属性。maxNumRows 属性会跟踪有多少个行需要占据我们的树形结构中的最上列。insets 对象控制着 cell 和在设置视图和内容尺寸之间的间距。前两个属性值是在准备布局的时候就被设置了，insets 对象应该在使用 init 方法的时候被设置。在本例中，INSET_TOP, INSET_LEFT, INSET_BOTTOM, 和 INSET_RIGHT 指代你定义的参数的常量。  

清单 6-2 初始化变量

	@property (nonatomic) NSDictionary *layoutInformation;
	@property (nonatomic) NSInteger maxNumRows;
	@property (nonatomic) UIEdgeInsets insets;
	 
	@end
	 
	-(id)init {
	    if(self = [super init]) {
	        self.insets = UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, INSET_BOTTOM, INSET_RIGHT);
	    }
	    return self;
	}

自定义布局的最后一步是创建自定义布局属性。虽然这步并非必要，在本例中当 cell 被占据的时候，代码需要访问当前 cell 的孩子的索引路径一边能够调整孩子 cell 的位置来匹配它的父亲。所以子类化 UICollectionViewLayoutAttributes 来存储 cell 的孩子的数组来提供该信息。子类化 UICollectionViewLayoutAttributes，然后头文件添加如下代码：  

	@property (nonatomic) NSArray *children;

如同 UICollectionViewLayoutAttributes 类参考中所阐释的，子类化布局属性需要你重写继承的 isEqual: 方法（iOS 7 和之后的版本）。更多为何这么做的信息，参考《UICollectionViewLayoutAttributes 类参考》 。  
本例中的 isEqual: 的实现比较简单，因为只有一个领域需要比较——孩子数组的内容。如果布局属性对象的数组是匹配的，那么他们必须相等，因为孩子是属于一个类的。清单 6-3 展示了 isEqual: 方法的实现。  

清单 6-3 满足子类布局属性的需要  

	-(BOOL)isEqual:(id)object {
	    MyCustomAttributes *otherAttributes = (MyCustomAttributes *)object;
	    if ([self.children isEqualToArray:otherAttributes.children]) {
	        return [super isEqual:object];
	    }
	    return NO;
	}

记住给在自定义布局文件中的自定义布局属性包含头文件。  
在过程中的这个点，你已经开始使用你布置的基础来实现自定义布局的主要部分了。  

## 准备布局

现在，所有的必须元素都已经被初始化，你可以准备布局了。cv 在布局过程中首先会调用 prepareLayout 方法。在本例中，prepareLayout 方法被用来举例说明 cv 中的每个视图的所有的布局属性对象，然后缓存这些属性到你的 layoutInformation 字典里稍后使用。更多关于 prepareLayout 方法的信息，参见《准备布局》。

### 创建布局属性

实现 prepareLayout 方法的示例分为两部分。图 6-2 展示了方法第一部分的目标。代码迭代了每个 cell，如果 cell 有孩子，关联这些孩子给父亲 cell。如图所示，这个过程已经给每个 cell 都实现了，包括其他父亲 cell 的孩子 cell。  

图 6-2 链接父亲和孩子索引

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/layout_process_2x.png)

清单 6-4 展示了 prepareLayout 方法的第一部分实现。在代码的开始，两个可变的字典初始化规划来缓存机制的基础。首先，layoutInformation，是相当于 layoutInformation 属性的本地化。创建一个本地的可变拷贝让实例变量不可变，这在自定义布局的实现中是合理的，因为布局属性在 prepareLayout 方法运行结束的时候被修改。

### 存储布局属性

## 提供内容大小

## 提供布局属性

## 当请求时提供特定属性

	- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	    return self.layoutInfo[@"MyCellKind"][indexPath];
	}

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/example_mid_screen_2x.png)

## 接入辅助视图

	// create another dictionary to specifically house the attributes for the supplementary view
	NSMutableDictionary *supplementaryInfo = [NSMutableDictionary dictionary];
	…
	// within the initial pass over the data, create a set of attributes for the supplementary views as well
	UICollectionViewLayoutAttributes *supplementaryAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"ConnectionViewKind" withIndexPath:indexPath];
	[supplementaryInfo setObject: supplementaryAttributes forKey:indexPath];
	…
	// in the second pass over the data, set the frame for the supplementary views just as you did for the cells
	UICollectionViewLayoutAttributes *supplementaryAttributes = [supplementaryInfo objectForKey:indexPath];
	supplementaryAttributes.frame = [self frameForSupplementaryViewOfKind:@"ConnectionViewKind" AtIndexPath:indexPath];
	[supplementaryInfo setObject:supplementaryAttributes ForKey:indexPath];
	...
	// before setting the instance version of _layoutInformation, insert the local supplementaryInfo dictionary into the local layoutInformation dictionary
	[layoutInformation setObject:supplementaryInfo forKey:@"ConnectionViewKind"];

清单 6-10 按要求提供辅助视图属性

	- (UICollectionViewLayoutAttributes *) layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	    return self.layoutInfo[kind][indexPath];
	}


## 扼要重述

通过包含辅助视图，你现在拥有了一个能够充分复制一个类层级的布局对象。在最终的实现当中，你可能想要加入一些调整到你自己的自定义布局中来节省空间。本例探索了一个真实的自定义 cv 布局的基本实现可能是什么样的。cv 是非常健壮的，提供了比我们见到的更多的灵活性。当移动、插入或者删除高亮和选择（甚至动画的时候）单元格的时候是非常容易接入到你的应用中的。要让你的自定义布局达到下一个级别，看下《创建自定义布局》的最后几个章节。