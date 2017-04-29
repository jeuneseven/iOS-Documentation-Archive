[Programming with Objective-C 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210)

# 关于OC
在为OS X和iOS编写软件时，OC是一门主要使用的编程语言。这是一个C语言的超集，提供面向对象的功能以及动态运行时能力。OC继承了C语言的语法、原始数据类型以及流控制语句，并且添加了典型的类和方法语法。它还为对象的管理提供了语言级别的支持，并且在动态类型绑定时提供了对象字面量，将很多职责推迟到了运行时。
## 概览
本文档对于OC语言进行了介绍，并且提供了大量的使用示例。你将会学到如何生成你自己的类来描述自定义的对象以及看到如何使用Cocoa和Cocoa Touch层提供的框架来工作。尽管这些框架是与语言本身分离的，但是在使用OC编码时，还是紧密相关的，并且这些框架的类提供了很多语言层级的功能。
## 一款app是由网络对象构成的
当为OS X或iOS编写app时，你会花费大量的时间在对象上。这些对象是OC中类的实例，它们中的一部分是由Cocoa和Cocoa Touch提供的，还有一部分是由你自己创建的。  
如果你自己写类的话，应该从描述一个打算公开的有实例变量的类开始。这个接口包含了公共的属性来封装相关的数据，还有一些方法。方法声明了一个对象能够接收的消息，并且包含了当该方法被调用时需要传递的参数信息。你还应该实现这个类，包含头文件中你声明的每个方法。  
`相关章节：定义类、使用对象、封装数据`
## 分类扩展已经存在的类
你如果想为一个已经存在的类扩展一个小功能的话，你无需创建一个全新的类，你可以为这个类定义一个分类来添加自定义的行为。你可以使用分类为任何类添加方法，甚至包括你没有源代码实现的类，例如框架类中的NSString。  
如果你拥有一个类的源代码的话，你可以使用类的延展来添加新的属性，或者修改已经存在的属性。类的延展通常用来隐藏私有的行为，无论是在一个单独的源代码文件中还是在一个私有的自定义framework实现中。  
`相关章节：自定义已经存在的类`

## 协议定义了信息的契约形式
一个OC的app的主要工作就是以对象之间互相发送消息的形式出现。通常来讲这些消息由类的头文件中明确定义的方法来定义。然而有时候定义一些不直接绑定在一个特定类中的相关方法也是常有的。  
OC使用协议来定义一组相关的方法，例如方法由一个对象的delegate调起，代理方法有选定或者必须的。任何类都可以声明它遵守了一个协议，这意味着它必须实现所有在协议中要求的必须实现的方法。  
`相关章节：使用协议`

## 值和集合类通常表现为OC的对象
通常在OC中使用Cocoa或Cocoa Touch的类来表达一个值。NSString类表达一组字符串，NSNumber类是为多种不同类型的数字准备的，例如整形或者浮点型，NSValue类为各种C结构的类准备的。你还可以使用各种由C语言定义的原始数据类型，例如int，float或者char。  
集合通常表现为一种集合类的实例，例如NSArray, NSSet, 或者NSDictionary，这些通常用在收集其他OC对象上。  
`相关章节：值和集合`

## Block简化了常用任务
Block是一个语言级别的功能，C、OC以及C++当中都引入了该功能，它代表了一组工作集合；它将一块代码连同捕获的状态进行封装，这很像。其他编程语言当中的闭包功能。block通常用来简化日常的任务，例如集合的枚举、排序和测试等。它还简化了为并行或者异步执行的设计的GCD的预定任务。  
`相关章节：使用Block`

## error对象通常用来解决运行时问题
尽管OC为异常捕获提供了语法，Cocoa和Cocoa Touch通常仅仅在编程的错误中（例如数组越界）使用异常，这一般在app发布前就解决了。  
所有其他的错误，包含运行时问题，例如运行在非磁盘空间或者无网状态，这些都包含在NSError类的实例中。你的app必须为错误做好准备，以最佳的方式处理这些错误，当错误发生的时候，你最好给用户提供最佳的体验。  
`相关章节：处理error`

## OC代码服从既定惯例
当编写OC代码的时候，你应该时刻记住一些既定的编码惯例。例如方法名应该使用小写字母开头，使用驼峰命名法；例如，doSomething 和 doSomethingElse。当然，不只是大小写那么简单，你要确保你的代码尽可能的可读性，意思是你的方法名尽量更具有丰富性，而不是冗长啰嗦。  
此外，还有一些惯例需要注意，如果你想用好这门语言或者它的类库功能的话。例如，属性的存取器方法，必须严格执行命名规范，以便更好的配合KVC（键值编码）或者KVO（键值监听）使用。  
`相关章节：惯例`

## 预备知识
如果你是个OS X或者iOS开发新手的话，你应该在看本文档之前先阅读《从今天开始开发iOS app》或者《从今天开始开发Mac app》，这样可以对iOS和OS X的开发过程有一个大致的了解。此外，你应该比较熟悉Xcode，这样你在练习本文档每个章节后面的练习时会比较顺手。Xcode是用来开发iOS和OS X的IDE；你在写代码，设计你app的用户界面，测试你的app以及debug问题的时候会用到它。  
尽管如果你比较熟悉C或者基于C的语言例如java或者C#的话会比较好，但是本文档已经包含了一些示例，这些示例是基于C语言的，例如流控制语句等。如果你了解其他更高层级的编程语言，例如Ruby或者Python，你应该能够跟上进度。  
尽管在面向对象设计原则上已经有了合理的覆盖，特别是应用在OC上下文中，但是我们假设你已经对于面向对象的概念已经有了一些基本的了解。如果你对于这些概念不了解的话，你应该阅读《OC编程语言概念》相关的章节。
## 另请参阅
本文档应用在Xcode4.4及更高版本上，并且假设你的OS X版本是不低于10.7的，iOS版本不低于5.更多关于Xcode的信息，参阅Xcode用户指南。更多关于语言功能的介绍，参见OC功能索引。  
OC的app使用引用计数功能来决定对象的生命周期。大部分情况下编译器的ARC（自动引用计数）功能会为你处理好一切。如果你不使用ARC的话，或者需要维持一些比较旧的使用手动管理内存的代码，你应该阅读高级内存管理编程指南。  
除了编译器之外，OC语言使用了运行时系统来提供动态类型和面向对象功能。尽管你无需关心OC代码是如何运行的，但是还是应该尽可能的深入了解下运行时系统，这些在OC运行时编程指南和OC运行时参考中都有所介绍。

