[Collection View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

# 介绍
## 关于iOS Collection View
collection view是一种使用灵活可变的布局展示一组有序数据元素的方式。通常使用collection view来展示类似网格布局的元素，但iOS中的collection view的能力不仅仅是行和列那么简单。使用collection view 能够通过定义好的子类精确布局可见元素并能够动态改变，所以你可以实现单元格，堆列，环绕布局，动态的改变布局，或任何你能够想象的布局类型。  
collection view将被展示的数据和用来展示数据的可视化元素严格区分开。在大部分情况下，你的应用程序只需要负责管理数据即可。你的应用程序也可以提供视图对象来展示数据。collection view会利用你的视图对象并完成它们在屏幕上布局的所有工作。这个过程会结合布局对象来做，布局对象指定了你的视图的位置和可视化属性，它还可以子类化来适合你的应用程序所需。因此，你负责提供数据，布局对象提供布局相关信息，collection view会将两者结合来完成最终的显示。

### 概览
标准的iOS collection view提供了所有你需要实现简单网格所需的行为。你还可以扩展标准类来支持自定义布局并指定这些布局之间的交互。
#### Collection View管理着数据驱动视图的可视化展示
collection view会协助你的应用程序所提供的数据驱动的视图的显示。collection view只关心如何使用你的视图以及将其以特定方式布局出来。collection view只关心你的视图的展示和排版，而不关心其内容是什么。理解了collection view与其数据源，布局对象以及你的自定义对象之间的交互对于在你的应用程序中灵活高效的使用collection view是很重要的。

```
相关章节：collection view基础，设计你的数据源和代理
```

#### 流式布局支持网格以及其他面向行的展示
流式布局对象是由UIKit提供的混合布局对象。通常使用该对象来实现网格——行列交错的元素——不过流式布局支持任意类型的线性流。由于它不仅仅为网格所设计，你还可以通过使用它或子类化它来创建各种有意思和灵活的排版内容。流式布局支持不同尺寸的元素，不同间距的元素，自定义段头和段尾，并无需子类化即可自定义边距。子类化能够让你更灵活的使用流式布局的各种功能。

```
相关章节：使用流式布局
```
#### 手势能够被用在cell和布局操作上
像所有的视图一样，你可以将手势附加到collection view上来操作该视图的内容。由于collection view包含了一组不同的视图，了解一些结合手势到collection view的基本技术会有所帮助。你可以使用手势来操作布局属性或collection view的单元格。

```
相关章节：接入手势支持
```
#### 自定义布局能够让你不局限于网格
你可以为你的应用程序继承基本的布局对象来实现自定义布局。尽管设计一个自定义布局无需编写大量代码，但如果你能够理解布局是如何工作的，你就能更好更高效的设计你的布局对象。指南的最后一章会集中分析一个示例工程，该工程会实现一整套自定义布局。

```
相关章节：创建自定义布局，自定义布局举例
```
### 预备知识
在阅读本文档之前，你应该对于视图在iOS应用程序中所扮演的角色有一定的理解。如果你是一个iOS开发的新手并对iOS视图结构不太熟悉的话，请先阅读“iOS视图编程指南”。
### 另请参阅
Collection View与table view有一些类似，它们都能够展示有序的数据给用户。table view的实现与一个标准collection view（使用给定流式布局）在使用索引，单元格和视图循环的过程类似。不过table view的展示是沿一个单列布局所展示的，而collection view能够支持多种不同的布局。更多关于table view的相关信息，参见“iOS table view编程指南”。
# Collection View基础
要展示其内容到屏幕上，collection view要与很多不同的对象共同合作。有些对象是自定义的，并必须由你的应用程序所提供。比如，你的应用程序必须提供一个数据源对象来告诉collection view有多少元素需要显示。其他对象由UIKit所提供并且是collection view基础设计的一部分。  
像table view一样，collection view也是数据驱动的对象，它的实现涉及你的应用程序对象的协作。若要理解你的代码需要做什么，你需要了解一些有关一个collection view都做了些什么的背景知识。
## 一个Collection View就是一组合作的对象
collection view的设计是将数据从被安排和展示到屏幕上与将要展示的数据进行分离。尽管你的应用程序需要完全负责管理被展示的数据，但它的可视化部分同样也被很多不同的对象所管理。清单1-1列出了UIKit中的 collection view相关类以及他们在实现一个collection view界面的过程中所扮演的角色。大部分类都被设计为无需通过子类继承即可使用，所以你可以通过使用很少量的代码就能够实现一个collection view。若你需要更多功能，你可以通过子类扩展。  

清单1-1 实现collection view的类和协议  

| 用途  | 类/协议  | 描述 |
|:------------- |:---------------:| -------------:|
| 顶层容器和管理      | UICollectionView UICollectionViewController | UICollectionView类的对象为你的collection view的内容定义了可视化区域。该类由UIScrollView扩展而来，可以根据需要包含一大块可滚动区域。该类同样能够协助从布局对象所接收的布局信息来展示数据。UICollectionViewController类的对象提供了一个collection view的视图控制器级别的支持。它的使用是可选的。 |
| 内容管理      | UICollectionViewDataSource 协议 UICollectionViewDelegate 协议 | 数据源对象是与collection view相关的最重要的对象，也是你必须提供的。数据源管理着collection view的内容，并创建该内容所需要展示的视图。要实现一个数据源对象，你必须创建一个遵循UICollectionViewDataSource协议的对象。collection view的delegate对象能够让你从collection view获取你想要的信息，并定制化视图的行为。比如，你可以使用代理对象来跟踪collection view中的选取和高亮元素。和数据源对象不同，代理对象是可选的。关于如何实现数据源和代理对象的相关信息，参见“设计你的数据源和代理”部分。 |
| 展示      | UICollectionReusableView UICollectionViewCell | 所有在collection view中展示的视图必须是UICollectionReusableView类的实例对象。该类支持一种collection view使用的循环机制。循环视图（而不是创建新视图）通常会提高性能，尤其是在其滚动的时候。UICollectionViewCell对象是一种你主要用来展示数据元素的特殊类型的重用视图。 |
|  布局   | UICollectionViewLayout UICollectionViewLayoutAttributes UICollectionViewUpdateItem | UICollectionViewLayout的子类被称为布局对象，它负责定义单元格的位置，尺寸以及可视化的属性，并在一个collection view中重用视图。在布局期间，一个布局对象会创建属性对象（UICollectionViewLayoutAttributes类的实例对象）来告诉collection view在哪以及如何展示单元格和重用视图。布局对象会在有数据元素插入，删除或移动到collection view时接收到UICollectionViewUpdateItem类的实例发出的消息。你无须自己创建该类的实例对象。有关更多关于布局对象的相关信息，参见“布局对象控制了界面展示” |
|  流式布局   | UICollectionViewFlowLayout UICollectionViewDelegateFlowLayout | UICollectionViewFlowLayout类是你用来实现网格或其他基于行式布局的混合布局对象。你可以使用该类本身或结合流式代理对象一起使用，后者能够让动态的你定制化布局信息。 |

图1-1展示了一个collection view的核心对象之间的关系。collection view会从它的数据源获取有关展示单元格的相关信息。数据源和代理对象是由你的应用程序提供的自定义对象，它们用来管理内容，包括单元格的选中和高亮。布局对象负责决定这些单元格在什么位置显示以及将这些信息以一个或多个布局属性对象的形式发送给collection view。collection view随后会合并布局信息与实际的单元格（以及其他视图）来创建最终的展示式样。  

图1-1 合并内容和布局来创建最终的展示  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_objects_2x.png)

