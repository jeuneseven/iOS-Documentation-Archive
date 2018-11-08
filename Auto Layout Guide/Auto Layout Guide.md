[Auto Layout Guide 原文链接](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853)

# 开始
## 理解自动布局
自动布局会动态的计算在你的视图层级中所有视图的位置和大小，基于这些视图的约束。举例来说，你可以约束一个按钮与一个图片水平居中，让按钮的顶部始终与图片的底部保持8像素的距离。若图片的大小或位置改变了，按钮的位置也会自动变化进行调整匹配。  
这种基于约束的设计方式能够让你动态的构建用户界面，相应内部和外部的变化。
### 外部改变
当你的父视图的大小或形状改变时外部改变将会发生。伴随着改变的发生，你必须更新你的视图层级的布局，以便将可用空间更好的利用起来。以下是几种外部改变的来源：  

* 用户调整窗口大小 (OS X)。
* 用户进入或离开iPad上的分离式视图（iOS）。
* 设备改变方向（iOS）。
* 电话和音频录制栏展示或消失（iOS）。
* 你需要支持不同的尺寸类。
* 你需要支持不同的屏幕尺寸。

大部分这些变化都可能会在运行时发生，它们需要你的应用程序进行动态的反馈。其他类似于支持不同屏幕尺寸，表示应用程序适配不同的环境。即使屏幕尺寸不会在运行时改变，创建一个自适应的界面也能够让你的应用程序在iPhone 4S，iPhone 6 Plus甚至是在iPad上都能够良好运行。自动布局同样也是支持iPad上Slide Over 和 Split Views的关键组件。
### 内部改变
当视图的尺寸或用户界面上的控件发生改变时，内部改变将会发生。  
以下是几种内部改变的来源：  

* 应用程序展示的内容发生了改变。
* 应用程序支持国际化。
* 应用程序支持动态类型（iOS）。

当你的应用程序的内容发生改变时，新的内容可能需要一个与旧内容不同的布局。这通常发生在应用程序展示文字或图片时。举例来说，一款新闻类应用程序需要根据单个新闻文章来调整其布局尺寸。同样的，相册应用也必须处理范围广泛的图片大小和宽高比。  
国际化是让你的应用程序适应不同的语言，地区，文化的过程。一款国际化的应用程序的布局必须考虑不同语言和地区在应用程序中的正确显示。  
国际化对于布局主要有三方面的影响。首先，当你将你的用户界面翻译为一个不同的语言时，标签需要不同的空间。比如，用德语举例来说，通常就需要比英语更多的空间来展示。而日语通常需要较少的空间。  
其次，即使语言本身没改变，但日期和数字的格式可能从一个地区到另一个地区会改变。虽然这些变化通常比语言上的改变要小，但用户界面仍旧需要适配尺寸上的微小变化。  
第三，改变语言不只会影响文字的大小，还会影响布局的组织结构。不同的语言使用不同的布局方向，举例来说，英语使用从左到右的布局方向，而阿拉伯语和希伯来语使用的是从右到左的布局方向。通常来讲，用户界面的元素的顺序应当与布局方向匹配。如果一个按钮是在英文界面中的右下角，那么在阿拉伯语界面中它应当在左下角。  
最后，若你的iOS应用程序支持动态类型，用户可以改变你的应用程序中使用的文字大小。这会同时改变用户界面中文字元素的宽高。若用户在你的应用程序运行时改变了文字大小，那么文字和布局都要同时适配。
### 自动布局与基于frame布局对比
有三种方法来布局一个用户界面。你可以通过代码布局用户界面，也可以使用自动调整来自动的响应外部变化，或者你可以使用自动布局。  
传统上，应用程序通过代码的方式设置视图层级中的每个视图的位置来布局用户界面。frame定义了视图在其父视图坐标系统中的的原点，宽高。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/layout_views_2x.png)

要布局你的用户界面，你需要计算你的视图层级中的每个视图的位置和大小。随后，如果有变化发生，你必须重新计算所有受到影响的视图的frame。  
以编码的方式定义视图的frame会有极大的灵活性。当变化发生时，你可以直接设置你需要的改变。但因为你必须自己管理所有的变化，布局一个简单用户界面就需要大量的努力来设计，调试和维护。创建一个真正自适应的用户界面会增加一个数量级的难度。  
你可以使用自动调整大小来帮助减少这个过程的难度。自动调整定义了当视图的父视图的改变时，视图的frame如何改变。这简化了创建布局适配外部变化。  
不过，自动调整大小只支持可能布局的很小一部分子集。对于复杂的用户界面，你通常需要自己通过代码增加调整布局。此外，自动调整只会适配外部变化。它不支持内部变化。  
自动调整大小其实只是从编码布局上进行了迭代增强，而自动布局代表一种全新的范式。你无需考虑视图的frame，你需要考虑的是视图之间的关系。  
自动布局使用一系列的约束来定义你的用户界面。约束通常代表两个视图之间的关系。自动布局随后会根据视图之间的约束来计算每个视图的位置和大小。这造成了布局能够动态的响应外部和内部变化。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/layout_constraints_2x.png)

用来设计一组约束来创建特定行为的逻辑与用来编写代码或面向对象的逻辑非常不同。幸运的是，控制自动布局与控制其他编程任务没有差别。有两个基本步骤：首先你需要理解基于约束布局背后的逻辑，然后你要学习使用API。在学习其他编程任务时，你也要顺序的执行这些步骤。自动布局没有例外。  
本指南的其他部分是被设计用来让你容易迁移到自动布局。“没有约束的自动布局”一章对于用户界面背后的高度抽象简化创建自动布局进行了描述。“约束的剖析”一章提供了你自己创建自动布局交互需要理解的背景知识。“在用户编辑器中使用约束”描述了设计自动布局的工具，“编码方式创建约束”和“自动布局手册”两章详细描述了API。最后，“自动布局手册”一章展示了一系列不同复杂程度的样本布局，你可以学习它，将其应用在你的项目中，“调试自动布局”一章对于出问题之后如何修复提供了建议和工具。
## 没有约束的自动布局
Stack view提供了一种简单方式来利用自动布局的功能，而无需引入复杂的约束。一个单一的Stack view定义了一行或一列用户界面元素。Stack view会基于这些元素的属性来进行排版。  