# 定义类
当你编写OS X和iOS的软件时，大部分时间你都会和对象打交道。OC当中的对象和其他面向对象编程语言中的对象是类似的：封装数据、关联行为。  
一个app是基于一组生态和一堆相互关联相互调用解决问题的对象来构建的，比如我要展示一个可视界面，响应用户的输入，或者存储信息。对于OS X或者iOS开发而言，你无需从头构建解决可能遇到的问题的对象；cocoa（为OS X提供）和cocoa touch（为iOS提供）已经为你构建了一大堆类库和存在的对象供你调用。  
这些对象当中的一部分可以立即使用，例如基本数据类型像字符串，数字这种，或者用户界面元素，像按钮，列表这种。还有一些可以根据你自己的需要去自己定制。软件开发过程其实就是如何将底层框架提供的对象与你自己定制的对象更好的结合，为你的app提供独一无二的功能的过程。  
在面向对象编程的关系中，对象是类的一个实例。本章阐述了如何在OC中通过声明接口定义一个类，接口描述了你的类打算做的事，以及实力对象要使用的事。这个接口包含了类能够接受的消息列表，你需要去提供类的实现，这包含响应每个消息的代码。  
## 类是对象的模板
类为各种类型的对象定义了通用的行为和属性。对于字符串对象来讲（OC中，这是个NSString类的实例对象），该类提供了多种方法去检验和转换它需要展示的内部的字符。同样的，一个用来展示数字对象的类（NSNumber）对其内部的数字值提供了函数，例如转换一个值到另一种不同类型的值。  
在结构上以同样的模板以同样的方式构建不同的结构这种方式是固定的，每个类的对象与该类其他的对象共享着同样的属性和行为。每个NSString类的实例对象的行为是一致的，不论它内部持有的字符串是否相同。是 
每个特殊的对象被设计用来做特殊的事情。你可能知道一个字符串对象表达一些字符串，但是你无需知道它内部的存储这些字符串的机制。你不知道任何字符串对象处理字符的内部行为，你只需知道如何使用这些字符串对象就可以了，可能你需要知道其中的某些特殊字符，或者请求一个新的对象用来将原来的对象转换成大写。  
在OC当中，类的接口指定了一个对象可以被其他对象调用的方式。换句话说，它定义了类的对象和外部环境的公共接口。  
### 可变性决定了一个表达的值是否能够被改变
有一些类定义对象是不可变的。意思是它的内容必须在对象创建的时候被设置，并且不能被之后其他的对象所修改。在OC当中，所有基本类型NSString和NSNumeber类型的对象都是不可变的。如果你想表达一个不一样的数字的话，你必须声明一个新的NSNumber对象。  
有些不可变的类也提供可变的版本。如果你需要在运行时改变内容的话，例如，从网络上接收的字符串要追加到字符串后面，你可以使用NSMutableString类的实例对象。这种类型的对象和NSString类的对象表现的一样，只不过它还提供函数来改变对象表达的字符串。  
尽管NSString和NSMutableString是不同的类，它们还是有很多相似的。无需从头构建两个完全分开的类且具有相似的行为，通常这种情况使用继承。
### 类从其他类继承
在现实世界中，分类学将动物以属、种以及类进行分组。这些分组是分层级的，例如多个属都属于同一个种，多个种同属于同一个类。  
例如大猩猩，人类以及猩猩都有很多明显的不同。尽管它们属于不同的种、不同的属、不同的部落以及不同的亚科，但是在分类学上它们属于同一个科（被称作人科）见图1-1。  

图1-1 不同物种之间的分类学关系  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/humansgorillas.png)  

在面向对象的编程世界中，对象也被以继承来分类成组。不像属和类那样有着严格的等级区分，对象被以类为组织区分。像人类从人科当中继承的主要特征那样，类可以从父类那里继承各种功能。  
当一个类从另一个类继承时，父类的所有行为和属性都被子类继承。它还可以定义自己的特殊行为和属性，或者重写父类的行为。  
在OC的字符串类当中，NSMutableString类的描述继承自NSString类，见图1-2。所有NSString类提供的函数在NSMutableString类当中都可以使用，比如查询特殊字符或者字符串大写，但NSMutableString  添加了方法让你能够追加、插入、替换或者删除子字符串或单个字符串。

图1-2 NSMutableString类的继承。

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/nsstringmutablestring.png)  

### 根类提供基本的函数功能
和所有的生命体共享“生命”这种基本特征一样，在OC中也有一些函数是所有的对象共用的。  
当一个OC对象想要和其他类的实体对象一起工作时，最好其他的对象提供一些基本的特征和行为。出于这个原因，OC定义了一个根类让大量的类来继承，叫做NSObject类。当一个对象遇到另一个对象时，它期待最好能够使用一些NSObject类定义的基本行为。  
当你定义你自己的类时，你最起码应该继承自NSObject。一般来讲，你应该从Cocoa 或 Cocoa Touch 类中找到一个具有你需要的最相近的功能的类来继承。  
举个例子，如果你想在iOS app中自定义一个按钮的话（并且提供的UIButton类无法满足你订制需要），你最好创建一个继承自UIButton的类，而不是继承自NSObject。如果你直接从NSObject类继承的话，你需要做很多UIButton类已经做过的复杂的视觉交互工作，才能让你的按钮看上去像用户想要的一样。此外，从UIButton继承的话，你的子类自动继承了UIButton类的所有功能和行为。  
UIButton类继承自UIControl类，后者定义了在iOS上的所有用户交互的基本行为。UIControl类继承自UIView类，后者定义了展现在屏幕上的对象的基本功能。UIView类继承自UIResponder类，后者定义了响应用户行为的功能，例如点击，手势或者晃动等。最终，UIResponder类继承自NSObject类，见图1-3。  