当创建一个collection view界面的时候，首先你可以将一个UICollectionView对象添加到你的故事版或nib文件当中。将collection view看做一个中央集线器，所有的其他对象都从中发出。在添加完该对象之后，你可以开始配置其他相关对象，比如数据源或代理。所有的配置都是围绕着collection view本身的。比如，你在已经创建了一个collection view对象之后就无需创建一个布局对象了。
## 重用视图能够提高性能
Collection View使用了一种视图循环程序来提高性能。当视图移出屏幕的时候，它们将会被从视图移除并被放置到一个重用队列当中（而非被删除）。当新的内容滚动到屏幕上时，被从队列中移除的视图会被重新复用给新的内容。为更好的使用这种循环和重用，所有的被collection view所用来展示的视图都必须从UICollectionReusableView类所扩展。  
Collection View支持三种不同类型的重用视图，每种都有特定用途：  

* Cells（单元格）展示了你的collection view的主要内容。一个单元格的工作就是负责从你的数据源对象展示一个单一的元素。每个单元格都必须是UICollectionViewCell类的实例，当然你可以根据需要继承来展示你的内容。单元格对象内置提供了管理它们本身被选中和高亮状态的支持。要想将一个高亮效果添加到一个单元格上，你必须自己编写代码。更多关于实现单元格高亮/选中的相关信息，参见“管理选中和高亮状态”。
* Supplementary views（辅助视图）负责展示关于一个段落的相关信息。像单元格一样，辅助视图也是数据驱动的。不过，辅助视图不像单元格一样被强制实现，它们的使用和放置的位置被布局对象所控制。比如，流式布局支持段头和段尾作为辅助视图的可选项。
* Decoration views（装饰视图）是被布局对象所管理的装饰效果，它不受限于你的数据源对象。举例来说，布局对象通常使用装饰视图来实现一个自定义背景展示。

与table view不同，collection view不会给单元格强加任何特定样式，而辅助视图完全由你的数据源所提供。基本的重用视图类就像空白画板一样供你修改。比如，你可以使用它们来构建小的视图层级，展示图片，甚至可以动态的绘制内容。  
你的数据源对象负责提供与collection view相关的单元格和辅助视图。不过，数据源不需要直接创建视图，当有视图请求的时候，你的数据源需要使用collection view提供的方法从视图队列中提供需要的视图类型即可。无论是从重用队列中检索还是使用一个你提供的类，nib文件或故事版来创建一个视图，出列的过程应当始终返回一个合法的视图。  
更多关于如何从你的数据源创建和配置视图的相关信息，参见“配置单元格和辅助视图”。
## 布局对象控制了界面展示
布局对象只负责决定collection view中的元素位置和样式。即使你的数据源对象提供了视图和实际内容，但它的大小、位置以及其他可见的属性都是由布局对象所决定的。这种分开负责的方式能够让你动态的改变布局，而无需改变任何你的应用程序所管理的数据对象。  
collection view所使用的布局过程与应用程序视图的其余部分的使用相关，但有别于它。换句话说，不要混淆布局对象所做的与在父视图内重新定位子视图的layoutSubviews方法所做的。布局对象不会直接接触它所管理的视图，因为它实际上并不拥有任何视图。它会直接生成collection view中描述单元格，辅助视图和装饰视图的位置，尺寸和可视化的相关属性。随后collection view会将这些属性应用到实际的视图对象上。  
布局对象如何作用于一个collection view中的视图是没有限制的。布局对象可以移动一些视图中的一部分而其他部分不动。它还可以只移动视图一点点，或让它们沿屏幕随机移动。它甚至可以不用管周边的视图，只重新布局当中的视图。举例来说，布局对象能够让任意视图放置到视图栈的顶部。唯一真正的限制是布局对象如何影响你希望应用程序拥有的视觉样式。  
图1-2展示了一个垂直滚动的流式布局是如何对其单元格和辅助视图进行排版的。在垂直滚动流式布局中，内容区域的宽度保持固定，高度随内容增大。为了估算区域，布局对象会一次将视图和单元格进行布局，为它们选择最合适的位置。在流式布局这种情况下，单元格和辅助视图的尺寸会被指定为属性，无论是通过布局对象还是使用代理。计算布局就是使用这些属性将每个视图放置的问题。  