* axis轴线：（仅用于UIStackView）定义了stack view的方向，是垂直还是水平。
* orientation方向：（仅用于NSStackView）定义了stack view的方向，是垂直还是水平。
* distribution分布：定义了沿轴线的视图的布局。
* alignment对齐：定义了垂直于stack view轴线的视图的布局。
* spacing间距：定义了临近视图的间距。

若要使用stack view，在界面编辑器中拖拽一个垂直或水平的stack view到画布上。然后将内容拖拽到stack 中。  
若一个对象拥有固定内容大小，它会以该尺寸出现在该stack中。若它的内容不是固定大小，界面编辑器会提供一个默认大小。你可以重新调整对象的大小，界面编辑器会添加约束来维持它的大小。  
要进一步的调试布局，你可以使用属性检查器修改stack view的属性。举例来说，下例使用了8像素间距和等距分布。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/IB_StackView_Simple_2x.png)

stack view也会基于它在排版视图上的内容和压缩比例优先级来布局。你可以使用尺寸检查器来修改这些。  

```
注意：你可以通过直接添加约束到排版视图上来进一步的修改布局；不过，你要尽量避免可能的冲突：一般说来，若一个视图的尺寸在给定区域内默认基于其内容尺寸，你可以在该区域内放心添加约束。更多约束冲突的相关信息，参见“不满足的布局”
```

此外，你可以将stack view嵌入到其他的stack view中来构建更复杂的布局。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/IB_StackView_NestedStacks_2x.png)

通常来讲，尽量多的使用stack view来管理你的布局。只有在单独通过stack view无法达到你的要求时才需要添加约束。  
更多使用stack view的相关信息，参见“UIStackView类目参考” 或 “NSStackView类目参考”。  

```
注意：尽管使用嵌入的stack view会增加用户界面的复杂度，但你无法摆脱对约束的需要。至少，你总是需要约束来定义最外层堆栈的位置（也可能是大小）。
```
## 约束的剖析
你的视图层级的布局被定义成一系列的线性等式。每个约束都代表着一个单一的等式。你的目的应该是声明一系列的等式，每个等式有且只有一个解。  
一个简单的等式如下所示。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/view_formula_2x.png)

这种约束状态是红色视图的前边距离蓝色视图的后部8像素。该等式有以下几部分组成：  

* Item 1（元素1）。代表等式中的第一个元素——在本例中，为红色视图。元素必须是一个视图或者布局参考。
* Attribute 1（属性1）。代表第一个元素的约束属性——本例中代表红色视图的前边距。
* Relationship（关系）。代表左边和右边的关系。关系可以有以下三种值之一：相等，大于或等于，小于或等于。在本例中，左边与右边相等。
* Multiplier（倍数）。代表属性2乘以该浮点数的值。在本例中，代表倍数是1.0。
* Item 2（元素2）。代表等式中的第二个元素——在本例中，是蓝色视图。与第一个元素不同，该元素左边可以为空。
* Attribute 2（属性2）。代表第二个元素的约束属性——本例中是蓝色视图的后边距。若第二个元素左边为空，该属性必须为“非属性”。
* Constant（常量）。代表常量，浮点位移——在本例中是8.0。该值会被添加到属性2的值中。

在我们的界面中，大部分约束都定义了两个元素之间的关系。这些元素可能代表视图或者布局参考。约束也可以定义同一个元素的不同属性之间的关系，比如，你可以设置一个元素的宽高比。你也可以将常量赋值给元素的宽高。当操作常量时，第二个元素的左边为空，第二个属性设置为“非属性”，倍数设置为0.0。
### 自动布局属性
在自动布局中，属性被定义成能够被约束的功能。通常来讲，它包含四个边（左右上下），也包括宽高和垂直水平的角。文本元素也有一个或多个基准线属性。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/attributes_2x.png)

有关完整属性列表，参见NSLayoutAttribute枚举。  

```
注意：虽然OSX和iOS都使用了NSLayoutAttribute枚举，它们的定义的值是有一些不同的。要想查看完整的属性列表，要确定你查看的是正确的平台的文档。
```
### 简单方程
等式中参数和属性的广泛可用性让你能够创建多种不同类型的约束。你可以定义视图之间的间距，对其视图的边，定义相关联的两个视图的大小，或者定义视图的缩放比。不过，不是所有的属性都是兼容的。  
有两种基本类型的属性。尺寸属性（比如宽高）和位置属性（比如前，左，上）。尺寸属性用来指定元素的大小，而无需指出其位置。位置属性用来指定元素相对于某些其他元素的位置。不过，它们不显示元素的大小。  
考虑到这些差异，以下规则适用：  

* 你不能强制设定一个尺寸属性给位置属性。
* 你不能给位置属性赋值常量。
* 使用位置属性时，你不能使用不一致的倍数（与1.0不一样的值）。
* 对于位置属性，你不能限制垂直属性给水平属性。
* 对于位置属性，你不能限制前或后属性给左或右属性。  
  
举例来说，设置一个元素的顶部为常量20而没有其他的上下文是没有意义的。你必须定义元素的位置属性与其他元素进行关联，比如，距离父视图的顶部20像素。不过，设置元素的高度为20像素没有任何问题。更多信息，参见“翻译值”。  
  