图1-3 UIButton继承链

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/buttoninheritance.png) 

该继承链的意思是，任何继承自UIButton的类都会不尽继承了所有UIButton类定义的函数，也继承了所有其父类的函数。你定义的对象的行为可以表现的像一个button，可以将其本身展示在屏幕上，响应用户的点击，以及与其他基于Cocoa Touch类的对象交互。  
记住这种继承者链条在你以后的开发当中是很重要的，这能让工作正常进行。例如，Cocoa 和 Cocoa Touch的开发文档当中很容易看到一个类继承自它的父类的声明。如果你在一个类中无法找到你需要的接口或者参考的话，你最好定义一个，或者在文档中查找它的父类。

## 类的头文件定义了类的预期
面向对象编程的众多功能之一就是上述提到的：你只需要使用一个类来作用于它的实力对象。更具体的说，一个对象应该呗设计成隐藏其内部实现的样子。  
举例来说，如果你在iOS app中使用一个标准的UIButton，你不用操心按钮在屏幕上显示的像素是如何展现的。你只需知道你能够改变它内部的一些属性，比如按钮的标题，颜色，并且相信当你添加按钮到你的屏幕上时，它能够正常显示，并且功能合乎你的预期。  
当你定义你的类时，你应该预估那些公有的属性和行为。那些属性是你想公开让其他类来访问的？你想让这些类被改变么？其他的对象如何和你的类的尸体对象进行交互？  
这些信息将会反应在你的类的头文件中——它定义了其他类如何与你的类的实例变量进行交互。公有的接口已经与内部的行为隔离开了，这被称作实现文件。在OC中，接口和实现文件被分开成单独的文件了，这样你只需要关心公开的接口。  
### 基本语法
OC中声明一个类的头文件的语法如下：  
> @interface SimpleClass : NSObject
> 
> @end

该示例声明了一个类，名叫SimpleClass，继承于NSObject。  
公有的属性和行为都被定义在 @interface 中。在这个示例中，没有声明什么方法，所以在SimpleClass类的实例变量中中只能使用从NSObject类继承的方法。  

### 属性控制了访问一个对象的值的渠道
对象通常会有一些属性用于公开的访问。比如，你在一个记录类的app中定义了一个类表示人类的话，你可能需要一些字符串的属性来表示一个人的姓名。  
定义这些属性需要将其添加到头文件中，像这样：  
> @interface Person : NSObject
>
> @property NSString *firstName;  
> @property NSString *lastName;
> 
> @end  

在这个示例中，Person类声明了两个公开的属性，两个都是NSString类型的变量。  
两个属性都是OC类型的对象，所以用星号来表示它们是C的指针。它们像其他在C中声明的变量一样，所以在句尾有个分号。  
你可能还需要添加一个人的生日，用在根据年龄排序当中。你可以使用一个数字类型的对象属性来表示：  
> @property NSNumber *yearOfBirth;

但是如果仅仅是存储一个简单的数字值的话，这可能有点过于麻烦了。有一种方式是使用C提供的基本数据类型，可以存储标准值，例如integer：  
> @property int yearOfBirth;

#### 属性的声明表明了数据存储的可能性注意事项
之前展示的示例中所有声明的属性都是完全公开访问的。意思是其他的对象可以随意的读取和改变这些属性的值。  
在某些情况戏，你可能需要去声明一个不可以被更改的属性。在现实世界中，一个人可能需要填写一大堆表格来更改他的姓名。如果你在编写一款比较正规的记录统计信息的app，你可能需要将一个人的姓名属性标记为只读，由一个中间的对象来验证是否能够通过修改属性的请求。  
OC的属性声明在属性列表中，所以应该指出一个属性是否应该是只读。在一个正规的记录统计信息的app中，一个Person类的接口应该像如下这样：  
> @interface Person : NSObject  
> @property (readonly) NSString *firstName;  
> @property (readonly) NSString *lastName;  
> @end

属性的声明应该在@property关键字之后的括号当中，这在“声明公开的属性”中有详细描述。  
### 方法声明象征着一个对象可以接受的信息
到目前为止的示例解决了一个类描述典型的对象的样子，或者是一个对象被设计用来封装数据的样子。在Person这个类的示例中，很有可能无需任何函数通过访问两个声明的属性。然而类的初衷是除了声明的属性之外，还要包含一些行为。  
OC构建的软件都是基于一大堆网络层的对象的，这些对象之间相互通信通过发送消息。在OC中，一个对象发送给另一个对象消息是通过调用那个对象的方法来实现的。  
OC的函数在概念上和标准的C或者其他编程语言中的函数类似，不过语法比较特别。一个C的函数声明像这样：  
> void SomeFunction();

等价的一个OC的函数声明像这样：  
> -(void)someMethod;

在这个示例中，函数没有参数。C当中的void关键字用括号括起来放在声明的前部表示该函数完成后没有返回值。  
函数最前方的减号代表它是一个实例方法，该方法可以类的任意对象调用。这与类方法不同，类方法只能被类本身调用，这在“OC的类同样也是对象”中有所描述。  
作为C的函数原型，一个函数在OC的头文件中声明，要像其他的C语句一样，句尾会有个分号。
#### 函数可以携带参数
如果你需要声明一个带一个或多个参数的函数，语法上会和标准的C函数有些不同。  
对于C的函数，参数会放置在括号中，类似这样：  
> void SomeFunction(SomeType value);

一个OC的函数声明包含了参数的名称，使用冒号来修饰，像这样：
> -(void)someMethodWithValue:(SomeType)value;

像返回值那样，参数的类型也被放在括号当中，就像标准的C函数一样。  
如果你需要提供多个参数的话，语法依旧和C不太一样。C函数中，多个参数会方在括号当中，然后用逗号隔开；在OC中，带有两个参数的函数会是这样：  
> -(void)someMethodWithFirstValue:(SomeType)value1 secondValue:(AnotherType)value2;

在这个示例中，value1 和 value2 是在实现体中当函数被调用时要用到的变量名，所以它们是变量。  
在一些编程语言中，允许函数定义所谓的命名参数；这在OC当中可不是这样的。函数的参数必须和函数的声明相匹配，secondValue:是函数声明名称中的一部分：  
> someMethodWithFirstValue:secondValue