图1-2 布局对象提供了布局相关的度量  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_basics_2x.png)

布局对象不止控制了视图的尺寸和位置。它还指定了其他视图相关的属性，比如透明度，在3D空间中的转换以及相对于其他视图之上或之下的可见性（如果有的话）。这些属性能够让你创建更多有趣的布局。比如，你可以通过将视图放在彼此的顶部并更改其Z轴的顺序来创建单元格堆栈，或者可以在任意轴向上使用转换来对他们进行旋转。  
更多关于布局对象是如何承担collection view的布局的相关信息，参见“创建自定义布局”。
## Collection View自动初始化了动画
Collection View底层内建了动画的支持。当你插入（或删除）元素或段落的时候，collection view会自动的通过动画来展示改变的视图。比如，当你插入一个元素的时候，元素会在插入点之后为新的元素腾出空间。collection view能够构建动画是因为它能够监听元素当前的位置以及计算在插入后的最终位置。因此，它能够动画的展示每个元素从最初位置到最终位置。  
除了动画的展示插入，删除和移动操作外，你还能在任意时刻禁用布局并强制重新计算其布局属性。禁用布局不会直接动画展示元素；当你禁用布局的时候，collection view会以非动画的方式展示它新计算好的位置的元素。而在自定义布局中，你可以使用此行为定期为单元格调整位置，并创建动画效果。
# 设计你的数据源和代理
每个collection view都要有一个数据源对象。数据源对象是你的应用程序所展示的内容。它可以是一个从你的应用程序数据模型中取到的对象，也可以是管理collection view的视图控制器。对于数据源的唯一要求是必须提供collection view所需的相关信息，比如有多少个元素需要显示以及当显示这些视图的时候应当使用哪个视图。  
代理对象是可选的（但推荐使用）对象，它管理着与内容的呈现和交互相关的各个方面。尽管代理的主要任务是管理单元格的高亮和选中，它也可以被扩展为提供额外的信息。比如，流式布局扩展了基本的代理行为来为布局进行定制化，比如单元格的尺寸和它们之间的距离。
## 数据源管理着你的内容
数据源对象是你在使用collection view来展示内容时管理内容的对象。数据源对象必须遵循UICollectionViewDataSource协议，协议定义了你必须支持的基本行为和方法。数据源的任务就是提供给collection view以下问题的答案：  

* collection view要包含多少个段落？
* 对于一个给定的段落，这个段落要包含多少个元素？
* 对于一个给定的段落或元素，当展示相关内容时，应当使用哪个视图？

段落和元素是collection view内容组成的基本元素。一个collection view通常至少含有一个段落并很可能包含更多。每个段落依次包含零个或多个元素。元素代表着你要展示的主要内容，而段落将这些元素组织为逻辑上的一组。举例来说，一款照片类应用程序可能使用段落来代表一个单独的相片集合或在同一天中所拍摄的照片集合。  
collection view查找它所包含的数据时使用NSIndexPath对象。当试图定位一个元素的时候，collection view会使用布局对象提供的索引路径信息提供。对于元素而言，索引路径包含段落号和元素号。对于辅助视图和装饰视图，索引路径包含布局对象所提供的所有信息。辅助视图和装饰视图上的索引路径的意义取决于你的应用程序，尽管第一个索引位置对应数据源当中的特定段落。视图的索引路径更多的是识别性而非表面意义，识别哪个视图是什么类型的是当前需要考虑的。因此举例来说，如果你要使用辅助视图创建段头和段尾，如流式布局中所示，那么索引路径所提供的相关信息就是段落所引用的。  

```
注意：尽管标准的索引路径支持多层级，但collection view的单元格仅支持两层深度的索引路径，即“段落”和“元素”参数，这个与UITableView类的索引路径类似。辅助视图和装饰视图可以根据需要拥有更复杂的索引路径。索引路径大于1的元素被解释为与路径中第一个索引指定的段落相对应。习惯上只需要二级索引，不过辅助视图和装饰视图不受限制。在设计你的数据源时要记住这点。
```

不论你如何排列数据对象的段落和元素，这些段落和元素的视觉效果依旧由布局对象所决定。不同的布局对象能够展示不同的段落和元素数据，如图2-1所示。在该图中，流式布局对象将垂直段落设计为每个连续段落在之前一个段落之后。自定义布局能够将段落排版为非线性布局，布局的显示与实际数据相分离。  

图2-1 段落的排版根据布局对象的布局所排列  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_sections_2x.png)

### 设计你的数据对象
一个高效的数据源会使用段和元素来帮助组织其基本的数据对象。将你的数据组织成段落和元素将使得实现数据源的方法更为简单。由于数据源的方法经常被调用，你要确保这些方法的实现能够尽可能快的检索数据。  
一种简单的解决方案（当然不是唯一的解决方案）是数据源使用一组嵌套的数组，如图2-2所示。在这种配置下，顶层的数组包含一个或多个代表你的数据源的段落的数组。每个段落的数组又包含该段落的数组元素。在段落中查找元素就变成了查找到该段落的数组然后从该数组查找元素的过程。这种配置能够适当的组织元素的集合以及根据需要检索特定的元素。  

图2-2 使用嵌套数组来管理数据对象  
![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/ds_data_object_layout_2x.png)  