清单3-1展示了不同的一般约束的简单方程。  

```
注意：本章中所有的简单方程都使用伪代码展示。想查看使用真实代码的真实约束，参见“编码方式创建约束”或者“自动布局手册”
```

清单3-1 对于一般约束的简单方程

	// Setting a constant height
	View.height = 0.0 * NotAnAttribute + 40.0
 
	// Setting a fixed distance between two buttons
	Button_2.leading = 1.0 * Button_1.trailing + 8.0
 
	// Aligning the leading edge of two buttons
	Button_1.leading = 1.0 * Button_2.leading + 0.0
 
	// Give two buttons the same width
	Button_1.width = 1.0 * Button_2.width + 0.0
 
	// Center a view in its superview
	View.centerX = 1.0 * Superview.centerX + 0.0
	View.centerY = 1.0 * Superview.centerY + 0.0
 
	// Give a view a constant aspect ratio
	View.height = 2.0 * View.width + 0.0

### 相等而非赋值
要注意，“注意”中展示的等式代表相等，而非赋值。  
当自动布局解等式时，它并不只是将等式右边的值赋值给左边。而是它会计算属性1和属性2的值，并确定他们的关系为真。这意味着我们可以随意将等式两边的元素进行重新排列。比如，清单3-2中的等式与“注意”中的副本相同。  

清单3-2 翻转的等式  

	// Setting a fixed distance between two buttons
	Button_1.trailing = 1.0 * Button_2.leading - 8.0
 
	// Aligning the leading edge of two buttons
	Button_2.leading = 1.0 * Button_1.leading + 0.0
 
	// Give two buttons the same width
	Button_2.width = 1.0 * Button.width + 0.0
 
	// Center a view in its superview
	Superview.centerX = 1.0 * View.centerX + 0.0
	Superview.centerY = 1.0 * View.centerY + 0.0
 
	// Give a view a constant aspect ratio
	View.width = 0.5 * View.height + 0.0

```
注意：当重新排列元素时，要确定你要颠倒的倍数和常量。比如，常量8.0变为-8.0。2.0的倍数变为0.5。0.0的约束和1.0的倍数保持不变。
```
你会发现自动布局通常会提供多种方法来解决同一个问题。比较理想的方式是你应该选择最能够清晰描述你的理念的解决方案。不过，不同的开发者对于哪一种解决方案是最好的不会统一。在这里，保持一致要比正确要好。如果你选择一种方法并始终坚持下去，那么从长远来看，你会遇到越来越少的问题。比如，本指南使用了以下原则：  

1. 整数的倍数比分数的倍数要好。
2. 正数常量比负数常量要好。
3. 无论在任何位置，视图都应该出现在布局队列中：前后，上下。

### 创建无歧义的布局
当使用自动布局时，目标应当是提供一系列的等式，有且只有一个解。有歧义的约束会拥有超过一个解。无法满足的约束不会有合法的解。  
通常来讲，约束必须同时定义视图的尺寸和位置。假设父视图的尺寸已经被设置（比如，iOS上的屏幕的根视图），一个无歧义的满足布局需要的约束需要在视图的每个方向上都有两个约束（不算父视图）。不过，在选择哪个约束应该使用时，你有着多种选择。比如，一下三种布局都是无歧义的，满足的布局（只展示了水平方向的约束）:  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/constraint_examples_2x.png)

* 第一种布局约束，视图的左边与父视图的左边相关。它还给视图一个固定的宽度。随后右边距的位置就能够根据父视图的尺寸和其他约束计算出来了。
* 第二种布局约束，视图的左边与父视图的左边相关。它还给视图的右边约束了与父视图的右边相关。视图的宽度随后酒呢能够根据父视图的尺寸和其他的约束计算出来了。
* 第三种布局约束，视图的左边与父视图的左边相关。它还将视图的中心与父视图对其。宽度和右边距的位置随后就能够根据父视图的尺寸和其他的约束计算出来了。

注意每种布局都有一个视图和两个水平的约束。在每种情况下，约束都完整定义了视图的宽度和水平位置。这就意味着所有的布局都是在水平轴上无歧义的，满足的布局。不过，这些布局并不等同于能够使用。要考虑到父视图的宽度改变的情况。  
在第一种布局中，视图的宽度不会改变。大部分情况下，这不是你想要的。实际上，一般来讲，你应该避免将常量大小赋值给视图。自动布局是被设计用来自动适应环境来创建布局的。当你基于一个视图固定尺寸的时候，你就将这种能力缩小了。  
可能不太明显，不过第二种和第三种布局是相同的效果：它们都维持视图和其父视图的固定间距，即使是父视图的宽度改变时。不过，它们并不相等。通常来讲，第二个例子比较容易理解，但第三个例子可能更有用，尤其是当你沿中线摆放一组元素时。始终要为你的布局选取最佳的方案。  
现在，考虑的稍微复杂一点。假设你要在iPhone上展示两个挨着的视图。你要确保他们在所有方向上都有着较好的间距，并且始终拥有相同宽度。它们也应当在设备旋转的时候调整尺寸。  
以下图片展示的视图，在水平和垂直方向上：  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/Blocks_Portrait_2x.png)  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/Blocks_Landscape_2x.png)

那么这些约束应该是什么样呢？下图展示了一种比较直接的解决方案：  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/two_view_example_1_2x.png)

上述解决方案使用的是以下的约束：  

	// Vertical Constraints
	Red.top = 1.0 * Superview.top + 20.0
	Superview.bottom = 1.0 * Red.bottom + 20.0
	Blue.top = 1.0 * Superview.top + 20.0
	Superview.bottom = 1.0 * Blue.bottom + 20.0
 
	// Horizontal Constraints
	Red.leading = 1.0 * Superview.leading + 20.0
	Blue.leading = 1.0 * Red.trailing + 8.0
	Superview.trailing = 1.0 * Blue.trailing + 20.0
	Red.width = 1.0 * Blue.width + 0.0