这是让OC变成一门可读性很强的语言的很重要的一个功能，因为通过一个函数传递的值是指定内联的，函数名相关的部分在“你可以为函数参数传递对象”中有所描述。  

	注意：value1 和 value2这两个词严格来讲不算是函数声明的一部分，意思是在实现体当中，你无需使用相同的名称。唯一需要注意的是标签的匹配，意思是你必须确保函数的参数和返回值类型在头文件和实现体中完全相同。  
	作为示例，这里有个同样标签的函数如下：
	- (void)someMethodWithFirstValue:(SomeType)info1 secondValue:(AnotherType)info2;  
	这是两个和上面的函数不同的标签的函数：  
	- (void)someMethodWithFirstValue:(SomeType)info1 anotherValue:(AnotherType)info2;  
	- (void)someMethodWithFirstValue:(SomeType)info1 secondValue:(YetAnotherType)info2;
### 类名必须是独一无二的
要注意，在一个app当中，每个类名都是独一无二的，即使是通过包含一个第三方的类库或者框架。如果你想创建一个新的和已经存在的类相同的类名的话，你会收到一个来自编译器的error提示。  
由于这个原因，你可以定义你自己类的一个前缀，前缀应该使用三个或者更多的字母。这些字母应该和你正在编写的app相关，或者和可重用的框架相关，或者就是你的姓名的首字母。  
本文档其余的示例都会有类的前缀，类似这样：  
> @interface XYZPerson : NSObject  
> @property (readonly) NSString *firstName;  
> @property (readonly) NSString *lastName;  
> @end

	历史原因：如果你好奇为什么那么多你遇到的类都是以NS作为开头的话，这是因为Cocoa 和 Cocoa Touch的原因。Cocoa当初作为NeXTStep操作系统的集合类框架。当苹果在1996年收购NeXT时，很多NeXTStep都被收入了 OS X 当中，包括很多已经存在的类。Cocoa Touch作为iOS上Cocoa的等价框架；很多类在 Cocoa 和 Cocoa Touch中都能够使用，还有很多类是这两个平台独有的。  
	两个字母的前缀，比如NS和UI（用在iOS中的用户界面元素中）为Apple的保留关键字。
	
相比之下，函数和属性名称只需要在定义它们的类中唯一就可以了。尽管在一个app中，每个C函数都应该是唯一的命名，在OC中的多个不同类里定义相同的函数名是可以接受的。然而，你不能在同一个类中定义同样的方法超过一次，尽管你可能要从父类继承一个函数并重写它，你必须用原来那个函数同样的名称。  
同函数一样，一个对象的属性和变量（在“大部分属性依赖实例变量”中有相关描述）在同一个类中必须是唯一的。然而，如果你使用全局变量的话，在一个app或者工程中，命名必须唯一。  
更多命名规则和建议参见“命名规则”。
## 方法的实现体提供了它内部的行为
一旦你为一个类定义了接口，包括属性和函数供外部访问，你需要编码实现类的这些行为。  
如上文所述，一个类的接口通常放在专门的文件当中，通常被称作头文件，一般都会有.h作为文件的结尾。你编码实现的OC类通常放在.m结尾的实现体文件中。  
无论何时，你的头文件当中定义的接口，编译器都会被告知这些是在实现体中实现了并且要被编译的。OC为这种情况提供了一个预编译命令，#import。这跟C当中的#include命令类似，但是它确保了一个文件在编译的过程中只被引用一次。  
要注意，预编译命令与传统的C当中的有所不同，它无需在结尾添加分号。
### 基本语法
类的实现体的基本语法类似这样：  
>	 #import "XYZPerson.h"
> 
> @implementation XYZPerson
> 
> @end

你在头文件中定义的接口，在实现文件中都要实现。
### 实现函数
一个简单的带有一个函数的类的头文件是这样的：  
> @interface XYZPerson : NSObject  
> -(void)sayHello;  
> @end

它的实现体是这样的：  
> 	#import "XYZPerson.h"
> 
> @implementation XYZPerson  
> -(void)sayHello {  
>    NSLog(@"Hello, World!");  
> }  
> @end

这个示例用到了NSLog()函数，在控制台打印了语句。这很像标准C当中的 printf() 函数，它可以带有多个可变的参数，第一个必须是字符串。  
函数的实现体很像C的函数定义，使用大括号将相关代码括起来。此外，函数名必须和它的原型相同，参数和返回值也是匹配的才行。  
OC继承了C的大小写敏感属性，所以函数：  
> -(void)sayhello {
> 
> }

所以对于编译器而言，它是和sayHello函数完全不同的两个函数。  
通常来讲，函数名使用小写字母开头。OC当中通常使用更具有描述性的名称为函数命名，而不是以往在C中看到的那样。如果一个函数名包含多个单词的话，请使用驼峰命名（每个新单词的首字母大写）使它们更便于阅读。  
请注意，空格在OC当中也是很灵活的。通常每行代码的缩紧使用tab或者空格键，并且你会经常看到左大括号在一个单独行当中，类似这样：  
> -(void)sayHello  
> {  
>    NSLog(@"Hello, World!");  
> }

Xcode，Apple为OS X和iOS开发提供的集成开发环境（IDE），会根据定制的用户习惯自动为你的代码锁进。参见《改变缩进和tab宽度在Xcode工作空间指南》相关信息。  
在下一章中，你将会看到很多的函数实现示例，“使用对象”。
## OC的类同样是个对象
在OC当中，一个类作为对象有一个隐藏的类型叫做Class。类是不能够像实例变量那样，定义自己的属性语句的，但是它们可以接受消息。  
类方法的典型用法是工厂方法，这是一种替代分配内存和初始化对象的方法，这在“对象是动态创建的”当中有所描述。例如，NSString类，包含了很多工厂方法来创建空字符串对象或者指定初始化的字符串，包括：  
> +(id)string;  
> +(id)stringWithString:(NSString *)aString;  
> +(id)stringWithFormat:(NSString *)format, …;  
> +(id)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error;  
> +(id)stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc;