当设计你的数据结构的时候，你可以从一个简单的数组集合开始，然后根据需要转换到一个更高效的结构上。一般来讲，你的数据对象应当不应该有性能瓶颈。collection view 访问你的数据源只是为了计算总共有多少个对象，以及为当前屏幕上的元素获取视图。若布局对象只依赖你的数据对象的数据的话，那么当数据源包含上千个对象时，性能将会被严重降低。
### 将你的内容告知collection view
collection view询问你的数据源的问题包括它包含多少段以及每段包含多少项元素。当以下情况发生时，collection view会要求你的数据源提供信息：  

* collection view首次展示的时候。
* 你将一个不同的数据源对象赋值给collection view时。
* 你显式的调用collection view的reloadData方法时。
* collection view的代理使用performBatchUpdates:completion:执行block或有任何移动，插入或删除的方法执行时。

使用numberOfSectionsInCollectionView:方法来提供段落数，使用collectionView:numberOfItemsInSection:方法来提供每个段落的项目数。你必须实现collectionView:numberOfItemsInSection:方法，不过如果你的collection view只有一个段落的话，是否实现numberOfSectionsInCollectionView:方法是可选的。两个方法都是通过整形值返回相应的信息。  
如果你如图2-2那样实现你的数据源的话，你的数据源方法的实现可以如清单2-1那样简单。在这份代码中，_data变量是一个数据源的自定义成员变量，它存储了顶层段落的数组。通过获取该数组的数量能够得到段落数。通过获取每个子数组的数量能够获取该段落的项目数。（当然，你自己的代码要根据需要检测各种错误来确保返回值有效。）  

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
另一个你的数据源要做的重要工作是提供collection view要使用的展示你的内容的视图。collection view不会监听你的应用程序的内容。它只会直接使用你给予它的视图并将当前布局信息应用于它。所以，所有需要通过视图展现的内容都需要你来负责。  
在你的数据源告知有多少段落和项目在管理后，collection view会要求布局对象提供collection view的内容所需的布局属性。在某个时机，collection view会要求布局对象提供一组元素到一个特定矩形区域（通常是可见的矩形区域）。collection view会使用该组元素来要求你的数据源提供相应的单元格和辅助视图。要提供这些单元格和辅助视图，你的代码必须做到以下几点：  

1. 将你的模板单元格和视图嵌入到你的故事版文件中。（或者为每种支持的单元格或视图注册一个类或nib文件）
2. 在你的数据源中，当被要求时，从队列中取出并配置合适的单元格或视图。

为确保单元格和辅助视图以最高效的方式被利用，collection view承担了为你创建这些对象的责任。每个collection view都会维护一个当前没有被使用的单元格和辅助视图的内部队列。你无需自己创建对象，只需要直接要求collection view提供给你想要的视图即可。如果重用队列中有等待被重用的视图，collection view会立即将其准备好并返回给你。若没有等待被重用的视图，collection view会使用注册的类或nib文件来创建一个新的视图并返回给你。因此，每次你从队列中取出一个单元格或视图，你都会得到一个已经准备好被使用的对象。  
重用标识符使得可以注册多种不同类型的单元格和辅助视图。重用标识符是一个你用来区分注册的单元格和视图类型的字符串。该字符串的内容只与你的数据源对象相关。但当被要求提供视图或单元格时，你可以使用提供的索引路径来决定你可能需要的视图或单元格类型，然后传递相应的重用标识符给出列方法。
### 注册cell和辅助视图
你可以通过代码的方式或故事版的方式来配置你的collection view的单元格和视图。  
通过故事版来配置单元格和视图。当在故事版中配置单元格和视图时，你可以通过拖拽相应的item到你的collection view并配置它来做到。这会在collection view和相应的单元格和视图之间创建一组联系。  

* 对于单元格。从对象库中拖拽一个Collection View Cell到你的collection view中。给你的单元格设置自定义类和重用标识符以适当的值。
* 对于辅助视图。从对象库中拖拽Collection Reusable View到你的collection view中。然后设置自定义类和重用标识符以适当的值。

通过代码配置单元格。使用registerClass:forCellWithReuseIdentifier: 或 registerNib:forCellWithReuseIdentifier:方法来关联你的单元格和重用标识符。你可以在父视图控制器的初始化过程中调用该方法。  
通过代码配置辅助视图。使用 registerClass:forSupplementaryViewOfKind:withReuseIdentifier: 或 registerNib:forSupplementaryViewOfKind:withReuseIdentifier:方法来关联每种类型的视图和重用标识符。你可以在父视图控制器的初始化过程中调用该方法。  
在注册单元格的时候只需要一个重用标识符，不过在注册辅助视图时会额外要求你提供一个“类型”字符串。每种布局对象要负责定义它所支持的辅助视图的类型。比如，UICollectionViewFlowLayout类支持两种类型的辅助视图：段头视图和段尾视图。为区分这两种类型的视图，它定义了字符串常量 UICollectionElementKindSectionHeader 和 UICollectionElementKindSectionFooter。在布局期间，布局对象包含具有该视图类型的其他布局属性的类型字符串。collection view 会通过你的数据源传递信息。你的数据源可以使用两种类型的字符串和重用标识符来决定哪个视图对象应该出列以及返回。  

```
注意：若你实现了自定义的布局，你要负责定义你的布局所支持的辅助视图的类型。布局可能支持任意数量的辅助视图，每种都有其自己的类型字符串。更多关于定义自定义布局的相关信息，参见“创建自定义布局”。
```