根据之前的惯例，这种布局有两个视图，四个水平方向的约束，以及四个垂直方向的约束。虽然这不是万无一失的指南，但它是一个快速的迹象表明你是在正确的轨道上。更重要的是，约束对于视图的大小和位置都进行了单独设定，这就形成了无歧义的，满足条件的布局。移除任何约束，布局都会变成有歧义的。而添加额外的约束，你又会增加冲突的风险。  
同样，这仍不是唯一的解决方案。以下是与之相等的合理解决方案：  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/two_view_example_2_2x.png)  

无需将蓝色视图的顶部和底部固定在其父视图上，你只需对其蓝色视图的顶部和红色视图的顶部即可。类似的，你需要将蓝色视图的底部和红色视图的底部对其。约束如下所示。

	// Vertical Constraints
	Red.top = 1.0 * Superview.top + 20.0
	Superview.bottom = 1.0 * Red.bottom + 20.0
	Red.top = 1.0 * Blue.top + 0.0
	Red.bottom = 1.0 * Blue.bottom + 0.0
 
	//Horizontal Constraints
	Red.leading = 1.0 * Superview.leading + 20.0
	Blue.leading = 1.0 * Red.trailing + 8.0
	Superview.trailing = 1.0 * Blue.trailing + 20.0
	Red.width = 1.0 * Blue.width + 0.0

示例仍旧有两个视图，四个水平方向约束，四个垂直方向约束。同样也形成了无歧义的满足条件的布局。

	但哪种比较好呢？
	这些解决方案都形成了合理的布局。那么哪种比较好呢？
	遗憾的是，事实上客观的不能够证明一种解决方案比另一种要更好。每种都有其自己的优势和缺点。  
	第一种解决方案在一个视图被移除时会比较灵活。将一个视图从视图层级中移除同样也会移除其所有的关联的约束。所以，如果你移除红色视图的话，蓝色视图会留下三个约束。你需要添加一个约束就能够达到合理布局了。而第二种解决方案，移除红色视图的话，将会让蓝色视图只拥有一个约束。
	另一方面，在第一种解决方案中，若你想要视图的顶部和底部对其，你必须确保它们的顶部和底部约束使用的是同样的常量值。若果你改变其中的一个常量，你必须要记得改变另一个常量。
	
### 约束不相等
到目前为止，所有的例子都展示的是约束是相等的情况，但这只是一面。约束也能够表示不相等的情况。尤其是约束关系能够是相等，大于或等于，或者是小于或等于。  
比如，你可以使用约束来定义视图的最小或最大尺寸（清单3-3）。  

清单3-3 赋值一个最小和最大尺寸  

	// Setting the minimum width
	View.width >= 0.0 * NotAnAttribute + 40.0
 
	// Setting the maximum width
	View.width <= 0.0 * NotAnAttribute + 280.0

当你开始使用不相等时，每个视图的每个方向的两个约束的规则就被打破了。你可以将一个单一的相等关系替换为两个不等的。在清单3-4中，单一的相等关系以及成对的不等关系的效果是一样的。  

清单3-4 替换一个单一相等关系为两个不等  

	// A single equal relationship
	Blue.leading = 1.0 * Red.trailing + 8.0
 
	// Can be replaced with two inequality relationships
	Blue.leading >= 1.0 * Red.trailing + 8.0
	Blue.leading <= 1.0 * Red.trailing + 8.0

但反过来不一定对，因为两个不等关系不一定等于一个相等关系。比如，在清单3-3中的不等关系限制了视图的宽度的可呢取值范围——但对于它们本身而言，它们没有定义宽度。你还是需要额外的水平约束来在这个范围内定义视图的位置和尺寸。

### 约束优先级
默认的，所有的约束都是必须的。自动布局必须计算一种能够满足所有约束的解。如果不能的话，会有错误。自动布局会打印关于不满足约束的相关信息到控制台，并选择一个约束来中断。随后会抛弃中断的约束来重新计算一个解。更多相关信息，参见“不满足的布局”。  
你也可以创建可选的约束。所有的约束都有一个在1到1000之间的优先级。拥有1000的优先级的约束是必须的。所有其他的约束都是可选的。  
当计算解时，自动布局会从最高到最低优先级的顺序来满足所有的约束。若不能够满足可选约束的话，该约束会被跳过，从下一个约束开始继续。  
即使一个可选的约束不能够被满足，它依然能够影响布局。在跳过约束之后如果在布局中还有模糊的情况存在的话，系通过选择一个最接近约束的解决方案。在这种情况下，不满足的可选约束会表现为将视图拉至它们本身。  
可选约束和不相等的情况经常同时发生。举例来说，在清单3-4中，你可以为连个不等的约束提供不同优先级。大于或等于的关系可以是必选的（优先级为1000），小于或等于的关系可以是低优先级的（优先级250）。这意味着蓝色视图不能靠近红色视图超过8像素。不过，其他的约束能够将其拉至远处。同样，可选约束也会将蓝色视图朝着红色视图拉近，会保证尽量靠近到8像素远，给予其他布局中的约束。  

	注意
	不要觉得使用所有1000个优先级值有压力。实际上，优先级通常就是系统定义的几种，低（250），中（500），高（750），以及必须（1000）。你可以将约束定义成高于或低于这些值的一两点，以帮助防止关联。若你使用的远超过它的话，你可能就需要重新检视你的布局逻辑了。
	对于iOS中定义的一系列预定义好的约束常量，参见UILayoutPriority枚举。对于OSX，参见布局优先级常量。