在这些示例中，类方法被标记为＋方法，这与实例方法的－方法不同。  
类方法的原型一般会包含在一个类的头文件中，就像实例方法的原型那样。类方法的实现和实例方法一样，都放在类的@implementation括号中。
## 练习
	注意：为了便于练习每个章节末尾的练习，你应该去创建一个Xcode工程。这样能够让你的代码编译起来没有报错。  
	使用Xcode的新工程模板来创建一个命令行工具。当提示的时候，选择工程类型为Foundation。

1. 使用Xcode新文件模板创建OC的一个类XYZPerson的头文件和实现体文件，继承于NSObject。
2. 在XYZPerson类中为一个person添加姓名、生日（NSDate类的一个实例）等属性。
3. 像之前章节提到的那样，声明sayHello方法，并实现它。
4. 为这个类添加一个工厂方法，名字叫“person”。读完下一章节后再实现它。

> 注意：如果你编译代码的话，你会由于没有实现代码而得到一个编译器的警告“未实现函数”。

# 使用对象
一个基于OC的app是一套对象之间来回发送消息的生态系统。其中一部分是Cocoa 或 Cocoa Touch类的对象，一部分是你自己自定义的对象。  
之前的章节描述了一个类的接口和实现体的语法，包括实现一个函数的语法来响应调用信息。本章描述了如何发送消息给一个对象，包含了一些OC的动态特性，包括动态特性，以及决定在运行时哪个函数应该被调用的能力。  
在一个对象被使用前，应该在适当的时机为它的属性分配内存，并且初始化它内部的值。本章描述了如何构造函数调用来配置一个对象的内存和初始化。
## 对象发送和接收消息
尽管在在OC中的对象之间发送消息有很多种方法，不过到目前为止，最通用的语句是使用中括号，类似这样：  
>     [someObject doSomething];

左边的someObject代表消息的接受者。右边的doSomething是消息接受者的函数名。换句话说，如果上述语句被执行的话，someObject将会发送doSomething消息。  
之前的章节描述了如何创建一个类的头文件，类似这样：  
> @interface XYZPerson : NSObject  
> -(void)sayHello;  
> @end

以及如何创建一个类的实现文件，类似这样：  
> @implementation XYZPerson   
> -(void)sayHello {  
>     NSLog(@"Hello, world!");  
> }  
> @end

	注意：该示例使用了OC的字符串字面量@"Hello, world!"。字符串是众多OC类当中的一个，它可以使用一个简短的字面量语句就可以创建。 @"Hello, world!"可以概念性的等同于说“一个OC的字符串对象，表示了一个字符串 Hello, world!”
	字面量以及对象的创建在“对象的动态创建”当中会有更深入的解释，在本章之后。

我们假设你已经创建了一个XYZPerson类的对象，你可以给它发送sayHello消息，类似这样：  
>     [somePerson sayHello];

发送一个OC的消息概念上非常像调用C函数。图2-1展示了sayHello消息的程序流程。    

图2-1基本的消息程序流  
![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/programflow1.png)  
  
为了指定消息的接受者，理解在OC中指针是如何指向一个对象是很重要的。  
###使用指针追踪对象
C和OC和其他的编程语言一样，使用变量来跟踪值的变化。  
这有一些标准C当中定义的标准变量类型，包括整型，浮点型以及字符型，它们声明和赋值类似这样：  
> int someInteger = 42;  
> float someFloatingPointNumber = 3.14f;

局部变量，意思是变量声明在一个方法或函数中，类似这样：  
> -(void)myMethod {  
>     int someInteger = 42;  
> }

局部变量的作用于是在声明它们的方法中。  
在这个示例中，someInteger是声明在myMethod函数中的一个局部变量；一旦执行到大括号的结束，someInteger就不能够被访问了。当一个局部的标准变量（例如int、float）销毁的时候，它的值也会跟着销毁了。  
相比之下，OC的对象在分配内存时会有一些不同。对象通常比函数具有更长的生命周期。尤其是一个对象需要比它跟踪的原始变量有更长的生命周期，所以一个对象的内存初始化和销毁是动态的。  

	注意：如果你经常操作堆栈的话，局部变量是分配在栈空间上的，而对象是分配在堆上的。

这需要你用到C的指针（它会持有内存地址）追踪它们在内存中的地址，类似这样：  
> -(void)myMethod {  
    NSString *myString = // get a string from somewhere...  
    [...]  
}  

尽管指针变量myString（星号代表它是个指针）的作用域是在myMethod函数内的，但是内存中的指针指向的实际字符串对象在作用域之外具有更长的生命周期。比如你在其他的函数中給它传值的话，它可能还会存在。  
### 你可以给函数的参数传递对象
如果你在发送消息的时候传递对象的话，你可以将一个对象的指针赋給一个函数的参数。之前的章节我们描述了声明一个只带一个参数的函数语法：  
> -(void)someMethodWithValue:(SomeType)value;

所以，带有一个字符串对象的函数语法会是这样：  
> -(void)saySomething:(NSString *)greeting;

你需要实现saySomething:函数，像这样：  
> -(void)saySomething:(NSString *)greeting {. 
    NSLog(@"%@", greeting);  
}  

greeting指针表现的像一个局部变量，并且其作用域是在saySomething: 函数内，尽管在函数调用之前实际的字符串对象就已经存在，并且在函数结束后会持续存在。  
	
	注意：NSLog()使用了格式化说明符指代对应的内容，这很像C标准库当中的printf()函数。在控制台输出的字符串是格式化修饰符（第一个参数）插入提供的值（其余参数）的结果。  
	此外，还有一个OC提供的替换符，%@，用来表示一个对象。在运行时，该替换符会输出指定对象的descriptionWithLocale:（如果存在该方法的话）或者description方法的结果。description函数是NSObject实现的，它返回类名以及对象的内存地址，不过很多Cocoa和Cocoa Touch类通过重写它来提供更多的有用的信息。比如NSString的description函数会返回它要表示的字符串集合。  
	更多关于使用NSLog()的格式化符号和NSString类的相关信息，参见“字符串格式化说明”。