注册是一个一次性的事件，它必须放置在你试图出列单元格或视图之前。在你注册之后，你可以根据需要出列任意数量的单元格或视图而无需再注册。我们不推荐你在出列一个或多个元素后再更改注册信息。最好是先注册单元格和视图然后再进行处理。
### 从队列取出和配置cell和视图
当collection view要求时，你的数据源对象应当负责提供单元格和辅助视图。UICollectionViewDataSource协议为这两个目的提供了两个方法：collectionView:cellForItemAtIndexPath: 和 collectionView:viewForSupplementaryElementOfKind:atIndexPath:。由于单元格是collection view必须的元素，你的数据源必须实现collectionView:cellForItemAtIndexPath:方法，但collectionView:viewForSupplementaryElementOfKind:atIndexPath:方法是可选的，并且依赖于布局所使用的类型。不论哪种情况，在实现这些方法时都应遵循一个简单模式：  

1. 使用dequeueReusableCellWithReuseIdentifier:forIndexPath: 或 dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:方法出列一个适当类型的单元格或视图。
2. 在指定索引路径使用数据配置视图。
3. 返回视图。

出列的过程被设计为依赖于你创建单元格或视图的过程。只要你提前注册了单元格或视图，出列方法就能够保证永不返回nil。若在重用队列中没有给定的类型的单元格或视图的话，出列方法会直接使用你的故事版或你在注册时使用的类或nib文件来创建一个。  
从出列过程中返回给你的单元格应当为原始状态，并应做好配置新数据的准备。对于必须创建的单元格或视图来说，出列过程会使用正常的过程对其进行创建和初始化——意思就是通过从一个故事版或nib文件或创建一个新的实例以及使用initWithFrame:方法对其进行初始化来加载视图。相反的，一个不是从这个过程中创建的单元，而是从重用队列中取出的单元很可能包含之前使用的数据的状态。在这种情况下，重用方法会调用 prepareForReuse 方法来给予单元格以时机来将其本身恢复至原始状态。当你实现一个自定义单元格或视图类时，你可以通过重写该方法来将属性重置为默认值以及执行一些额外的清理工作。  
当你的数据源出列一个视图之后，它会使用新的数据配置视图。你可以使用索引路径来传递给你的数据源方法，以便定位到适当的数据对象，然后将其应用在视图上。在你配置视图之后，从你的方法中将其返回，你的工作就结束了。清单2-2展示了一个如何配置单元格的简单例子。在单元格出列后，方法使用单元格的位置信息设置了单元格的自定义label，然后将其返回。

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
2. 调用collection view的相应方法来插入或删除段落或元素。

在你更新完你的数据，通知collection view改变之前的时间点。collection view会假设你的数据源包含正确的数据。如果不是这样的话，collection view可能会从你的数据源接收到错误的数据集合或请求不存在的元素，从而让你的应用程序崩溃。  
当你通过编码的方式添加，删除或移动一个单元格的时候，collection view的方法会自动的为这些改变创建动画。不过，若你想要一起展示动画效果的话，你必须将所有的插入，删除或移动的调用放入一个block中，然后将其传递给 performBatchUpdates:completion: 方法。批量更新的过程会随后以动画的形式同时展示所有的变更，你可以自由的将插入，删除或移动的调用放入同一个block中。  
清单2-3展示了如何执行一组批量更新来删除当前选中的元素的简单例子。传递给 performBatchUpdates:completion:方法的block首先调用自定义方法来更新数据源。然后告知collection view来删除元素。更新block和你提供的completion block都会被同步执行。  

清单2-3 删除选中的元素  

	[self.collectionView performBatchUpdates:^{
	   NSArray* itemPaths = [self.collectionView indexPathsForSelectedItems];
 
	   // Delete the items from the data source.
	   [self deleteItemsFromDataSourceAtIndexPaths:itemPaths];
 
	   // Now delete the items from the collection view.
	   [self.collectionView deleteItemsAtIndexPaths:itemPaths];
	} completion:nil];

## 管理选中和高亮的状态
Collection view默认支持单一元素的可选，并可以配置为支持多个元素的可选或禁用可选。Collection view会监听它区域内的触摸事件，然后高亮或选中相应的单元格。大部分情况下，Collection view会只修改一个单元格的属性来表示它被选中或高亮；它不会改变多个单元格的展现状态，不过有一个例外。若一个单元格的 selectedBackgroundView 属性包含一个有效视图的话，collection view会在单元格被高亮或选中时展示该视图。  

清单2-4 设置背景视图来表示状态变更  

	UIView* backgroundView = [[UIView alloc] initWithFrame:self.bounds];
	backgroundView.backgroundColor = [UIColor redColor];
	self.backgroundView = backgroundView;
 
	UIView* selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
	selectedBGView.backgroundColor = [UIColor whiteColor];
	self.selectedBackgroundView = selectedBGView;

collection view的代理为collection view提供了以下方法来实现高亮和选中：  

* collectionView:shouldSelectItemAtIndexPath:
* collectionView:shouldDeselectItemAtIndexPath:
* collectionView:didSelectItemAtIndexPath:
* collectionView:didDeselectItemAtIndexPath:
* collectionView:shouldHighlightItemAtIndexPath:
* collectionView:didHighlightItemAtIndexPath:
* collectionView:didUnhighlightItemAtIndexPath:

这些方法给予你各种时机来改变collection view的高亮/选中行为达到想要的效果。  
举个例子，如果你更倾向于自己绘制单元格的选中状态，你可以将selectedBackgroundView属性设置为nil，然后使用你的代理对象将可视化变化应用于单元格。你可以在collectionView:didSelectItemAtIndexPath:方法中应用可见变化，在collectionView:didDeselectItemAtIndexPath:方法中将其移除。  
如果你更倾向于自己绘制高亮状态，你可以重写collectionView:didHighlightItemAtIndexPath: 和 collectionView:didUnhighlightItemAtIndexPath:代理方法，使用它们来应用在你的高亮中。若你同样指定了视图给selectedBackgroundView属性，你应该将你的变更应用于单元格的内容视图以确保你的变更是可见的。清单2-5展示了使用内容驶入的背景色来改变高亮的简单方式。  