### 固定的内容尺寸
到目前为止，所有的例子都使用约束定义了视图的尺寸和位置。不过，有些视图对于其本身的内容会给予一个自然尺寸。这要参考它们的“固定内容尺寸”。举例来说，一个按钮的固定内容尺寸是其标题加上一小部分的间距。  
不是所有的视图都有固定内容尺寸。对于拥有的视图来说，固定内容尺寸能够定义视图的高和宽。清单3-1展示了一些例子。  

清单3-1 一些常用控件的固定内容尺寸  

| 视图  | 固定内容尺寸  |
|:------------- |:---------------:|
| UIView 和 NSView      | 没有固定内容尺寸 |
| Sliders      | iOS上只定义的宽度，OSX上根据slider的类型能够同时定义高和宽 |
| Labels, buttons, switches, and text fields | 同时定义了高和宽 |
| Text views and image views | 固定内容尺寸能够变化      |

固定内容尺寸是基于视图的当前内容的。label或者button的固定内容尺寸是基于要显示的文字数量和使用的字体来决定的。对于其他视图，固定内容尺寸要更复杂一些。比如，一个空白图片不会有固定内容尺寸。只要你添加一个图片，固定内容尺寸就会被设置为图片的大小。  
text view的固定内容尺寸会根据内容变化，无论其是否能够滚动，并且还有其他的约束应用在视图上。比如，对于可以滚动的视图是没有固定内容尺寸的。对于禁用滚动的视图，默认情况下，视图的内部内容大小将根据文本的大小进行计算，而无需换行。再比如，若文本中没有回车，文本会被当做一个单行的需要布局的文本来计算宽高。若你添加约束来限定视图的宽，固定内容尺寸会根据其给定的宽度定义展示文本的高度。  
自动布局会在视图的每个方向上使用一对约束来展示视图的固定内容大小。内容会将视图向内拉伸以便视图能够紧贴着内容。压阻会将视图向外推，以便它不会切割内容。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/intrinsic_content_size_2x.png)  

这些约束会使用如清单3-5中的不相等关系来定义。在这，IntrinsicHeight和IntrinsicWidth常量代表视图的固定内容大小的高和宽值。  

清单3-5 压阻和内容紧贴方程

	// Compression Resistance
	View.height >= 0.0 * NotAnAttribute + IntrinsicHeight
	View.width >= 0.0 * NotAnAttribute + IntrinsicWidth
 
	// Content Hugging
	View.height <= 0.0 * NotAnAttribute + IntrinsicHeight
	View.width <= 0.0 * NotAnAttribute + IntrinsicWidth

这些约束每个都能够有优先级。默认的，视图对于内容使用250优先级，而对于压阻使用750优先级。所以，视图容易被拉伸，而不容易被压缩。对于大部分控件来说，这就是所需的行为。比如，你可以放心将一个按钮拉伸的比其固有内容尺寸要大；不过，若你要压缩它的话，它的内容可能就会被裁剪了。注意界面编辑器可能偶尔会修改这些优先级以便防止它们混到一起。更多相关信息，参见“设置内容聚集和压缩阻力优先级”。  
无论何时，请在你的布局中使用视图的固定内容尺寸。它会让你的布局动态的适应视图的内容改变。这也降低了你需要创建无歧义，无冲突布局所需的约束数量，但你可能需要管理视图的内容聚集和压缩阻力（CHCR）优先级。以下是一些处理固定内容尺寸的建议：  

* 当拉伸一组视图来填充一个空间时，若所有的视图都有相同的内容聚集优先级，布局就会产生歧义。自动布局就不知道要让哪个视图拉伸了。比较常见的例子是一个label和输入框。通常，你想要让输入框拉伸来填充额外的区域，而label保持其固定内容大小。要做到这点的话，要确保输入框的水平内容聚集优先级要低于label的。实际上，这个例子非常常见，所以界面编辑器自动的为你处理了，它会将所有的label的内容聚集优先级设置为251。若你使用编码方式创建布局的话，你需要自己修改内容聚集优先级。
* 奇怪和无法预期的布局通常发生在视图在不可见的背景下（比如按钮或label）偶然间拉伸超过了它们自己的固有尺寸。实际问题可能没这么明显，因为文本会直接出现在错误的位置。要防止这种不需要的拉伸发生，需要增加内容聚合的优先级。
* 基线的约束只在视图的固定内容高度上起作用。若视图是垂直拉伸或压缩的话，基线约束不会再适配成一行。
* 某些视图，比如switches，应当始终展示城他们本身固定内容的大小。应根据需要增加它们的CHCR优先级来防止拉伸或压缩。
* 应避免给定视图所需的CHCR优先级。对于给定一个视图的错误大小要比它偶然间创建一个冲突要更好一些。若一个视图应当始终在其固定内容大小的话，应考虑使用一个非常高的优先级来代替（999）。这种方法通常会让视图保持拉伸或压缩，但它仍旧提供一个临时压缩值以供你的视图展示在一个你没有预料到的更大或更小的环境下进行使用。

#### 固定的内容尺寸对比适配尺寸
对于自动布局来说，固定内容尺寸扮演的是一个输入的角色。当一个视图拥有一个固定内容尺寸时，系统会生成约束来展示该尺寸，并且约束会被用来计算布局。  
另一方面，适配的尺寸是从自动布局引擎中的一个输出。它会根据视图的约束计算视图的尺寸。若视图使用自动布局来对其子视图进行布局时，系统可能会基于其视图中的内容计算一个适当的尺寸。  
stack view 是个很好的例子。排除其他的约束，系统会基于stack view的内容和属性来计算stack view的大小。stack view会以很多种方式假设它有固定内容大小：你可以使用一个单独的垂直和水平约束定义位置来创建一个合法的布局。但是这个大小会被自动布局所计算——而非是一个自动布局的输入。设置stack view的CHCR属性没有效果，因为stack view没有一个固定的内容尺寸。  
若你想调整stack view外部的相关元素的适配大小，无论是创建一个显式的约束来跟踪其关系或者修改stack view的内容的CHCR优先级都可以。
### 解释值
值在自动布局中通常都是像素点。不过，这些尺寸的实际意义可以根据属性以及视图的布局方向变得不同。  