### 函数能够有返回值
同通过参数传递值的函数一样，一个函数有返回值也是可以的。到目前为止，本章展示的函数的返回值都是void类型。在C当中，void这个关键字的意思是该函数没有返回任何值。  
指定一个返回值类型是int型意思是该函数会返回一个标准的整形数：  
> -(int)magicNumber;

该函数的实现使用了C的return语句，表明该函数执行完毕后，应该返回一个值，类似这样：  
> -(int)magicNumber {  
    return 42;  
}

在使用过程中忽略一个函数的返回值也是可以接受的。在这个示例中，magicNumber函数除了返回一个值之外，没有做什么有用的事情，但是这样去调用一个函数没有任何问题：  
> [someObject magicNumber];

如果你确实需要跟踪返回值的话，你可以定义一个变量，然后将函数的结果赋值给它，类似这样：  
> int interestingNumber = [someObject magicNumber];

你可以使用同样的方法返回一个对象。例如，NSString类提供了一个uppercaseString函数：  
> -(NSString *)uppercaseString;

就像一个函数返回一个整形值一样，你可以使用一个指针来跟踪函数的返回值：  
> NSString *testString = @"Hello, world!";  
  NSString *revisedString = [testString uppercaseString];

当函数返回后，revisedString将指向一个NSString类的对象，该对象表示字符串HELLO WORLD!  
记住，实现一个有返回值的函数时候，类似这样：  
> -(NSString *)magicString {  
    NSString *stringToReturn = // create an interesting string...  
   
    return stringToReturn;  
}

该字符串在返回一个值之后，依旧存在，即使是stringToReturn指针已经在作用域外。  
有一些情况需要考虑内存管理问题：从堆上创建的对象类型的返回值需要存在足够长的时间，以供调用它的函数来使用，但是不会永远存在下去，因为这会造成内存泄漏。大部分情况下，OC编译器提供的ARC（自动引用计数器）功能会为你处理这些情况。
###对象可以給它们自己发送消息
无论何时你去实现一个函数，你都可以访问一个隐藏的值，self。概念上来讲，self是一种“对象接受这个消息”的方式。就像上文提到的greeting值一样，它也是一个指针，并且可以用在当前接受的对象用来调用函数。  
你可能打算重构XYZPerson类的实现，通过修改sayHello为saySomething:，然后将NSLog()的调用放置在不同的方法中。你还可以再添加一个函数，比如sayGoodbye，这会每次都通过调用saySomething函数来控制实际的打招呼过程。如果你以后需要显示一个打招呼的语句在用户界面上的一个输入框中的话，你就得改写saySomething:函数了，而不是通过去实现每个打招呼的函数。  
新的实现方式是使用self来调用当前对象的函数，类似这样：  
> @implementation XYZPerson  
-(void)sayHello {  
    [self saySomething:@"Hello, world!"];  
}  
-(void)saySomething:(NSString *)greeting {  
    NSLog(@"%@", greeting);  
}  
@end  

如果你使用这份更新过的实现的话，你给一个XYZPerson对象发送sayHello消息的时候，程序的运行效果是类似于图2-2一样。  

图2-2 当给self发送消息时程序的运行流程    

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/programflow2.png)

###对象可以调用它父类实现的函数
在OC中，还为你保留了一个很重要的关键字，super。发送一个消息给super是一种通过继承链条调用父类实现的函数的方法。通常使用super的时机是在重写一个方法的时候。  
我们假设你要实现一个新类型的person类，一个shouting person类，它显示的每个字母都是大写的。你可以创建一个重复的XYZPerson类，然后修改每个字符串为大写，不过最简单的方法应该是继承自XYZPerson类，然后重写saySomething:函数，这样你的每个显示的字母都能够大写了，类似这样：  
>@interface XYZShoutingPerson : XYZPerson  
@end

> @implementation XYZShoutingPerson  
- (void)saySomething:(NSString *)greeting {  
    NSString *uppercaseGreeting = [greeting uppercaseString];  
    NSLog(@"%@", uppercaseGreeting);  
}  
@end

这个例子又定义了一个额外的字符串指针：uppercaseGreeting，并且调用greeting 的uppercaseString函数，然后将返回值赋值给它。就像你之前看到的那样，这会创建一个新的字符串，转换原字符串的所有字母为大写。  
由于sayHello函数是被XYZPerson类实现的，XYZShoutingPerson类是继承自XYZPerson类，所以你也可以用XYZShoutingPerson的对象调用sayHello函数。当你调用XYZShoutingPerson 类的 sayHello函数时调用[self saySomething:...] 会使用重载的实现函数，并且展示的是全都是大写的字母，结果请看图2-3。  

图2-3 调用重载函数的程序流程  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/programflow3.png)  

然而，新的实现方法不太理想，因为如果你以后打算修改XYZPerson 类的 saySomething: 函数，来展示一个用户界面元素，而不是只是输出语句的话，你就需要再修改XYZShoutingPerson的实现了。  
一个更好的方式是修改XYZShoutingPerson 类的 saySomething:函数实现，通过调用它的父类（XYZPerson）的实现来达到目的：  
> @implementation XYZShoutingPerson  
- (void)saySomething:(NSString *)greeting {  
    NSString *uppercaseGreeting = [greeting uppercaseString];  
    [super saySomething:uppercaseGreeting];  
}  
@end  

现在，如果给一个XYZShoutingPerson类的对象发送sayHello消息的话，程序的运行流程如图2-4。  

图2-4 当给super发送消息时的程序运行流程  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/programflow4.png)  

## 对象是动态创建的
就像前文提到的，对于OC对象而言，内存是动态创建的。创建一个对象的第一步是要确定有足够的内存以供分配，而不是考虑定义对象的类的属性，但是还是要考虑继承链条上的父类的定义的属性的。  
根类NSObject，提供了一个类方法，alloc，它将为你控制这个过程。  
> +(id)alloc;

要注意，它的返回类型是id类型的。这是OC中的一个很特殊的关键词，意思是“某种类型的对象”。它是指向一个对象的指针，类似（NSObject *），因为它比较特殊，所以无需使用一个星号修饰。在后面的“OC是一门动态的语言”当中会有相关的描述。  
alloc函数有一个很重要的工作，就是为对象的属性清空内存，然后将他们设置为初始化的状态。这避免了可能存在的内存残留问题，但这还不足以将一个对象初始化。  
你需要用alloc结合另一个NSObject的函数init：  
> -(id)init;