清单2-5 将一个临时高亮赋值给单元格  

	- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   		 UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
	   	 cell.contentView.backgroundColor = [UIColor blueColor];
	}
 
	- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   		 UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
	    cell.contentView.backgroundColor = nil;
	}

单元格的高亮状态和选中状态有一个微小但重要的区别。高亮状态是一个过渡状态，你可以在用户的手指还在触摸设备时将可见的高亮应用于单元格。只有当collection view在跟踪单元格的触摸时，该状态才能被设置为YES。当触摸事件停止后，高亮状态会返回值NO。相反的，选中状态只会在一系列的触摸事件终止后才会改变——尤其是当这些触摸事件表示用户想要选中单元格时。  
图2-3展示了当用户触摸一个未选中的单元格时发生的一系列步骤。初始的按下事件会引发collection view改变单元格的高亮状态为YES，不过这么做不会自动的改变单元格的展示效果。若最终的抬起事件也发生在单元格中的话，高亮状态会返回NO，collection view会改变选中状态为YES。当用户改变选中状态时，collection view会显示单元格中的selectedBackgroundView属性，不过这是collection view唯一作用于单元格的可见改变。其他的可见变化必须由你的代理对象实现。

图2-3 跟踪单元格的触摸事件  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cell_selection_semantics_2x.png)

无论用户选中还是不选中一个单元格，单元格的选中状态都是最后才改变的。单元格的触摸总是首先引起单元格高亮状态的更改。只有在触摸顺序结束后并且高亮状态在该顺序结束后作用于单元格后，才会引起单元格选中状态的变更。当你设计单元格时，你应当确保你的单元格的高亮和选中状态的可见效果不要冲突。
## 展示单元格的编辑菜单
当用户在单元格上执行长按操作时，collection view会展示一个编辑菜单给该单元格。编辑菜单可以用来裁剪，拷贝和粘贴collection view中的单元格。在编辑菜单展示之前可能会遇到几种情况：  

* 代理必须实现所有关于处理动作事件的三个方法：  

	collectionView:shouldShowMenuForItemAtIndexPath:

	collectionView:canPerformAction:forItemAtIndexPath:withSender:

	collectionView:performAction:forItemAtIndexPath:withSender:
* 对于显示的单元格，collectionView:shouldShowMenuForItemAtIndexPath:方法必须返回YES。
* collectionView:canPerformAction:forItemAtIndexPath:withSender:方法对于需要的动作处理当的至少一个要必须返回YES。collection view 支持以下动作：  
	 cut:  
	 
	 copy: 
	 
	 paste:

若条件都满足，并且用户从菜单中选择了一个动作，collection view会调用代理的collectionView:performAction:forItemAtIndexPath:withSender:方法来执行展示的动作。  
清单2-6展示了如何隐藏菜单的一个元素。在该例中，collectionView:canPerformAction:forItemAtIndexPath:withSender:方法将裁剪元素从编辑菜单中隐去了。它允许粘贴和拷贝元素，以便用户能够插入内容。  

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
最简单的在布局之间进行转换的方式是使用 setCollectionViewLayout:animated: 方法。不过，如果你对于转换过程需要更多的控制或者希望可交互的话，请使用UICollectionViewTransitionLayout对象。  
UICollectionViewTransitionLayout类是一种特殊类型的布局，它在转换到一个新的布局时会作为collection view的布局对象。通过转换布局对象，你可以将对象以非线性布局，使用不同的时间算法，或根据触摸事件进行移动。标准类提供线性转换到新的布局，不过，与UICollectionViewLayout类相同，UICollectionViewTransitionLayout类可以被子类化来创建任意需要的效果。如果这么做的话，你需要实现同样的方法来创建自定义布局，并能够让你的实现适应用户的输入，一般来说是手势输入。关于如何创建自定义不对象的更多信息，参见“创建自定义布局”。  
UICollectionViewLayout类提供了几个方法来跟踪布局切换之间的事件。UICollectionViewTransitionLayout对象会通过transitionProgress 属性来跟踪切换的完成状态。在切换发生时，你的代码应定时更新该属性来展示切换的进程。举例来说，使用UICollectionViewTransitionLayout类时可以结合手势对象一起使用，你可以用来在布局切换中使用，也能够让你创建可交互的切换。同时，如果你实现了自定义切换布局对象的话，UICollectionViewTransitionLayout类提供了两个方法来跟踪你的布局相关的值：updateValue:forAnimatedKey: 和 valueForAnimatedKey: 方法。这两个方法会跟踪你在切换的过程中与布局沟通的重要信息的设置和变更的浮点值。举例来说，若你使用捏合手势来切换布局的话，你可以使用这两个方法来告知转换的布局对象该在什么位置将视图的位移从一个转到另一个。  
在你的应用程序中包含UICollectionViewTransitionLayout对象有以下步骤：  

1. 使用initWithCurrentLayout:nextLayout:方法创建标准类的实例对象或你自己的自定义类。
2. 通过定时修改transitionProgress属性来沟通切换的过程。不要忘记在改变切换过程之后使用collection view的invalidateLayout方法来禁用布局。
3. 实现你的collection view的代理方法collectionView:transitionLayoutForOldLayout:newLayout:返回切换的布局对象。
4. 可选用 updateValue:forAnimatedKey: 方法来修改你的布局的值来展示关于你的布局对象的值的变化。在这种情况下，该值为0。

# 使用布局
你可以在你的collection view中使用固定的布局对象来对元素进行排版，即UICollectionViewFlowLayout类。流式布局实现了一种基于行的中断式布局，意思是布局对象将单元格以行为基线布局，一行能放多少单元格就放多少。当当前行没有空间留给布局对象时，会创建一个新行继续布局过程。图3-1展示了垂直滚动的流式布局的样子。在这种情况下，每行都在之前行之后水平布局。在一个段落中的单元格能够被段头和段尾视图随意包裹。  