| 自动布局属性  | 值  | 注意 |
|:------------- |:---------------|:---------------:|
| ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_Height_2x.png) 高 ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_Width_2x.png) 宽  | 视图的尺寸 | 这些属性能够被赋值为常量或其他的高和宽属性相加。这些值不能为负值。 |
| ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_TopToSuper_2x.png) 顶部 ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_BottomToSuper_2x.png) 底部  ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_AlignMiddle_2x.png) 基准线     | 当你向下移动屏幕时，值会增加 | 这些属性只能够与纵向中心，顶部，底部和基准线属性结合。 |
| ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_LeftToSuper_2x.png) 前部 ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_RightToSuper_2x.png) 后部  | 当你朝着前部移动时，该值会增加。对于由左到右的布局方向，当你向右移动时该值会增加。对于从右到左布局方向，当你向左移动时该值会增加。 | 这些属性只能够与前部，后部或水平中心等属性结合。 |
| ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_LeftToSuper_2x.png) 左 ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_RightToSuper_2x.png) 右 | 当你向右移动时，该值会增加 | 这些属性只能够与左边，右边和水平中心等属性结合。要避免使用左边和右边属性。使用前边和后边替代。这能够让布局对视图的阅读方向进行适配。默认的阅读顺序是基于用户当前设置的语言的。不过你可以根据需要重写。在iOS当中，设置semanticContentAttribute属性会将持有约束的视图（受约束影响的所有视图最接近的共同父类）指定为从左到右切换时内容的布局是否应该翻转，以及切换从右向左的语言。 |
| ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_AlignMiddle_2x.png) 横向中心 ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/ALGuide_AlignMiddle_2x.png) 纵向中心 | 该值的解释基于等式中其他属性 |  水平中心能够与水平中心，前部，后部，右边，左边等属性结合，纵向中心能够与纵向中心，顶部，底部和基准线等属性结合。 |

## 在界面构建器中使用约束

# 自动布局手册
## Stack Views
以下方法展示了你可以使用stack view来创建布局，以增加多样性。stack view是一种能够快速简单设计你的用户界面的强有力的工具。它的属性允许对其布局排列的子视图进行高度控制。你可以额外的增加这些设定，自定义约束；不过，这也增加了布局的复杂度。  
若要查看这些方法的源代码，请参见“Auto Layout Cookbook”工程。
### 简单Stack View
以下示例使用了一个简单的，垂直的Stack View来布局一个label，image view和button。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/Simple_Stack_View_Screenshot_2x.png)

#### 视图和约束
在界面编辑器中，从拖拽一个垂直的stack view开始，然后添加flowers label，image view，以及edit button。然后向以下这样设置约束。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/simple_stack_2x.png)

	Stack View.Leading = Superview.LeadingMargin

	Stack View.Trailing = Superview.TrailingMargin

	Stack View.Top = Top Layout Guide.Bottom + Standard

	Bottom Layout Guide.Top = Stack View.Bottom + Standard

#### 属性
在属性检查器中，设置以下stack view属性：  

| Stack  | Axis(轴线)  | Alignment(对其方式) | Distribution(分布方式) | Spacing(间距) |
|:------------- |:---------------|:---------------|:---------------|:---------------|:---------------:|
| Stack View | Vertical(垂直) | Fill(填充) | Fill(填充) | 8 |

下一步，为Image View设置以下属性：  

| View(视图)  | Attribute(属性)  | Value(值) |
|:------------- |:---------------|:---------------|:---------------:|
| Image View | Image | 一张花的图片 |
| Image View | Mode(模式) | Aspect Fit |

最后，在尺寸检查器中，设置Image View的内容紧贴和压缩阻力（CHCR）优先级。

| Name(名称)  | Horizontal hugging(水平紧贴)  | Vertical hugging(垂直紧贴) | Horizontal resistance(水平阻力) | Vertical resistance(垂直阻力) |
|:------------- |:---------------|:---------------|:---------------|:---------------|:---------------:|
| Image View | 250 | 249 | 750 | 749 |

#### 讨论
你必须将stack view钉到父视图上，换句话说，stack view管理着整个布局，而无需其他显式的约束。  
在这个例子当中，stack view以一个小而标准的间距填充了其父视图。其子视图被调整为填充stack view的区域。水平方向，每个视图被拉伸为stack view的宽度。垂直方向，视图基于其CHCR优先级进行拉伸。image view应当始终调整为填充适当的区域。所以，其垂直内容紧缩和压缩阻力优先级必须要低于label和button的默认优先级。  
最后，设置image view的模式为Aspect Fit。这种设置会强制让image view调整其图片大小，以便让图片能够适应image view的大小，并且保持图片的比例。这能够让stack view 直接调整image view的尺寸，而不会造成图片的扭曲。  
更多关于固定一个视图到其父视图的相关信息，参见“属性”和“适配单一视图”部分。
### 嵌套Stack Views
本示例展示了一个使用多层嵌套stack views的复杂布局。不过，在这个例子中，stack views不能够单独创建想要的行为。还需要额外的增加一些约束来调整布局。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/Nested_Stack_Views_Screenshot_2x.png)