init函数是一个类应该去确保属性在创建的时候有合适的初始值使用的函数，后面的章节会有更详细的描述。  
注意init函数同样返回id类型。  
如果一个函数返回了一个对象指针，那么使用它作为一个函数的接受者然后调用另一个函数是可以的，所以可以在一个语句当中结合多个函数调用。正确的初始化一个对象的方法是在调用alloc之后，就调用init，类似这样：  
> NSObject *newObject = [[NSObject alloc] init];

这个例子将newObject指向了一个新创建的NSObject实例。  
内层的调用先被执行，所以NSObject被发送了alloc消息，他将返回一个分配好内存的新的NSObject类的实例对象。这个返回的对象被用作init函数的接受者，它将返回的值赋值给了newObject指针，见图2-5。  

图2-5 构建alloc和init函数  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/nestedallocinit.png)  

	注意：init返回一个被alloc初始化的不同的对象是有可能的，所以如上文那样结合使用是最好的。  
	永远不要初始化一个未再分配的指针给那个对象。作为示例，请不要这么做：  
	NSObject *someObject = [NSObject alloc];
	[someObject init];
	如果调用init将会返回其他的对象，你将会留下一个指针指向的对象，它被分配了内存空间，但是永远没有被初始化。

### 初始化方法可以带参数
有些对象初始化的时候需要携带必要的值。比如NSNumber的一个对象，必须创建的时候要显示一个值。  
NSNumber类定义了一些初始化方法，包括：  
> -(id)initWithBool:(BOOL)value;  
-(id)initWithFloat:(float)value;  
-(id)initWithInt:(int)value;  
-(id)initWithLong:(long)value;

初始化函数的参数的调用和init函数的调用一样简单，一个NSNumber对象的创建以及初始化会像这样：  
> NSNumber *magicNumber = [[NSNumber alloc] initWithInt:42];

### 类的工厂方法是创建和初始化的另一种替代方式
就像前文中提到的那样，一个类也可以定义工厂方法。工厂方法为传统的alloc] init] 过程提供了另一种选择，它无需使用两个函数。  
NSNumber类定义了一些类的工厂方法来匹配初始化，包括：  
> +(NSNumber *)numberWithBool:(BOOL)value;  
+(NSNumber *)numberWithFloat:(float)value;  
+(NSNumber *)numberWithInt:(int)value;  
+(NSNumber *)numberWithLong:(long)value;

一个工厂方法的使用类似这样：  
> NSNumber *magicNumber = [NSNumber numberWithInt:42];

这与之前提到的alloc] initWithInt:]示例的效果是一样的。为了方便起见，工厂方法其实是直接调用了alloc和相关的init方法。
### 如果初始化方法没有参数的话，可以使用new创建对象
你还可以使用类方法new来创建一个类的实例对象。该方法由NSObject类提供，并且无需在你的子类中重写。这和没有参数的alloc init方法的效果是一样的：  
> XYZObject *object = [XYZObject new];  
    // is effectively the same as:  
    XYZObject *object = [[XYZObject alloc] init];  

### 字面量为创建一个对象提供了简洁的语法
有一些类允许你使用比较简洁的字面量语法来创建对象。  
举例来说，你可以使用一个特殊的字面量语法来创建一个NSString对象，类似这样：  
> NSString *someString = @"Hello, World!";

这与使用NSString 类的 alloc init函数，或者使用它的工厂方法的效果是相同的：  
> NSString *someString = [NSString stringWithCString:"Hello, World!"
                                              encoding:NSUTF8StringEncoding];

NSNumber类同样提供了一些字面量：  
> NSNumber *myBOOL = @YES;  
    NSNumber *myFloat = @3.14f;  
    NSNumber *myInt = @42;  
    NSNumber *myLong = @42L;

同样的，这些例子与使用初始化方法或者工厂方法的效果是一样的。  
你还可以使用括号表达式来创建一个NSNumber，类似这样：  
> NSNumber *myInt = @(84 / 2);

在这个示例中，表达式被估算，然后将结果赋值给一个NSNumber类的实例。  
OC同样提供一些字面量语法来创建不可变的NSArray和NSDictionary类的实例对象，这在之后的“值和集合”当中有相关探讨。
## OC是一门动态的语言
就像之前提到的那样，你需要使用一个指针来跟踪对象在内存中的地址。由于OC的动态性，你无需指定你使用的指针的类的类型——对象的关联的函数在给它发送消息的时候将会一直被正确的调用。  
id类型定义了一种通用的对象指针。当你声明一个变量的时候，你可以使用id来修饰，但是你丢掉了编译期间的对象的相关信息。  
来看一下如下代码：  
> id someObject = @"Hello, World!";  
    [someObject removeAllObjects];

在这个示例中，someObject将会指向一个NSString的实例，但是编译器不知道他是什么类型的对象。removeAllObjects函数是由Cocoa或者Cocoa Touch的对象（比如NSMutableArray）定义的，所以编译器不会报警，即使是在编译期间将会抛出error（由于NSString类是不会响应removeAllObjects函数的）。  
我们重写一下这个代码，使用静态的类型：  
> NSString *someObject = @"Hello, World!";  
    [someObject removeAllObjects];

这时编译器就会抛出error提示，因为没有一个公开的NSString类声明了removeAllObjects函数。  
由于一个实例的类是在运行时才决定的，这在你创建一个对象的时候，将其赋值给一个什么类型的变量是没有区别的。使用本章之前提到的XYZPerson 和 XYZShoutingPerson类，如下所示：  
>  XYZPerson *firstPerson = [[XYZPerson alloc] init];  
    XYZPerson *secondPerson = [[XYZShoutingPerson alloc] init];  
    [firstPerson sayHello];  
    [secondPerson sayHello];  