图3-1 使用流式布局对段和单元格进行布局  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_horiz_headers_2x.png)

你可以使用流式布局来实现网格，但你可以用它做的更多。线性布局的概念可以应用到很多不同的设计上。举例来说，你可以沿着滚动方向创建单行元素并调整间距，而非网格化的布局元素。单元格也能够拥有不同的尺寸，这会与传统的网格式不同，它会有更多的不对称性，但它仍然是线性布局。可能性很多。  
你可以通过编码的方式，也可以通过Xcode中的界面编辑器来配置流式布局。配置流式布局的步骤如下：  

1. 创建流式布局对象将其赋值给你的collection view。
2. 配置单元格的宽高。
3. 根据需要设置行间距和单元格之间的间距。
4. 若你想要段头或段尾，设置它们的尺寸。
5. 设置布局的滚动方向。


```
重要：你至少要指定单元格的宽高。若你不指定，你的单元格的宽高将被设置为0，并且不可用。
```
## 自定义流式布局属性
流式布局对象会暴露几个属性来配置你的内容的展示。当设置这些属性时，这些属性将会被应用到布局的所有元素上。比如，使用流式布局对象的itemSize属性设置单元格的尺寸会让所有的单元格拥有同样的尺寸。  
如果你想动态的改变单元格的间距或大小，你可以使用 UICollectionViewDelegateFlowLayout 协议的方法。你需要在赋值给collection view的代理对象的位置实现这些方法。若给定的方法存在，流式布局对象会调用该方法而非使用固定的值。你可以通过该方法返回collection view中所有元素的适当的值。
### 在流式布局中指定元素的尺寸
若在collection view中的所有元素都是相同的尺寸，赋值给流式布局对象的itemSize属性以相应的宽高值即可。（以像素点设定元素的尺寸。）这是为内容不可变的元素设置布局对象的最快方式。  
若你想为你的单元格设定不同的尺寸，你必须实现collection view代理中的collectionView:layout:sizeForItemAtIndexPath:方法。你可以使用提供的索引路径信息来返回相应元素的尺寸。在布局期间，流式布局对象会将元素集中于同一垂直线上，如图3-2所示。该行的高或宽最终由该方向的最大元素所决定。  

图3-2 流式布局中的不同尺寸的元素  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_horiz_layout_uneven_2x.png)

```
注意：当你指定单元格的不同尺寸时，单行元素的个数可以与其他行不同。
```
### 指定元素之间的间距和行间距
使用流式布局，你可以指定同一行元素之间的最小间距以及相连行之间的最小间距。要注意，你提供的间距仅仅是最小间距。由于流式布局对象的布局内容的方式，在布局时可能会远大于你所指定的元素之间的距离。布局对象可能在元素布局后为不同尺寸时直接增加实际的行间距。  
在布局时，流式布局对象会持续给当前行添加元素，直到没有足够的空间留给一个整个的元素。若该行足够容纳一个整数数量的元素而没有额外的空间的话，那么元素之间的空间将会等于最小间距。若在行尾还有额外控件，布局对象会增加元素之间的间距直到元素能够均匀的分布在一行之内，如图3-3所示。增加间距会改变整体元素的效果，并防止每行末尾有较大的空隙。  

图3-3 元素之间实际的间距可能远比最小间距要大  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_item_spacing_2x.png)

对于行间距，流式布局对象会使用元素间距相同的技术。若所有的元素是相同大小，流式布局会使用行间距值的最小值并且一行中的所有元素都与下一行中的元素平均间隔。若元素尺寸不同，那么每个单独元素之间的实际距离是可变的。  
图3-4 展示了当元素为不同尺寸时，行间距为最小值的情况。由于元素尺寸不同，流式布局对象会选取每行中滚动方向上最大的元素。举例来说，在垂直滚动布局下，它会查找每行最高的元素。然后将这些元素之间的距离设置给最小值。若元素在一行的不同部分，如图所示，实际上的行间距将会比最小行间距看起来大的多。  

图3-4 若元素尺寸不同行间距可变  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_line_spacing_2x.png)

通过流式布局的属性，你可以使用固定间距值或动态间距值。行间距和元素之间的间距被基于段来处理。因此，行间距和元素间距在给定的段落中对于所有的元素而言相同，但不同的段落可能不同。你可以使用流式布局对象的minimumLineSpacing 和 minimumInteritemSpacing属性设置静态间距，或者使用collection view的collectionView:layout:minimumLineSpacingForSectionAtIndex: 和 collectionView:layout:minimumInteritemSpacingForSectionAtIndex:方法来设置。  
### 使用段落内边距来拉伸你的内容的边距
段落内边距可以作为调整布局单元格间距的一种方式。你可以使用内边距来在段头视图之后和段尾视图之前插入空间。你也可以使用内边距来在内容的四边来插入空间。图3-5展示	了在一个垂直滚动流式布局中内边距是如何影响一些内容的效果。  

图3-5 段落内边距改变了布局单元格的可用间距  

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_section_insets_2x.png)  

由于内边距减少了布局单元格的可用间距，你可以用它来限制一行的单元格的数量。在不滚动的方向设定内边距是一种压缩每行间距的方法。若你将该信息与适当的单元格大小所结合，你就能控制每行单元格的数量。
## 要知道何时该子类化流式布局
虽然使用流式布局无需子类化就能够高效的使用，有时候你还是需要将其子类化以便获取你需要的行为。列表3-1列出了实现所需要的效果所必须的一些继承UICollectionViewFlowLayout的方案。  