在视图层级构建后，添加的约束在下个段落中，“视图和约束”。
#### 视图和约束
当使用嵌套的Stack Views时，从内部向外进行布局使用是最简单的方式。从在界面构建器中布局姓名行开始，将label和text field放置在相关的正确位置上，将它们全部选中，然后点击Editor > Embed In > Stack View等菜单项。这会为这一行创建一个水平的Stack View。  
下一步，将这些行水平放置，选中它们，然后再次点击Editor > Embed In > Stack View菜单项。浙江创建一个水平的Stack View。继续布局，直到界面如下所示。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/nested_stack_views_2x.png)

	Root Stack View.Leading = Superview.LeadingMargin

	Root Stack View.Trailing = Superview.TrailingMargin

	Root Stack View.Top = Top Layout Guide.Bottom + 20.0

	Bottom Layout Guide.Top = Root Stack View.Bottom + 20.0

	Image View.Height = Image View.Width

	First Name Text Field.Width = Middle Name Text Field.Width

	First Name Text Field.Width = Last Name Text Field.Width
	
#### 属性
每个stack都有其自己的一组属性。这些属性定义了stack如何布局其内容。在属性检查器中，设置如下属性：  

| Stack  | Axis(轴线)  | Alignment(对其方式) | Distribution(分布方式) | Spacing(间距) |
|:------------- |:---------------|:---------------|:---------------|:---------------|:---------------:|
| First Name | Horizontal(水平) | First Baseline | Fill(填充) | 8 |
| Middle Name | Horizontal(水平) | First Baseline | Fill(填充) | 8 |
| Last Name | Horizontal(水平) | First Baseline | Fill(填充) | 8 |
| Name Rows | Vertical(垂直) | Fill(填充) | Fill(填充) | 8 |
| Upper | Horizontal(水平) | Fill(填充) | Fill(填充) | 8 |
| Button | Horizontal(水平) | First Baseline | Fill Equally | 8 |
| Root | Vertical(垂直) | Fill(填充) | Fill(填充) | 8 |

此外，基于 text view 一个亮灰色背景。这样能够更容易看到 text view 在设备旋转的时候是如何调整大小的。  

| View(视图)  | Attribute(属性)  | Value(值) |
|:------------- |:---------------|:---------------|:---------------:|
| Text View | Background | Light Gray Color |

最后，CHCR优先级定义了哪个视图应该被拉伸来填充可用区域。在尺寸检查器中，设置以下CHCR优先级：  

| Name(名称)  | Horizontal hugging(水平紧贴)  | Vertical hugging(垂直紧贴) | Horizontal resistance(水平阻力) | Vertical resistance(垂直阻力) |
|:------------- |:---------------|:---------------|:---------------|:---------------|:---------------:|
| Image View | 250 | 250 | 48 | 48 |
| Text View | 250 | 249 | 250 | 250 |
| First, Middle, and Last Name Labels | 250 | 251 | 750 | 750 |
| First, Middle, and Last Name Text Fields | 48 | 250 | 749 | 750 |

#### 讨论
在这一节中，stack view之间互相协作来管理大部分的布局。不过它们不能靠其自身来创建所有所需的行为。举例来说，当 image view 改变大小时，图片应该始终维持其缩放比例。不巧的是，在“Simple Stack View”中的技术在这里用不到。布局需要同时贴近图片的前边和下边，使用Aspect Fit模式会在这两个其中之一的方向上添加额外的空白。凑巧的是，在这个例子当中，图片的缩放比始终是正方形，所以你能够让图片完整的填充image view，并且强制让image view为1:1的缩放比。  

	注意：在界面编辑器中，缩放比约束是一个在视图的高和宽之间的简单的约束。界面编辑器还能够以多种方式展示约束的倍数。通常来讲，对于缩放比约束，它会展示为一个比例。所以，View.Width = View.Height约束可能展示为一个1：1的缩放比。

此外，所有的text fields应当是同等宽度。不巧的是，它们全都在不同的stack views中，所以stacks不能够对其进行管理。所以，你必须显式的增加相等宽度的约束。  
就像单一的stack view一样，你必须也同样修改一些CHCR优先级。这些优先级在父类的尺寸改变时定义了视图如何缩放。  
垂直方向，你需要将textview扩展，直到填充upper stack和button stack 的间距。所以，textview的垂直内容紧缩必须要低于其他的垂直内容紧缩优先级。  
水平方向，label应当展现为其固定内容宽度，而textfield要调整大小来填充其他的额外的区域。label默认的CHCR优先级会起作用。界面编辑器已经设置了内容紧缩为251，要让其比textfields要高；不过，你仍旧需要降低textfield的水平内容紧缩和水平压缩阻力。  
image view 应该进行压缩以便高度与stack相同，让stack包含name行。不过，stackview只会简单的包含其内容。这意味着imageview的垂直压缩阻力必须非常低，所以imageview能够压缩，而非stackview扩展。此外，imageview的比例约束使得布局更加复杂，因为它允许垂直和水平约束互相影响。这意味着textfield水平内容紧缩必须非常低，或者它能够阻止imageview压缩。不论哪种情况，都要将优先级的值设为48或更低。
### 动态Stack View
本节展示了运行时动态的从stack中添加和移除元素。所有的stack的变化都是动画形式的。此外，stackview被放到一个scrollview中，这样即使它太长了，也让你能够滚动列表来适应屏幕大小。  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/Dynamic_Stack_View_Screenshot_2x.png)

	注意：本节只是试图展示动态的使用stackview以及将stackview嵌入到scrollview中。在真实的app中，本节所展示的内容应该使用UITableview类来替代。通常来讲，你不应该使用动态的stackview来简单的实现一个tableview的临时克隆版本。而是应该使用它来动态的创建那些你无法使用其他技术简单构建的用户界面。