尽管firstPerson 和 secondPerson都是XYZPerson类的对象，在运行时，secondPerson会指向一个XYZShoutingPerson类的对象。当每个对象调用sayHello函数时，正确的实现将会被调用；对于secondPerson来说，是由XYZShoutingPerson实现的那个版本。  
### 决定对象的相等
如果你想确定一个对象和另一个对象是相同的，要记住，你是在和指针打交道。  
标准C的操作符==，是用来测试两个值或者变量是否相等的，类似这样：  
> if (someInteger == 42) {  
        // someInteger has the value 42   
    }  

当处理对象的时候，==操作符表示两个不同的指针是否指向的是同一个对象：  
> if (firstPerson == secondPerson) {  
        // firstPerson is the same object as secondPerson  
    }  

如果你需要确定两个对象是否表达的是相同的数据的话，你就要用到NSObject类提供的isEqual:函数了：  
>  if ([firstPerson isEqual:secondPerson]) {  
        // firstPerson is identical to secondPerson  
    }  

如果你要确定一个对象表达的值是否比另一个对象表达的要大或者小的话，你不可以使用标准C的比较运算符> 和 <。对于基本类型，类似于NSNumber, NSString 和 NSDate，我们提供了compare:函数：  
> if ([someDate compare:anotherDate] == NSOrderedAscending) {  
        // someDate is earlier than anotherDate  
    }  

### 使用nil
在声明变量的时候将其初始化是很好的习惯，否则它们有可能会携带着之前栈中的垃圾内存残留：  
> BOOL success = NO;  
    int magicNumber = 42;

但这是无需用在对象指针上的，因为编译器会自动的给这些变量设置为nil，你无需制定任何其他的初始值：  
> XYZPerson *somePerson;  
    // somePerson is automatically set to nil

如果你没有其他值要使用的话，一个nil值是初始化一个对象指针最保险的做法，因为在OC当中，给一个对象发送nil的消息是完全没问题的。如果你给一个nil对象发送消息的话，很显然，什么都不会发生。  
	
	注意：如果你需要给nil发送消息后得到一个返回值的话，那么返回值的类型会是nil、0或者其他的数字类型，对于BOOL类型来讲，是NO。返回的结构体拥有所有成员的初始值设置为0。

如果你要确定一个对象不是nil的话（一个变量指针在内存中指向对象），你可以使用标准C当中的不等于操作符：  
>  if (somePerson != nil) {  
        // somePerson points to an object  
    }

或者直接使用该变量：  
> if (somePerson) {  
        // somePerson points to an object  
    }

如果somePerson变量是nil的话，那么它的逻辑值是0（假）。如果它有地址的话，那么它不是0，所以被认为是真。  
简单来说，如果你要确定一个nil变量的话，你既可以使用等于操作符：  
> if (somePerson == nil) {  
        // somePerson does not point to an object  
    }

或者直接使用C的逻辑非操作符：  
> if (!somePerson) {  
        // somePerson does not point to an object  
    }

## 练习
1. 打开上一章中练习的工程，找到main()函数。在任何C编写的可执行的文件当中，这个函数表示你的app的起点。  
使用alloc和init创建XYZPerson类的实例，然后调用sayHello函数。 
	
		注意：如果编译器不自动提示的话，你需要蹈入头文件（包含XYZPerson类的接口）到main.m的头部。

2. 实现本章之前提到的saySomething:函数，重写sayHello函数并使用它。添加大量的打招呼的函数，然后用你创建的调用它们。
3. 创建XYZShoutingPerson类，继承自XYZPerson类。重写saySomething:函数来展示大写的打招呼，然后试试XYZShoutingPerson类的实例等行为。
4. 实现之前章节你声明的XYZPerson类的person工厂方法，返回一个alloc和init正确的XYZPerson类的实例，然后替换你在main()函数中用到的alloc init方法。
		
		提示：在类的工厂方法中使用 [[self alloc] init]，而不是[[XYZPerson alloc] init]。  
		在一个类的工厂方法当中使用self意思是指代类本身。  
		这意味着你无需重写XYZShoutingPerson类的person方法来创建一个正确的实例。试试这么写：  
		XYZShoutingPerson *shoutingPerson = [XYZShoutingPerson person];
		创建一个正确的对象。

5. 创建一个本地的XYZPerson指针，无需任何赋值。用一个分支（if条件句）来检查这个变量是否被赋值为了nil。

# 封装数据
除了前文提到的发送消息之外，一个对象还可以通过它的属性来封装数据。  
本章描述了如何使用OC的语法来给一个对象声明属性，并且解释了这些属性是如何被自动存取方法以及实例变量实现默认值的。如果一个属性是基于一个实例变量的话，那个实例变量比如被任何可用的初始化方法设置。  
如果一个对象需要和另一个对象之间通过属性维持一个链接的话，那么考虑一下两个对象之间关系的性质是很重要的。尽管在OC当中，对象的内存管理已经由ARC替你做了，但是理解如何避免强引用循环这种会引起内存泄漏的问题还是很重要的。本章介绍了一个对象的生命周期，描述了如何管理你的对象之间的关系。
## 属性封装了一个对象的值
大部分的对象都需要跟踪它们持有的信息，以便执行任务。有些对象被设计用来模拟一个或者多个值，比如 Cocoa的NSNumber类持有了很多的数值，或者你自定义的XYZPerson类模拟了一个人的姓名。有些对象在范围内更加通用，可能控制了用户界面和展示的信息之间的关系，但是这些对象都要持有用户界面元素或者相关的模型对象。
### 为暴露的数据声明公共属性
OC的属性为一个类打算封装的数据提供了一种定义信息的方式。就像你在“属性控制对象的访问”中看到的那样，属性的声明是放在类的头文件中的，类似这样：  
> @interface XYZPerson : NSObject  
@property NSString *firstName;  
@property NSString *lastName;  
@end

在这个示例中，XYZPerson类声明了字符串属性来管理一个人的姓名。  
一个面向对象编程的基本原则是一个对象应该将它内部的工作隐藏在公共的接口背后，通过一个对象的暴露的接口来访问数据而不是直接访问其内部数据是很重要的。
### 使用存取器来存取属性的值
你访问或者设置一个对象的属性通过存取器方法：  
> NSString *firstName = [somePerson firstName];  
    [somePerson setFirstName:@"Johnny"];

