列表3-1 继承UICollectionViewFlowLayout的一些情境  

情境  | 继承的一些提示
------------- | -------------
 你要添加新的辅助视图或装饰视图到你的布局中 | 标准的流式布局类只支持段头段尾视图，不支持装饰视图。想要支持额外的辅助视图和装饰视图，你需要至少重写以下方法：layoutAttributesForElementsInRect: (必须) layoutAttributesForItemAtIndexPath: (必须) layoutAttributesForSupplementaryViewOfKind:atIndexPath: (支持新的辅助视图) layoutAttributesForDecorationViewOfKind:atIndexPath: (支持新的装饰视图) 在layoutAttributesForElementsInRect:方法中，你可以调用super来获取单元格的布局属性，然后将属性添加到任意指定的矩形区域的新的辅助视图或装饰视图中。使用其他方法来根据需要提供属性。更多关于在布局期间为视图提供属性的相关信息，参见“创建布局属性”以及“在给定矩形区域为元素提供布局属性”。
 你要调整流式布局返回的布局属性 | 重写 layoutAttributesForElementsInRect: 方法，然后将布局属性返回。在实现该方法时应当调用super，修改由父类提供的属性，然后将其返回。关于深度探讨这些方法所承担的工作，参见“创建布局属性”和“在给定矩形区域为单元格提供布局属性”。
 你要为你的单元格和视图添加新的布局属性 | 创建 UICollectionViewLayoutAttributes 的自定义子类并添加你需要的属性代表你的自定义布局信息。子类化UICollectionViewFlowLayout并重写layoutAttributesClass方法。在你的该方法实现中返回你的自定义子类。你还应该重写layoutAttributesForElementsInRect:方法，layoutAttributesForItemAtIndexPath:方法，以及其他的返回布局属性的方法。在你的自定义实现中，你应当为你定义的自定义属性设置值。
 你要为插入或删除的单元格指定初始或最终位置 | 默认的，在单元格被插入或删除时会有一个简单的淡出动画。若要创建自定义动画，你必须重写部分或所有以下方法：initialLayoutAttributesForAppearingItemAtIndexPath: initialLayoutAttributesForAppearingSupplementaryElementOfKind:atIndexPath: initialLayoutAttributesForAppearingDecorationElementOfKind:atIndexPath: finalLayoutAttributesForDisappearingItemAtIndexPath: finalLayoutAttributesForDisappearingSupplementaryElementOfKind:atIndexPath: finalLayoutAttributesForDisappearingDecorationElementOfKind:atIndexPath: 在你的这些方法的实现中，要设定你需要的属性给插入或移除的视图。流式布局对象会使用你提供的属性来动画的展示插入和删除。若你重写这些方法，我们推荐你也重写prepareForCollectionViewUpdates: 和 finalizeCollectionViewUpdates方法。你可以使用这两个方法来跟踪在当前循环中是哪些单元格被插入和删除了。更多关于插入和删除是如何工作的，参见“让插入和删除的动画更有趣”。

还有一些实例中，正确的做法是从头开始创建自定义布局。在你决定这么做之前，花时间考虑一下这么做是否确实必要。流式布局提供了为适配多种不同的布局多种可定制的行为，它很容易使用，并且包含了大量的优化使得其更加高效。不过，这么说并不意味着你不应该创建自定义布局，因为某些情况下，这么做是有意义的。流式布局限定了滚动方向是单一的，所以如果你的布局包含的内容超出了屏幕在两个方向上的界限，那么这时就有必要实现自定义布局了。如上所述，如果你的布局不是网格或换行的布局的话，或者如果你的布局中的元素频繁的移动，而子类化流式布局比你自己创建的布局要复杂的话，那么创建自定义布局就是一个正确的决定。
更多关于创建自定义布局，参见“创建自定义布局”。
# 接入手势支持
你可以通过使用手势识别来给你的collection view添加大量的交互。给collection view添加手势识别，当手势发生时使用它来触发事件。对于collection view，有两种事件你可能需要实现：  

* 你需要触发collection view布局信息的改变事件。
* 你需要直接操作单元格和视图。

你应当将手势识别添加到collection view上——而非一个特定的单元格或视图上。UICollectionView 类扩展于UIScrollView，所以将你的手势识别添加到collection view上不会干扰其他跟踪的手势。此外，由于collection view会存取你的数据源和你的布局对象，你仍然应该存取所有你需要操作的单元格和视图的相关信息。
## 使用手势修改布局信息
手势识别提供了一种简单的方式来动态的修改布局参数。举例来说，你可以使用捏合手势来改变自定义布局中单元格之间的距离。配置一个手势识别的过程是相对比较简单的。  

1. 创建手势识别。
2. 将手势识别添加到collection view上。
3. 使用手势识别的处理方法来更新布局参数以及禁用布局对象。

你可以使用alloc/init这种创建其他对象的过程来创建手势识别。在初始化期间，你需要指定目标对象和动作方法以供手势触发时调用。然后调用collection view的addGestureRecognizer:方法来将其添加到视图上。大部分的实际工作将会发生在你初始化时指定的方法中。  
清单4-1展示了附加在collection view上的捏合手势调用方法的例子。在该例中，捏合所产生的数据被用来改变自定义布局的单元格之间的距离。布局对象实现了自定义的updateSpreadDistance方法，该方法会验证新的距离值然后将其存储，用在随后的布局过程中。动作方法随后会将布局设置为失效，然后强制其基于新的值更新单元格的位置。  

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
UICollectionView 类会监听单点触摸事件来初始化其高亮和选中的代理方法。若你想添加自定义触摸或长按手势到collection view 上的话，配置你的手势识别的相关值
## 操作单元格和视图

# 创建自定义布局

# 自定义布局举例