#### 视图和约束
初始化用户界面非常简单。将一个scrollview放到你的scene伤，然后将其调整大小使其适合scene。然后将一个stackview放到scrollview中，然后将一个按钮添加到stackview中。当所有都放置好后，设置如下的约束：  

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/dynamic_stack_view_2x.png)

	Scroll View.Leading = Superview.LeadingMargin

	Scroll View.Trailing = Superview.TrailingMargin

	Scroll View.Top = Superview.TopMargin

	Bottom Layout Guide.Top = Scroll View.Bottom + 20.0

	Stack View.Leading = Scroll View.Leading

	Stack View.Trailing = Scroll View.Trailing

	Stack View.Top = Scroll View.Top

	Stack View.Bottom = Scroll View.Bottom

	Stack View.Width = Scroll View.Width

#### 属性
在属性检查界面中，设置如下stackview属性：  

| Stack  | Axis(轴线)  | Alignment(对其方式) | Distribution(分布方式) | Spacing(间距) |
|:------------- |:---------------|:---------------|:---------------|:---------------|:---------------:|
| Stack View | Vertical(垂直) | Fill(填充) | Equal Spacing(等间距) | 0 |

#### 代码
本节需要一些代码来从stackview中添加元素以及移除元素。在你的scene上创建自定义的控制器，然后使用outlets连接scrollview和stackview。  

	class DynamicStackViewController: UIViewController {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var stackView: UIStackView!
    
    // Method implementations will go here...
    
	}

下一步，重写viewDidLoad方法来设置scrollview的初始化位置。你要将scrollview的内容设置到status bar的下方。  

	override func viewDidLoad() {
    super.viewDidLoad()
    
    // setup scrollview
    let insets = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
    
	}

然后，给添加的item button添加一个action方法。

	// MARK: Action Methods
 
	@IBAction func addEntry(sender: AnyObject) {
    
    let stack = stackView
    let index = stack.arrangedSubviews.count - 1
    let addView = stack.arrangedSubviews[index]
    
    let scroll = scrollView
    let offset = CGPoint(x: scroll.contentOffset.x,
                         y: scroll.contentOffset.y + addView.frame.size.height)
    
    let newView = createEntry()
    newView.hidden = true
    stack.insertArrangedSubview(newView, atIndex: index)
    
    UIView.animateWithDuration(0.25) { () -> Void in
        newView.hidden = false
        scroll.contentOffset = offset
    }
	}

该方法会为scrollview计算一个新的位移，然后创建一个新的view。入口视图是隐藏的，并被添加到stackview中。隐藏的视图不会影响stackview的展示或布局——所以stackview的展示会维持不变。然后，在动画block中，视图会展示出来，然后滚动位移会更新，动态的展示视图。  
添加一个类似的方法来删除入口；不过，不像addEntry方法一样，该方法在界面编辑器中不会链接到任何控件上。APP会通过编码的方式在创建视图时连接每个入口视图到方法上。  

	func deleteStackView(sender: UIButton) {
    if let view = sender.superview {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            view.hidden = true
        }, completion: { (success) -> Void in
            view.removeFromSuperview()
        })
    }
	}

该方法会在动画block中隐藏视图。在动画完成时，它会从视图层级中将视图移除。这会自动的从stackview的视图中将视图移除。  
尽管入口视图可以是任何视图，在本例中使用的stackview包含一个日期label，一个包含随机hex字符串的label以及一个删除按钮。  

	// MARK: - Private Methods
	private func createEntry() -> UIView {
    let date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    let number = "\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"
    
    let stack = UIStackView()
    stack.axis = .Horizontal
    stack.alignment = .FirstBaseline
    stack.distribution = .Fill
    stack.spacing = 8
    
    let dateLabel = UILabel()
    dateLabel.text = date
    dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    
    let numberLabel = UILabel()
    numberLabel.text = number
    numberLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
    let deleteButton = UIButton(type: .RoundedRect)
    deleteButton.setTitle("Delete", forState: .Normal)
    deleteButton.addTarget(self, action: "deleteStackView:", forControlEvents: .TouchUpInside)
    
    stack.addArrangedSubview(dateLabel)
    stack.addArrangedSubview(numberLabel)
    stack.addArrangedSubview(deleteButton)
    
    return stack
	}
 
	private func randomHexQuad() -> String {
    return NSString(format: "%X%X%X%X",
                    arc4random() % 16,
                    arc4random() % 16,
                    arc4random() % 16,
                    arc4random() % 16
        ) as String
	}
	}

#### 讨论
如本节所展示的，视图能够在运行时从stackview中添加或移除。stackview的布局会自动的调整补充其管理的视图数组的变化。不过，以下是一些比较重要的点需要注意：  

* 隐藏的视图依旧存在于stackview的视图序列中。不过，它们并不展示，且不会影响其他视图的布局。
* 添加一个视图到stackview的视图数组中会自动的将其添加到视图层级中。
* 从stackview的视图数组中移除一个视图，不会自动的将其从视图层级中移除；不过，从视图层级中移除视图会将其从视图数组中移除。
* 在iOS中，视图的hidden属性通常不会动画展示。不过，该属性会在视图被放置到stackview的视图数组中时变得可以动画展示。实际的动画是被stackview所管理的，而非视图。使用hidden属性来以动画的方式从stackview中添加或移除视图。

本节同样介绍了使用自动布局来布局scrollview的方法。在这里，stackview和scrollview之间的约束会设置scrollview的内容区域大小。一个等宽的约束会显式的设置stackview来填充scrollview的水平区域。垂直方向，内容区域大小会基于stackview的适配大小。stackview会随着用户添加更多而变得更长。滚动会在屏幕上包含太多内容时自动启动。    
更多信息，参见“使用Scrollviews”。

## 简单约束

## 拥有固定内容尺寸的视图

# 调试自动布局

# 高级自动布局

## 编码方式创建约束

### 布局锚点

### NSLayoutConstraint类

### 可视化格式语言

## 尺寸类特定布局

## 结合滚动视图

## 结合自适应列表视图单元格

## 改变约束

# 附录