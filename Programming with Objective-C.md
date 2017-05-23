[Programming with Objective-C 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210)

# 关于OC
在为OS X和iOS编写软件时，OC是一门主要使用的编程语言。这是一个C语言的超集，提供面向对象的功能以及动态运行时能力。OC继承了C语言的语法、原始数据类型以及流控制语句，并且添加了典型的类和方法语法。它还为对象的管理提供了语言级别的支持，并且在动态类型绑定时提供了对象字面量，将很多职责推迟到了运行时。
## 概览
本文档对于OC语言进行了介绍，并且提供了大量的使用示例。你将会学到如何生成你自己的类来描述自定义的对象以及看到如何使用Cocoa和Cocoa Touch层提供的框架来工作。尽管这些框架是与语言本身分离的，但是在使用OC编码时，还是紧密相关的，并且这些框架的类提供了很多语言层级的功能。
### 一款app是由网络对象构成的
当为OS X或iOS编写app时，你会花费大量的时间在对象上。这些对象是OC中类的实例，它们中的一部分是由Cocoa和Cocoa Touch提供的，还有一部分是由你自己创建的。  
如果你自己写类的话，应该从描述一个打算公开的有实例变量的类开始。这个接口包含了公共的属性来封装相关的数据，还有一些方法。方法声明了一个对象能够接收的消息，并且包含了当该方法被调用时需要传递的参数信息。你还应该实现这个类，包含头文件中你声明的每个方法。  
`相关章节：定义类、使用对象、封装数据`
### 分类扩展已经存在的类
你如果想为一个已经存在的类扩展一个小功能的话，你无需创建一个全新的类，你可以为这个类定义一个分类来添加自定义的行为。你可以使用分类为任何类添加方法，甚至包括你没有源代码实现的类，例如框架类中的NSString。  
如果你拥有一个类的源代码的话，你可以使用类的延展来添加新的属性，或者修改已经存在的属性。类的延展通常用来隐藏私有的行为，无论是在一个单独的源代码文件中还是在一个私有的自定义framework实现中。  
`相关章节：自定义已经存在的类`

### 协议定义了信息的契约形式
一个OC的app的主要工作就是以对象之间互相发送消息的形式出现。通常来讲这些消息由类的头文件中明确定义的方法来定义。然而有时候定义一些不直接绑定在一个特定类中的相关方法也是常有的。  
OC使用协议来定义一组相关的方法，例如方法由一个对象的delegate调起，代理方法有选定或者必须的。任何类都可以声明它遵守了一个协议，这意味着它必须实现所有在协议中要求的必须实现的方法。  
`相关章节：使用协议`

### 值和集合类通常表现为OC的对象
通常在OC中使用Cocoa或Cocoa Touch的类来表达一个值。NSString类表达一组字符串，NSNumber类是为多种不同类型的数字准备的，例如整形或者浮点型，NSValue类为各种C结构的类准备的。你还可以使用各种由C语言定义的原始数据类型，例如int，float或者char。  
集合通常表现为一种集合类的实例，例如NSArray, NSSet, 或者NSDictionary，这些通常用在收集其他OC对象上。  
`相关章节：值和集合`

### Block简化了常用任务
Block是一个语言级别的功能，C、OC以及C++当中都引入了该功能，它代表了一组工作集合；它将一块代码连同捕获的状态进行封装，这很像。其他编程语言当中的闭包功能。block通常用来简化日常的任务，例如集合的枚举、排序和测试等。它还简化了为并行或者异步执行的设计的GCD的预定任务。  
`相关章节：使用Block`

### error对象通常用来解决运行时问题
尽管OC为异常捕获提供了语法，Cocoa和Cocoa Touch通常仅仅在编程的错误中（例如数组越界）使用异常，这一般在app发布前就解决了。  
所有其他的错误，包含运行时问题，例如运行在非磁盘空间或者无网状态，这些都包含在NSError类的实例中。你的app必须为错误做好准备，以最佳的方式处理这些错误，当错误发生的时候，你最好给用户提供最佳的体验。  
`相关章节：处理error`

### OC代码服从既定惯例
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

默认情况下，这些存取器会被你的编译器自动合成，所以你除了使用@property关键字在头文件中声明属性之外，什么都不用做。  
合成方法遵循一下的命名规范：  

* 访问方法的函数（getter方法）使用和属性一样的名称。属性叫做firstName 的 getter函数将还会叫做firstName。  
* 设置方法的函数（setter方法）将使用“set”作为函数的开始，然后跟着使用大写字母的属性名。属性叫做“firstName”的setter函数将被叫做“setFirstName：”。

如果你不想让一个属性通过setter方法来更改的话，你可以将他的属性设置为readonly：  
> @property (readonly) NSString *fullName;

就像之前展示的，其他的对象如何作用与属性那样，属性也能够告诉编译器如何合成相关的存取器方法。在本例当中，编译器会自动合成fullName这个getter方法，而不会生成setFullName:方法。  
	
	注意：readonly 的对立是 readwrite。你无需显式的指定readwrite属性，因为这是默认的属性。

如果你想为你的存取器方法换一个名字的话，给你的属性添加一个自定义的名字是可以达到目的的。比如布尔类型的属性（属性具有YES 或 NO值），通常getter方法的函数开头都有“is”。举例来说，一个getter方法的属性名叫finished，他应该叫做isFinished。  
给一个属性添加修饰是可以的：  
> @property (getter=isFinished) BOOL finished;

如果你要指定多个属性的话，只需要用逗号分隔它们就可以了，类似这样：  
> @property (readonly, getter=isFinished) BOOL finished;

在这个示例当中，编译器会自动合成isFinished 方法，但不会合成 setFinished:方法。

	注意：通常来讲，属性合成方法要遵循键值编码（KVC），意思是它们必须显式的遵循命名规范。参考“键值编码编程指南”。

### 点语法是存取器方法调用的简洁替换
OC不但提供了显式的存取器方法，还提供了点语法作为访问一个对象属性的替代方法。  
点语法允许你像这样来访问属性：  
> NSString *firstName = somePerson.firstName;
    somePerson.firstName = @"Johnny";

点语法是存取器方法的一层包装。当你使用点语法的时候，属性依旧是通过上文提到的getter和setter方法来访问或修改的：  

* 使用somePerson.firstName 来访问一个值与使用 [somePerson firstName]效果是一样的
* 使用somePerson.firstName = @"Johnny" 来设置一个值与使用 [somePerson setFirstName:@"Johnny"]效果是一样

这意味着属性通过点语法来访问是同样被属性特性控制的。如果一个属性被标记为readonly的话，如果你试图使用点语法来设置它的值，你会得到编译器的错误提示。
### 大部分的属性都是基于实例变量的
默认的，一个readwrite的属性是基于一个实例变量的，意思是它会被编译器自动合成。  
一个实例变量是一个保存和持有对象的属性的变量。实例变量的内存是当对象被创建的时候（通过alloc）分配内存的，当对象被释放的时候它才释放的。  
除非你特殊指定，否则自动合成的实例对象和属性的名称是相同的，不过它有一个下划线前缀。例如，属性名叫做firstName，那么它合成的实例变量将叫做_firstName。  
尽管通过存取器或者点语法来访问一个对象的属性是最佳实践，但是在类的实现体中，通过直接访问任意实例方法的实例变量也是可以的。下划线前缀让你知道你访问的是一个实例变量而不是一个局部变量：  
> -(void)someMethod {  
    NSString *myString = @"An interesting string";  
   _someString = myString;  
}  

在这个示例中，很明显myString是一个局部变量，而_someString是一个实例变量。  
通常来讲，你都应该使用存取器或者点语法来访问属性，即使是在一个对象的实现当中，不过，在这种情况下，你应该使用self：  
> -(void)someMethod {  
    NSString *myString = @"An interesting string";  
    self.someString = myString;  
  // or  
    [self setSomeString:myString];  
}  

这种情况的例外是在写初始化、释放或者自定义存取方法的时候，本章后面会提到。
#### 你可以自定义合成的实例变量名称
就像前文提到的，一个可写的属性的默认行为是使用一个名为_propertyName的实例变量。  
如果你想用一个不一样的名称的实例变量的话，你得使用以下的语句在你的实现体中，让编译器直接合成变量：  
> @implementation YourClass   
@synthesize propertyName = instanceVariableName;  
...  
@end  

例如：
> @synthesize firstName = ivar_firstName;

在这个示例中，属性依旧叫做firstName，同时可以被firstName 和 setFirstName:以及点语法访问，但是它是基于一个叫做ivar_firstName实例变量的。  
	
	重要：如果你使用@synthesize关键字，没有指定实例变量名称的话，类似这样：
	@synthesize firstName;  
	实例变量将会和属性具有相同的名称。  
	在这个示例当中，实例变量同样叫做firstName，而没有下划线。

#### 你可以不通过属性来定义实例变量
任何时候，通过一个对象的属性来跟踪一个值或者其他对象都是最好的做法。  
如果你确实需要定义你自己的实例变量，而不要声明属性的话，你可以将其用大括号括住，放在头文件或者实现体的头部，类似这样：  
> @interface SomeClass : NSObject {  
    NSString *_myNonPropertyInstanceVariable;  
}  
...  
@end  
@implementation SomeClass {  
    NSString *_anotherCustomInstanceVariable;  
}  
...  
@end  

	注意：你还可以添加实例变量到顶部的类的延展中，这在“类的延展扩展了类的实现”中有相关描述。

### 在构造方法中直接访问实例变量
setter方法会产生一些额外的副作用。它们会触发KVC通知，当你编写你自己的定制方法时，还有可能执行更进一步的任务。  
你应该在构造方法当中直接访问实例变量，因为当属性被设置的时候，对象的其余部分还没有被初始化。即使你不提供自定义的合成方法，或者知道在你自己的类当中存在的副作用，子类化是重写行为的很好的方法。  
一个典型的init方法类似这样：  
> -(id)init {  
    self = [super init];  
    if (self) {  
        // initialize instance variables here  
    }  
    return self;  
}  

在创建它自己的构造方法之前，init方法应该先调用父类的构造方法，然后将结果赋值给self。父类的初始化可能会失败，并且返回nil，所以你在执行你自己的初始化方法之前，永远都应该先检查self不是nil。  
在方法的第一行，［self init］，一个对象的初始化是通过继承者链条，它的父类逐级初始化构成的。图3-1展现了XYZShoutingPerson对象的初始化过程。  

图3-1 初始化过程  

![](file:///Users/lizhankun/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.iOS.docset/Contents/Resources/Documents/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/initflow.png)  

就像你在前面的章节看到的那样，一个对象的初始化是要早于调用init的，或者它会调用一个带有特殊值的初始化的对象。  
以XYZPerson类举例来说，你可以提供一个初始化方法，设置人的姓名：  
> -(id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName;

你实现这个初始化方法类似这样：  
> -(id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName {  
    self = [super init];  
    if (self) {  
        _firstName = aFirstName;  
        _lastName = aLastName;  
    }  
    return self;  
}  

#### 构造方法是最主要的初始化方法
如果一个对象声明了一个活着多个初始化方法，你应该决定哪个方法才是构造方法。这些方法通常为初始化提供了多种选择（例如带有多个参数的初始化方法），并且为了方便起见，这些方法会被你所写的其他方法调用。你也应该重写init方法来调用你的构造方法，并匹配适当的默认值。  
如果一个XYZPerson类有一个属性是生日，那么构造方法应该类似这样：  
> -(id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName
                                            dateOfBirth:(NSDate *)aDOB;

如上所述，这个方法应该设置相关的实例变量。如果你想为姓名提供一个更为简便的初始化方法的话，你应该实现该方法，然后调用这个构造方法，类似这样：  
> -(id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName {  
    return [self initWithFirstName:aFirstName lastName:aLastName dateOfBirth:nil];  
}

你还应该实现一个标准的init方法，并携带适当的默认值：  
> -(id)init {  
    return [self initWithFirstName:@"John" lastName:@"Doe" dateOfBirth:nil];  
}

如果你在子类化一个类的时候要使用多个init方法，你应该重写父类的构造方法来执行你自己的初始化，活着添加你自己的额外的初始化方法。不论哪种方式，你都应该在调用自己的初始化方法之前，调用父类的构造方法（代替[super init];）。
### 你可以实现自定义的合成方法
属性不一定总要依靠他们的实例变量。  
举例来说，XYZPerson类可能要为一个人的全名定义一个只读的属性。  
> @property (readonly) NSString *fullName;

你无需在每次姓名都改变的时候来更新fullName属性，比较简单的做法是写一个自定义的合成方法来根据需求构造全名：  
> -(NSString *)fullName {  
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];  
}

这段代码展示了一个格式化的字符串通过批配符（前文有相关描述）来构建包含一个人的姓和名的字符串，并且用空格分隔。  
	
	注意：尽管这是一段示例代码，但是意识到一些本地特性还是很有必要的，这只适合哪些将人的名放在姓之前的国家。

如果你需要为一个属性（使用实例变量）写一个自定义的合成方法的话，你必须将该实例变量直接写在方法之中。例如，通常我们应该延迟一个属性的初始化，直到它第一次被需要初始化的时候，这称作“懒加载”，类似这样：  
> -(XYZObject *)someImportantObject {  
    if (!_someImportantObject) {  
        _someImportantObject = [[XYZObject alloc] init];  
    }  
    return _someImportantObject;  
}

在使用之前，这个方法首先检查了_someImportantObject变量是否为nil，如果它为空的话，那么创建一个对象。  

	注意：编译器会在任何情况下自动合成一个实例变量的存取方法，哪怕它只需要一个存取方法。如果你为一个readwrite的属性实现了getter和setter方法，或者为一个readonly的属性实现了getter方法的话，编译器会假设你会全权控制该属性，而不回再为你自动实现该属性的合成方法了。  
	如果你依旧需要一个实例变量的话，那么你必须要请求一个合成方法：  
	@synthesize property = _property;

### 属性默认是原子性的
默认的，一个OC的属性是原子性的。  
> @interface XYZObject : NSObject  
@property NSObject *implicitAtomicObject;          // atomic by default  
@property (atomic) NSObject *explicitAtomicObject; // explicitly marked atomic  
@end

意思是自动合成器确保一个值会被getter方法完全恢复或者通过setter方法设置，即使合成方法被不同的线程同时调用。  
由于内部的实现以及原子性的合成方法的同步性是私有的，所以无法将自动合成器和你自己实现的的合成方法结合起来。比如，如果你为一个atomic, readwrite的属性提供一个自定义的setter方法，并且让编译器合成getter方法的话，你会得到一个编译器的警告。  
你可以使用nonatomic修饰一个属性，指定它的合成方法只设置或者直接返回值，而不保证不同的线程同时访问同一个值的时候要发生的事。由于这个原因，使用nonatomic访问一个属性要比使用atomic要快，并且，你还可以结合合成的setter方法与你自己的getter方法实现：  
> @interface XYZObject : NSObject  
@property (nonatomic) NSObject *nonatomicObject;  
@end  
@implementation XYZObject  
- (NSObject *)nonatomicObject {  
    return _nonatomicObject;  
}  
// setter will be synthesized automatically  
@end

	注意：属性的原子性与对象的线程安全是不同的意思。  
	假设一个XYZPerson类的对象，它的姓名属性在一个线程中使用原子性的合成方法被修改了。如果其它的线程在同一时间访问它的姓名属性的话，原子性的getter方法会返回完整的字符串（不会崩溃），但是不保证该值是正确的相关的姓名。如果它的姓在被改变之前就被访问的话，但是名是改变之后被访问的，那么你最终得到的是一个不一致的不匹配的姓名。  
	这个例子很简单，但是线程安全问题在涉及到网络相关的对象时变得很复杂了。线程安全问题在“并发编程指南”中有相关的描述。

## 通过所有权和依赖管理对象
就像你之前看到的那样，OC对象的内存是在栈上动态创建的，这意味着你必须使用指针来跟踪对象的地址。跟标准值不同，你不能在指针变量的使用范围内就确定对象的生命周期。反而对象必须存在的足够久，以供其他对象来调用。  
你倒不用担心需要手动管理每个对象的生命周期，反倒是应该多思考一下对象之间的关系。  
举例来说，在XYZPerson类的对象中，firstName 和 lastName两个字符串属性是被XYZPerson实例来持有的。这意味着他们应该和XYZPerson类的对象在内存中的生命周期一样长。  
当一个对象以这种方式依赖其他对象的时候，那么这些对象之间的关系是有效的，第一个对象被称作“强引用”其他对象。在OC当中，一个对象只要与其他对象有强引用关系的话，就会一直存在。XYZPerson实例对象和它两个字符串属性的关系见图3-2。  

图3-2 强引用关系  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongpersonproperties.png)  

当一个XYZPerson对象从内存中释放的时候，两个字符串对象也会被释放，当然前提是没有其他的强引用指向他们。  
给这个示例加点难度，考虑一下图3-3这样的一个app的对象之间的关系。  

图3-3 姓名牌制作app  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/namebadgemaker.png)  

当用户点击更新按钮的话，姓名牌会更新到相关的信息。  
当一个人的姓氏信息已经被输入，并且更新按钮被点击的话，对象之间的关系会像图3-4那样。  

图3-4 XYZPerson对象的初始化  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/simplifiedobjectgraph1.png)

当用户修改一个人的姓氏，对象改变后的关系类似图3-5。  

图3-5 对象改变后的关系

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/simplifiedobjectgraph2.png)

姓名牌展示了维持一个强引用到@"John"字符串对象，即使XYZPerson 对象有了一个不一样firstName。这意味着@"John"对象还是在内存中的，并且被姓名牌展示来打印姓名。  
一旦用户第二次点击更新按钮，姓名牌会被告知要更新它内部的属性来匹配person对象，所以对象之间的关系会类似图3-6那样。  

图3-6 对象更新后的关系

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/simplifiedobjectgraph3.png)

在这个时候，原来的@"John"对象不再被强引用，所以它会从内存中释放。  
默认的，OC的属性和变量对于其他对象是维持强引用的。这适用于很多情况，但这会带来一个潜在的强引用循环的问题。
### 避免强引用
尽管对象之间的单向的强引用关系运行良好，你还是要小心那些一组组的有关联的对象之间的关系。如果一组对象之间被强引用循环链接的话，即使是外部没有引用了，他们内部的强引用关系也会让它们一直存在下去。  
一个比较明显的例子是tableview（iOS的UITableView和OS X的NSTableView）和它的delegate之间的潜在引用循环。为了能够让tableview在尽可能多的场景下使用，它的delegates会被交给外部对象。这意味着它将以来外部对象来决定展示什么内容，或者当用户在上面进行点击的时候决定要做什么。  
一个比较通用的方案是tableview对delegate强引用，并且delegate对tableview也是，就像图3-7展示的那样。  

图3-7 tableview和delegate之间的强引用

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongreferencecycle1.png)

当其它的对象放弃它对于tableview和delegate的强引用关系的时候，问题就发生了，见图3-8。  

图3-8 强引用循环

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongreferencecycle2.png)

即使现在已经没有必要将两个对象还保存在内存中了——外部对于tableview或者delegate已经没有强引用关系了——但是两个对象之间剩下的强引用关系还是会一直存在。这就叫做“强引用循环”。  
解决这种问题的办法就是要替换一个强引用为弱引用。一个弱引用并不意味着两个对象之间的关系或者持有性，它不会让一个对象一直存活。  
如果一个tableview对于它的delegate的关系被修改为弱引用的话（UITableView和NSTableView就是这么解决的），那么一开始的对象之间的关系会像图3-9那样。  

图3-9 正确的tableview和它的delegate之间的关系

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongreferencecycle3.png)

当外部的对象放弃对tableview和delegate的强引用的时候，这样对于delegate就没有强引用的关系了，就像图3-10那样。  

图3-10 避免强引用循环

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongreferencecycle4.png)  

这意味着delegate对象将要被释放，意思就是释放强引用的tabelview，见图3-11。  

图3-11 释放delegate

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/strongreferencecycle5.png)  

一旦delegate被释放，那么tableview也就没有强引用了，所以它也会被释放。
### 通过强弱声明来管理所有权
默认的，一个对象的属性声明是这样的：  
> @property id delegate;
  
默认使用strong引用来合成它们的实例变量。如果要声明一个weak的引用，需要添加一个修饰到属性当中，类似这样：  
> @property (weak) id delegate;

	注意：weak的反义词是strong。但是你无需声明strong关键字，因为它是默认的。
	
局部变量（非属性的实例变量）默认同样对于对象是强引用的。这意味着以下的代码会按照你所想的那样运行：  
> NSDate *originalDate = self.lastModificationDate;  
    self.lastModificationDate = [NSDate date];  
    NSLog(@"Last modification date changed from %@ to %@", originalDate, self.lastModificationDate);  
                        
在这个示例中，局部变量originalDate对一开始的lastModificationDate对象强引用。当lastModificationDate属性改变的时候，属性将对于原来的日期不再强引用，但是日期依旧会被originalDate强引用而存在。  	  
	
	注意：一个变量只在它的作用域范围内对于对象强引用，或者直到重新赋值给其它对象或者nil的时候。

如果你不想一个局部变量维持强引用的话，你可以使用__weak关键字修饰，类似这样：  
> NSObject * __weak weakVariable;

由于一个弱引用无法维持一个对象，那么即使是你对某个对象还有一个引用，而对象已经释放了也是没问题的。为了避免由释放的对象引起的野指针，一个弱引用会在对象被释放的时候设置为nil。  
这意味着，如果你在之前的示例当中使用弱引用的话：  
> NSDate * __weak originalDate = self.lastModificationDate;  
    self.lastModificationDate = [NSDate date];

originalDate变量可能会被设置为nil。当self.lastModificationDate重新赋值之后，属性对于原来的日期持有强引用。如果没有了强引用，原来的日期将会释放，并且originalDate会被设置为nil。  
weak变量还会引起困惑，尤其以下这段代码：  
> NSObject * __weak someObject = [[NSObject alloc] init];

在这段代码中，新创建的对象没有强引用，那么它会被立刻释放，并且someObject会被设置为nil。  

	注意：__weak的反义词是__strong。同样的，你无需显式的声明__strong，因为它是默认的。

考虑一些隐含的需要访问weak属性的方法也是很重要的，类似这样：  
> -(void)someMethod {  
    [self.weakProperty doSomething];  
    ...  
    [self.weakProperty doSomethingElse];  
}  

在这种情况下，你需要用一个强引用的变量来保存weak的属性，以便在你用到它的时候，它还在内存里：  
> -(void)someMethod {  
    NSObject *cachedObject = self.weakProperty;  
    [cachedObject doSomething];  
    ...  
    [cachedObject doSomethingElse];  
}  

在这个示例当中，cachedObject变量对于原来的weak的属性强引用了，所以在cachedObject的生命周期当中（大括号中，并且没有被其他的值重新赋值）不会被释放。  
记住，在使用一个weak的属性之前，要确保它不为nil是非常重要的，这不仅仅是检测一下这么简单，类似这样：  
> if (self.someWeakProperty) {  
        [someObject doSomethingImportantWith:self.someWeakProperty];  
    }  

因为app是一个多线程的大学，属性很有可能在你测试它或者函数调用的时候就已经释放了，这会导致测试毫无用处。所以，你需要声明一个强引用的局部变量来持有它，类似这样：  
> NSObject *cachedObject = self.someWeakProperty;           // 1  
    if (cachedObject) {                                       // 2  
        [someObject doSomethingImportantWith:cachedObject];   // 3  
    }                                                         // 4  
    cachedObject = nil;                                       // 5  
    
在这个示例当中，第一行创建了强引用，意思是对象被确保了能够存活，为了让你测试和函数调用。在第五行，cachedObject被设置为nil，所以放弃了强引用。如果原来的对象在这个时候没有其他的强引用的话，它将会被释放，并且someWeakProperty会被设置为nil。
### 为某些类使用不安全、不持有的引用
在Cocoa 和 Cocoa Touch当中，还有一部分类不支持弱引用，所以你无法声明一个弱的属性或者使用weak局部变量来跟踪它们。这些类包括NSTextView, NSFont 和 NSColorSpace，想查看全部列表的话，请参见“过渡到ARC”。  
如果你想对这些类使用weak来修饰的话，你必须使用unsafe修饰。对于一个属性来说，你得使用unsafe_unretained来修饰：  
> @property (unsafe_unretained) NSObject *unsafeProperty;

对于局部变量来说，你得使用__unsafe_unretained修饰：  
> NSObject * __unsafe_unretained unsafeReference;

一个unsafe的引用比较像一个weak的引用，所以它和对象的生命周期无关，但是当目标对象被释放的时候，它不会被设置为nil。这意味着你将会为当前已经释放的对象在内存中留下一个野指针。给一个野指针发送消息的话，会引起崩溃。
### 拷贝属性维持了它们自身的拷贝
在某些情况下，对象可能会想要一份它自己的拷贝，作为它自己的属性。  
举例来说，XYZBadgeView类的接口在之前的图3-4当中已经展示过了，类似这样：  
> @interface XYZBadgeView : NSView  
@property NSString *firstName;  
@property NSString *lastName;  
@end  

这声明了两个NSString类型的属性，这暗示了它对于它的对象的强引用关系。  
假设有这么一种情况，一个其他的对象声明了一个字符串，想要设置它们两个属性，类似这样：  
> NSMutableString *nameString = [NSMutableString stringWithString:@"John"];  
    self.badgeView.firstName = nameString;  

这是非常正常的一种情况，由于NSMutableString类是NSString类的子类。尽管badge view 处理了一个NSString实例，它也会同样处理一个NSMutableString实例。  
这意味着改字符串可以被改变：  
> [nameString appendString:@"ny"];

在这种情况下，尽管原来的 badge view 的firstName属性是“John”，现在也变为了“Johnny”，因为可变字符串改变了。  
你可能会选择badge view应该对firstName 和 lastName 属性维持它自己的一份拷贝，这样就能在属性被设置的时候有效的响应了。在两个属性的声明时候添加copy关键字：  
> @interface XYZBadgeView : NSView  
@property (copy) NSString *firstName;  
@property (copy) NSString *lastName;  
@end     

这样，view就对于两个字符串有了自己的拷贝。即使是一个可变的字符串被设置了，或者之后改变了，badge view都会在它设置的时候响应改变。例如：  
> NSMutableString *nameString = [NSMutableString stringWithString:@"John"];  
    self.badgeView.firstName = nameString;  
    [nameString appendString:@"ny"];  
    
这个时候，firstName被badge view的一份不受影响的拷贝持有，所以它的值还是原来的字符串“John”。  
copy属性意味着改属性会被使用强引用，因为它会被新创建的对象持有。  

	注意：任何你想声明copy的属性必须支持NSCopying协议，意思是你必须遵守NSCopying协议。  
	协议的概念在“协议定义了消息的契约”中会有相关介绍，关于NSCopying的更多信息，参见“NSCopying”或者“高级内存管理编程指南”。

如果你想立刻声明一个copy类型的属性实例的话，比如在构造方法当中，不要忘了为原对象设置一份拷贝：  
> -(id)initWithSomeOriginalString:(NSString *)aString {  
    self = [super init];  
    if (self) {  
        _instanceVariableForCopyProperty = [aString copy];  
    }  
    return self;  
}

## 练习
* 从XYZPerson类修改sayHello函数，打印用户的姓名。
* 声明并实现一个新的构造方法，用来初始化XYZPerson类，指定姓名和出生日期，连同相匹配的类工厂方法。别忘了重载init方法，调用构造方法。
* 测试一下如果你设置一个可变的字符串作为一个人的姓名，在调用你的sayHello方法之前，可变字符串发生了什么。更改NSString类型的属性声明，添加copy关键字，然后再测试一下。
* 在main()函数当中，使用大量的strong和weak来创建XYZPerson对象。验证那些strong类型的变量能够足够久的持有XYZPerson对象供你使用。  
为了能够帮助验证XYZPerson对象已经释放，你可能需要在XYZPerson实现当中嵌入dealloc方法。改方法在一个OC对象从内存中释放的时候会自动被调用，并且通常会释放任何你手动创建的内存，类似于C语言中通过malloc()函数来分配内存，这在“高级内存管理编程指南”中有相关描述。  
为了达到本练习的目的，重写XYZPerson 的 dealloc方法，打印一个语句，类似这样：  
-(void)dealloc {  
    NSLog(@"XYZPerson is being deallocated");  
}

尝试设置每个XYZPerson类的指针变量为nil，来验证它们是否如你所期望的那样被释放了。  

	注意：Xcode项目模板为命令行工具在main函数中生成了一个 @autoreleasepool { }括号。这是为了让你能够使用编译器的ARC功能来管理内存，记住一定要将main函数中的代码写在这个自动释放池的大括号中。  
	自动释放池的概念不在本文档中进行讨论，在“高级内存管理编程指南”中有相关介绍。  
	当你不写命令行工具而是写Cocoa 或者 Cocoa Touch 的app时，你同样无需担心生成你自己的自动释放池，因为你使用的框架的对象已经确保了已经有一个自动释放池了。

* 修改XYZPerson类的描述以便你能够跟踪一个配偶或者搭档。你要决定如何更好的处理各个model之间的关系，好好考虑对象之间的从属关系。

# 定制已经存在的类
对象应该有着明确定义的任务，例如构造特殊的信息，展示内容或者控制信息流。就像你见到的那样，一个类的接口定义了其他类可以访问的功能，来帮助这个类的对象完成它的任务。  
有的时候，你可能会需要通过添加一些仅仅在某些地方用到的特殊的行为来扩展一个已经存在的类。举例来说，你的app可能需要展示一个字符串到界面上。与其添加一个字符串渲染的对象，每次调用它来展示一个字符串，还不如扩展NSString类本身来达到这一目的。  
在这种情况下，为原始的类添加通用的行为可不是一个好的方法。绘制字符串这个功能大部分时间都不会用到，而对于NSString来说，你是无法修改它的原始接口或者实现的，因为它是框架的一部分。  
此外，对于已经存在的类采取继承的方式可能也不妥，因为你需要给NSString类添加绘制行为，并且希望它所有的子类也有这个功能，例如NSMutableString。并且，尽管NSString在OS X和iOS上都是可用的，绘制的代码可能需要区分不同的平台，所以你需要在不同的平台上使用不同的子类。  
所以，OC允许你通过分类和扩展来为已经存在的类添加自己的方法。
## 分类为已经存在的类添加方法
如果你需要为一个已经存在的类添加方法的话，通过分类是最简单的方式。  
声明一个分类的语法是使用@interface关键字，就像标准的OC类的描述一样，但是它不会继承于任何类，它会将分类的名称放在括号中，类似这样：  
> @interface ClassName (CategoryName)  
@end

任何类都可以有分类，即使你没有原类的实现源代码（比如标准的 Cocoa 或者 Cocoa Touch类）。所有你添加到分类当中的方法，都可以被原类的所有实例使用，同样，原类的子类也的实例也可以使用。在运行时，原类的方法和添加到分类中的方法是没有区别的。  
考虑到之前章节的XYZPerson类，拥有一个人的姓名两个属性。如果你在编写一个记录类的app时，你可能需要频繁的展示一组人的名字，类似这样：  
> Appleseed, John  
Doe, Jane  
Smith, Bob  
Warwick, Kate  

你不用为适配lastName, firstName编写代码来展示它，你只需要为XYZPerson类添加一个分类就可以了，类似这样：  
> 	#import "XYZPerson.h"  
@interface XYZPerson (XYZPersonNameDisplayAdditions)  
- (NSString *)lastNameFirstNameString;  
@end

在这个示例当中，分类XYZPersonNameDisplayAdditions添加了一个额外的方法来返回需要的字符串。  
分类通常定义和实现在不同的文件当中。以XYZPerson为例，你可能要声明一个分类在一个叫做XYZPerson+XYZPersonNameDisplayAdditions.h的文件中。  
即使所有添加到分类的方法都能被它的实例对象和子类的对象使用，你还是需要将你要用到的方法的分类的头文件导入到你需要的地方，否则你会收到一个编译器的警告和错误提示。  
分类的实现类似这样：  
> 	#import "XYZPerson+XYZPersonNameDisplayAdditions.h"  
@implementation XYZPerson (XYZPersonNameDisplayAdditions)  
- (NSString *)lastNameFirstNameString {  
    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];  
}  
@end  

一旦你声明并实现了一个分类的方法，你可以在任何地方使用它，就像它本来就是原来的类的一部分那样：  
>	#import "XYZPerson+XYZPersonNameDisplayAdditions.h"
@implementation SomeObject  
- (void)someMethod {  
    XYZPerson *person = [[XYZPerson alloc] initWithFirstName:@"John"
                                                    lastName:@"Doe"];
    XYZShoutingPerson *shoutingPerson =
                        [[XYZShoutingPerson alloc] initWithFirstName:@"Monica"
                                                            lastName:@"Robinson"];		
    NSLog(@"The two people are %@ and %@",
         [person lastNameFirstNameString], [shoutingPerson lastNameFirstNameString]);	
}	
@end	

就像为一个已经存在的类添加方法那样，你可以使用分类来分离一个比较复杂的类的实现到不同的实现文件当中。比如，你可以将绘制一个界面元素的代码放到一个分类中，包括几何计算、颜色、渐变等。与此同时，你还可以提供为分类的方法提供不同的实现，取决于你是为OS X还是iOS编写app。  
分类可以被用来声明实例方法和类方法，但是对于声明一个额外的属性就不太合适了。在分类的头文件中声明一个属性从语法上是合法的，但是你无法为一个分类声明一个额外的实例变量。这意味着编译器不会自动合成任何实例变量，意思是它不会为任何属性合成方法。你可以在分类的实现中编写你自己的合成方法，但是你不可能跟踪到任何值，除非它本来就存在在原来的类当中。  
唯一的添加一个标准的属性——基于一个新的变量——是使用类的扩展，这在“类的扩展”中有相关描述。  
	
	注意：Cocoa 和 Cocoa Touch的框架当中包含了大量的分类。  
	本章之前提到的字符串渲染的方法已经被NSString的NSStringDrawing分类在OS X上提供了，它包含drawAtPoint:withAttributes: 和 drawInRect:withAttributes:方法。对于iOS而言，UIStringDrawing分类包含了drawAtPoint:withFont: 和 drawInRect:withFont:类似的方法。

### 避免分类方法的名称冲突
由于方法被声明在了一个已经存在的类的分类当中，所以你必须非常小心方法的名称。  
如果声明在一个分类当中的方法是和原来类当中的方法名一样的话，在你自己的类当中使用这个方法可能还没什么大问题，但是如果这个分类是Cocoa 或者 Cocoa Touch类的分类的话，可能就会有问题了。  
举例来说，一个app和远端的服务器合作，可能会使用一个比较简单的Base64的方法来编码字符串。很可能你定义了一个NSString的分类来添加一个实例方法，返回一个base64编码的字符串，所以很容易想到这个方法的名字就叫base64EncodedString。  
当你链接到其他的框架，并且该框架也有NSString的分类的时候，问题就会发生了，该框架也有base64EncodedString这个方法。在运行时，只有一个方法的实现会被最终添加到NSString当中，但是到底是哪个方法，这是未知的。  
同样的，你添加Cocoa 或者 Cocoa Touch的分类也会发生类似情况。举例来说，NSSortDescriptor类定义了一个集合类应该如何排序，它已经有了一个方法叫做initWithKey:ascending:，但是它没有在早期的OS X和iOS版本中提供相应的工厂方法。  
按照惯例，工厂方法应该叫做sortDescriptorWithKey:ascending:，所以你可能会选择添加一个NSSortDescriptor的分类来提供这个方法。这在早期的OS X和iOS版本当中可能有用，但是在10.6的OS X和4.0的iOS版本之后，sortDescriptorWithKey:ascending:方法已经被添加到了NSSortDescriptor类当中，那么这时候你就造成了命名的冲突。  
为避免这种情况，在给系统类框架添加分类的时候，最好加一个前缀，就像你添加自己的类的前缀那样。你可能选择同样的三个字母的前缀，但最好使用小写字母来遵循函数的命名规则，并且添加下划线在你的方法名前。以NSSortDescriptor类来举例，你自己的分类应该类似这样：  
> @interface NSSortDescriptor (XYZAdditions)  
+ (id)xyz_sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending;  
@end  

这样的话，你就可以在运行的时候使用自己的方法了。明明冲突造成的歧义就不存在了，因为你的代码会是这样的：  
> NSSortDescriptor *descriptor =
               [NSSortDescriptor xyz_sortDescriptorWithKey:@"name" ascending:YES];

## 类的扩展扩展了类的内部实现
一个类的扩展很像一个分类，但是它只能添加到在运行时你拥有源代码的类当中（类同类的扩展一起编译）。举例来说，类的扩展当中声明的函数，只能在原类的@implementation当中实现，所以你无法为系统框架，例如Cocoa 或者 Cocoa Touch 的 NSString类添加扩展。  
类的扩展的语法很像一个分类的语法，类似这样：  
> @interface ClassName ()  
@end

由于括号中没有名字，所以类的扩展经常被称作匿名分类。  
不像常规的分类那样，一个类的扩展是可以添加其自己的属性和实例变量到一个类的。如果你声明一个属性到类的扩展当中，类似这样：  
> @interface XYZPerson ()  
@property NSObject *extraProperty;  
@end

编译器会自动合成相关的存取方法，同样的，实例变量也一样，在类的实现当中。  
如果你添加了函数到类的扩展的话，那么你必须在类的实现体当中将其实现。  
你同样可以使用类的扩展来添加自定义的实例变量。在类的扩展的接口的大括号中：  
> @interface XYZPerson () {  
    id _someCustomInstanceVariable;  
}  
...  
@end  

### 使用类的扩展来隐藏私有的信息
原始的类的接口是用来定义向其他类进行交互的。换句话说，是一个类的公共接口。  
类的扩展通畅用来扩展公共接口，通过添加私有的方法和属性在实现体当中。举例来说，通常来讲，在接口当中定义一个只读的属性，但是在类的扩展当中定义一个可读写的属性，这样类的内部的函数是可以直接对该值进行修改。  
作为示例，XYZPerson类将要添加一个属性，叫做uniqueIdentifier，被设计用来跟踪类似于美国的社会保险号的相关信息。  
在现实世界中，通常需要填写大量的表格才能拥有一个个人的独一无二的账号，所以XYZPerson类的接口的属性会被设计为readonly的，并且提供一些方法来请求授予ID，类似这样：  
> @interface XYZPerson : NSObject
...
@property (readonly) NSString *uniqueIdentifier;
- (void)assignUniqueIdentifier;
@end

这意味着uniqueIdentifier不能被其它的对象直接设置。如果一个人没有这个ID的话，那么必须先调用assignUniqueIdentifier方法来赋值一个ID。  
为了XYZPerson类能够修改内部的属性，那么在类的实现的顶部的类的扩展当中重新声明属性是很合理的：  
> @interface XYZPerson ()  
@property (readwrite) NSString *uniqueIdentifier;  
@end  
@implementation XYZPerson  
...  
@end  

	注意：readwrite属性是可选的，因为它是默认值。只是在重新声明一个属性的时候显式使用。

这意味着编译器也会自动生成一个setter方法了，所以在XYZPerson内部无论是用setter还是点语法都可以对该属性进行设置了。  
通过在XYZPerson类的实现体当中声明一个类的扩展，它保护了XYZPerson的私有信息。如果其它的对象试图对该属性进行设置的话，将会得到一个编译器的错误提示。  

	注意：通过上面添加的类的扩展，重新声明uniqueIdentifier属性为readwrite类型，那么在运行时XYZPerson类的对象将会有一个setUniqueIdentifier:方法，不论其它的源代码文件是否有类的扩展。  
	当其它类的对象打算调用一个私有的方法或者设置一个只读的属性时，编译器会有相应提示，但是是可以有动态运行时的手段来避免这些编译器的error的，例如使用NSObject提供的performSelector:...方法。一个类在被设计的时候应该避免这么做，类的接口应该定义正确的“公开”接口。  
	如果你打算将“私有”的方法或者属性来可供其他的类选择的话，例如一个框架内的其他的相关类，你可以在一个不同的头文件当中声明类的扩展，并且在你需要的地方导入它。举例来说，通常一个类不会有两个头文件的，例如XYZPerson.h 和 XYZPersonPrivate.h。当你发布框架的时候，你只会发布公开的XYZPerson.h头文件。

## 思考一下其他的类的定制化的方法
分类可延展为已经存在的类添加行为提供了很方便的方式，但有的时候这并不是最好的选择。  
一个面向对象语言的初衷是编写可以复用的代码，意思是代码尽量在多种情况下可以重复使用。举例来说，如果你创建了一个在屏幕上显示信息的类，你应该考虑尽可能的复用这个类。  
与其硬编码来决定如何排版或者显示内容，一个替代的方案是通过继承的方法来让子类决定如何做。尽管这种复用的方法比较简单，你在你需要使用原类的时候依旧需要创建一个新类。  
另一个替代方案是使用delegate对象。所有可能限制复用的决定都可以委托给其他对象来决定，也就是将这些决定在运行时再判断。一个比较常见的例子是标准的tableview(OS X的NSTableView和iOS的UITableView)。为了让一个tableview变的可以复用（一个用来展示一组或者多组行列信息的对象），它将展示什么内容在运行时交给了其他对象来决定。协议的机制在下个章节会讲述，“使用协议”。
### 通过OC的runtime相互直接作用
OC通过OC的runtime机制提供动态特性。  
很多种决定，例如哪个函数在被发送消息的时候该被调用，不是在编译时期决定的，而是在app运行时决定的。OC不是一门编译至机器代码的编程语言。它需要一套运行时系统来执行代码。  
通过运行时系统来直接交互也是可以的，例如为对象添加关联的引用。不像延展那样，关联引用不会影响原有类的声明和实现，意思是你可以使用它们为你没有源代码的类来添加。  
关联引用链接了一个对象到另一个，这是一种属性或者实例变量的简便方法。更多相关信息参见“关联引用”。更多关于OC运行时机制，参见“OC运行时编程指南”。
## 练习
1. 添加一个XYZPerson类的分类，声明一个额外的实现，类似于以不同的方式来展示一个人的姓名。
2. 给NSString添加一个分类，功能是为字符串提供一个大写字母的版本，调用NSStringDrawing类的一个方法来执行。该方法在“iOS 字符串 UIKit 参考”和“OS X 字符串 Application Kit 参考”中有相关描述。
3. 为XYZPerson 类 添加两个readonly的属性，用它来展示一个人的身高和体重，连同measureWeight 和 measureHeight。使用类的扩展来重新声明这两个属性为readwrite的，然后实现它们的方法，并且设置合适的值。

# 使用协议
在现实世界中，人们在处理某些情况的时候，通常要遵循一些严格的规定。举例来说，执法人员在问询或者收集证据的时候要“遵循协定”。  
在面向对象的编程当中，给对象定义一组行为，期待它能够按照我们规定的行为来做也是很重要的。举例来说，一个tableview对象希望能够和数据源沟通来决定应该显示什么内容。这意味着数据源必须要响应tableview发出的一些信息。  
数据源可以是任何类的实例，例如视图控制器（NSViewController OS X 或者 UIViewController iOS）或者一个专门的处理数据源的继承自NSObject的类。为了让tableview知道一个对象是否适合作为一个数据源，声明一些对象必须实现的方法是很重要的。  
OC允许你定义“协议”，协议定义了在某些特殊情况下需要用到的方法。本章介绍了定义一个正式的协议的语法，解释了一个类的接口如何声明它遵循了一项协议，意思是该类必须实现协议当中必须实现的方法。
## 协议定义了消息的合同
一个类的接口定义了和类相关联的方法和属性。相比之下，一个协议定义了一些不依赖于任何类的方法和属性。  
定义一个协议的基本语法是这样的：  
> @protocol ProtocolName  
// list of methods and properties  
@end

协议可以包括实例方法、类方法、属性。  
举例来说，假设我们要定义一个类来展示饼状图，见图5-1。  

图5-1 自定义的饼状图  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/piechartsim_2x.png)  

为了让这个视图尽可能的复用，所有的相关信息都应该由一个数据源对象来决定。这意味着同一个view可以根据不同的数据源来展示不同的内容。  
需要饼状图展示的最小信息应该包括数据段的数量，每个段的大小，以及每段的标题。所以饼状图的协议应该看上去类似这样：  
> @protocol XYZPieChartViewDataSource  
- (NSUInteger)numberOfSegments;  
- (CGFloat)sizeOfSegmentAtIndex:(NSUInteger)segmentIndex;  
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segmentIndex;  
@end  

	注意：协议使用了NSUInteger类型来表示i 无符号整型数据，这种类型在下一章节有更深入的讨论。

饼状图的类的接口应该需要一个属性来跟踪数据源对象。这个对象可以是任何类，所以该属性的类型应该是id类型。所有有关对象的信息应该是该对象遵循了相关协议。  
为view声明一个数据源属性的语法类似这样：  
> @interface XYZPieChartView : UIView  
@property (weak) id <XYZPieChartViewDataSource> dataSource;  
...  
@end

OC使用一对尖括号来指出遵循协议。这个例子声明了一个weak类型的属性，它是通用的指针类型，遵循XYZPieChartViewDataSource协议。  

	注意：代理和数据源属性通常为weak类型，原因在之前章节当中描述过，参见“避免强引用循环”。

通过指定必须遵循的协议的属性，如果你要想设置该属性給一个对象的话，你将会得到一个编译器的警告，即使这个基本属性是通用指针类型的。不论该对象是UIViewController 或者 NSObject对象的一个实例。最重要的是遵循协议，意思是饼状图知道它需要的信息是可以被提供的。
### 协议可以有可选的方法
默认的，在协议当中声明的方法都是必须实现的。意思是任何遵守协议的类都要实现这些方法。  
在协议当中声明可选的方法也是可以的。这些方法可以由类去选择是否实现。  
举个例子，你可能会让饼状图的标题是可选的。如果数据源对象没有实现titleForSegmentAtIndex:，那么在饼状图上将没有标题。  
你可以使用@optional指令来修饰协议中的可选方法，类似这样：  
> @protocol XYZPieChartViewDataSource  
- (NSUInteger)numberOfSegments;  
- (CGFloat)sizeOfSegmentAtIndex:(NSUInteger)segmentIndex;  
@optional  
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segmentIndex;  
@end

在这种情况下，只有titleForSegmentAtIndex:方法被标记为可选的。之前没有修饰的方法还是被认为必须实现的。  
@optional指令修饰跟在它后面的任何方法，直到协议定义的末尾，或者遇到其他的指令，比如@required，你可能会添加很多的方法到协议当中，类似这样：  
> @protocol XYZPieChartViewDataSource  
- (NSUInteger)numberOfSegments;  
- (CGFloat)sizeOfSegmentAtIndex:(NSUInteger)segmentIndex;  
@optional  
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segmentIndex;  
- (BOOL)shouldExplodeSegmentAtIndex:(NSUInteger)segmentIndex;  
@required  
- (UIColor *)colorForSegmentAtIndex:(NSUInteger)segmentIndex;  
@end

这个示例定义了拥有三个必须实现的方法和两个可选方法的协议。
#### 在运行时检查可选方法是否实现
如果一个方法被标记为可选的，你必须在调用它之前检查对象是否实现了该方法。  
举例来说，饼状图应该监测分段的标题方法是否实现了，类似这样：  
> NSString *thisSegmentTitle;  
    if ([self.dataSource respondsToSelector:@selector(titleForSegmentAtIndex:)]) {  
        thisSegmentTitle = [self.dataSource titleForSegmentAtIndex:index];  
    }  

respondsToSelector:方法使用了选择器，选择器在编译后引用了一个方法的标识。你可以通过使用@selector()指令来提供正确的标识符，并且确定方法的名称。  
如果这个示例当中的数据源实现了该方法的话，那么标题将被使用，否则的话，标题默认为nil。  

	记住：局部变量将自动初始化为nil。

如果你尝试使用respondsToSelector: 方法判断一个id类型的是否遵守上面定义的协议的话，你将会得到编译器的报错“没有已知的实例方法”。一旦你确定了id类型的协议，所有的静态类型检查将恢复原状；如果你想要调用一个协议当中未定义的方法的话，也会得到编译器的报错。唯一避免编译器报错的方式是将自定义的协议遵守NSObject协议。
### 协议从其他协议继承
就像OC的类从父类继承一样，你同样可以指定一个协议继承另一个。  
举例来说，你最好定义你的协议遵守NSObject协议（一些NSObject的行为已经被从类的接口分离到了协议中；NSObject类也遵循了NSObject协议）。  
为了表明你自己的协议遵循NSObject协议，你应该将任何遵循自定义协议的对象实现NSObject协议的方法。由于你几本书使用的都是NSObject类的子类，所以你无需担心提供自己的类的关于NSObject协议的实现。不过遵守这些协议是很有用的，这在之前描述过。  
想要指定一个协议遵守另一个，你需要将另一个协议的名字放在尖括号中，类似这样：  
> @protocol MyProtocol <NSObject>  
...  
@end  

在这个示例当中，任何遵守MyProtocol协议的对象同样遵守了NSObject协议当中声明的方法。
## 遵循协议
指定一个类遵守协议的语法同样是使用尖括号，类似这样：  
> @interface MyClass : NSObject <MyProtocol>  
...  
@end

这意味着所有MyClass的实例都不仅应该响应接口当中定义的方法，而且MyClass应该提供MyProtocol协议当中定义的必须实现的方法的实现。无需在接口当中重复声明协议方法，遵守协议已经足够了。  

	注意：编译器不会自动合成声明在遵守的协议当中的属性。

如果你的类需要遵守多项协议的话，你可以将它们用逗号分隔开，类似这样：  
> @interface MyClass : NSObject <MyProtocol, AnotherProtocol, YetAnotherProtocol>  
...  
@end

	提示：如果你发现你在一个类当中遵守了大量的协议，这可能意味着你需要通过分解必要的行为到更小的多个类当中来重构一个过渡复杂的类，每个类里面定义的行为都更加清晰。  
	一个OS X或者iOS的开发新手经常遇到的一个坑就是使用一个appdelegate类来包含大量的app相关的功能（管理底层数据结构、为多个用户界面元素提供数据、响应点击和交互等）。随着复杂性的增加，这个类变的更难管理了。

一旦你声明遵守了一项协议，你的类至少要保证实现每一个协议当中定义的必须实现的方法，同样的，也要实现你想要实现的可选的方法。如果你没有实现必须实现的方法的话，编译器会警告你。  

	提示：定义在协议当中的方法跟定义在其他地方的方法一样。在实现的时候，函数名和参数必须和协议当中的相比配。

### Cocoa 和 Cocoa Touch定义了大量的协议
Cocoa 和 Cocoa Touch的对象在很多种情况下都使用了协议。举例来说，table view类（NSTableView OS X 和 UITableView iOS）都使用了数据源来展示必要的信息。它们都定义了自己的数据源协议，这跟之前的XYZPieChartViewDataSource协议的例子是一样的使用方式。table view类同样允许你设置delegate对象，这需要遵守NSTableViewDelegate 或 UITableViewDelegate 协议。delegate是用来响应用户交互或者定制入口显示的。  
有些协议是用来指定类之间非层级的相同之处的。一些协议用来关联Cocoa 或 Cocoa Touch当中的一些不关联的类的。  
举例来说，很多框架中的模型对象（比如集合类对象NSArray 和 NSDictionary）支持NSCoding协议，意思是它可以支持它们的属性通过编解码归解档为原始数据。NSCoding协议大大简化了编写整个对象到硬盘的工作，它为每个对象提供了协议。  
有一些OC语言级别的功能同样依靠协议。举例来说，为了能够使用快速枚举，集合类必须遵守NSFastEnumeration协议，这在“快速枚举能够更快的枚举一个集合类”中有相关描述。同样的，有些对象可以被拷贝，就像“拷贝属性管理它们自己的拷贝”中描述的一个属性使用copy修饰的时候。所有你试图拷贝的对象必须实现NSCopying协议，否则你将会在运行时得到一个异常。
## 协议可以用于匿名
协议同样适用于一个类的对象是未知的，或者需要隐藏的情况。  
举例来说，开发者的类库可能需要不公开一些接口。由于类名是未知的，那么类库的使用者是无法生成一个该类的实例的。不过，其他该类库的的对象可以指定返回一个现成的实例，类似这样：  
> id utility = [frameworkObject anonymousUtility];

为了让anonymousUtility对象能够有用，类库的开发者可以公开一个协议来暴露一些方法。即使原类的接口没有提供，意思是类是匿名的，该对象同样可以在一些情况下使用：  
> id <XYZFrameworkUtility> utility = [frameworkObject anonymousUtility];

举例来说，如果你在编写iOS app的时候，用到了Core Data 类库，你很可能会遇到NSFetchedResultsController类。这个类是被设计用来为iOS的UITableView存储数据源对象的，帮助它更容易提供行信息。  
如果你使用了一个展示分段信息的table view，你同样可以要求提供数据的controller来提供分段信息。你不用指定一个类返回分段信息，NSFetchedResultsController类会返回一个匿名对象，它遵守NSFetchedResultsController协议。这同样能够让你检索你需要的信息，例如一个段落当中有多少行：  
> NSInteger sectionNumber = ...  
    id <NSFetchedResultsSectionInfo> sectionInfo =
            [self.fetchedResultsController.sections objectAtIndex:sectionNumber];  
    NSInteger numberOfRowsInSection = [sectionInfo numberOfObjects];  

即使你不知道sectionInfo对象的类，NSFetchedResultsSectionInfo协议规定了它是可以响应numberOfObjects方法的。

# 值和集合
尽管OC是一个面向对象的编程语言，它还是C的一个超集，意思是你可以在OC当中使用任何标准C的标准（非对象）类型，例如int, float 和 char等类型。此外，还有一些标准类型在Cocoa 和 Cocoa Touch的app当中使用，例如NSInteger, NSUInteger 和 CGFloat等，不同的定义取决于目标框架的不同。  
标准类型通常在你不需要一个对象表现一个值的时候使用（或者关联开支）。而字符串通常由NSString类的实例表示，数字形的值通常保存在标准的局部变量或者属性当中。  
在OC当中你可以声明一个C语言类型的数组，不过你会发现，在Cocoa 和 Cocoa Touch中的集合通常使用NSArray 或 NSDictionary来表现。这些类只能用来装载OC的对象，意思是你得创建类似于NSValue、NSNumber 或 NSString类这样的实例添加到集合当中才能够正常表达值。  
本文档之前的章节频繁的使用了NSString类，以及他的初始化和类的工厂方法，还有他的OC的字面量语法@"string"，字面量语法是创建一个NSString实例的简洁语法。本章讲述了如何创建NSValue 和 NSNumber对象，同样的，会用到方法调用或者字面量语法。
## OC支持基本的C语言类型
所有标准C的标准变量类型在OC当中都可以使用：  
> int someInteger = 42;  
    float someFloatingPointNumber = 3.1415;  
    double someDoublePrecisionFloatingPointNumber = 6.02214199e23;

同样的，操作符也是：  
> int someInteger = 42;  
    someInteger++;            // someInteger == 43. 
    int anotherInteger = 64;  
    anotherInteger--;         // anotherInteger == 63   
    anotherInteger *= 2;      // anotherInteger == 126

如果你在OC的属性当中使用的C的基本类型的话，类似这样：  
> @interface XYZCalculator : NSObject  
@property double currentValue;  
@end

同样的，在属性当中通过点语法访问属性使用C的操作符也是可以的，类似这样：  
> @implementation XYZCalculator  
- (void)increment {   
    self.currentValue++;  
}  
- (void)decrement {  
    self.currentValue--;  
}  
- (void)multiplyBy:(double)factor {  
    self.currentValue *= factor;  
}   
@end

点语法是对于存储器方法的语法封装，所以在这个例子当中的每个操作符都等同于先使用get方法来访问值，在执行操作符之后，再使用set方法设置值。
### OC定义了额外的基本类型
BOOL类型定义了OC当中的布尔类型的值，它的类型是yes或者no。你可以认为，yes逻辑上等同于true和1，而no等同于false和0。  
很多Cocoa 和 Cocoa Touch对象的方法都使用了特殊的基本数字类型作为参数，比如NSInteger 或 CGFloat。  
举例来说，NSTableViewDataSource 和 UITableViewDataSource协议（之前章节有相关描述）都有请求显示行数的方法：  
> @protocol NSTableViewDataSource <NSObject>  
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;  
...  
@end

类似NSInteger 和 NSUInteger这种类型是根据不同的框架来定义的。挡在32位的环境当中构建时（例如iOS），它们分别表示32位的有符号和无符号整型变量；当在64位环境上构建时（例如现代的OS X运行时），它们分别表示64位的有符号和无符号整型变量。  
在你通过API传递值的时候（内部或者外部都可能）比如参数或者返回值，或者你的app和一个框架之间的函数调用，你最好使用这些平台特定的类型。  
对于局部变量，例如一个循环当中的计数器，如果你能确定该值实在标准之内的话，你可以使用C基本类型。
### C的结构体持有原始值
有些Cocoa 和 Cocoa Touch的API使用C的结构来持有值。例如，你可以查询一个字符串对象的子串，类似这样：  
> NSString *mainString = @"This is a long string";  
    NSRange substringRange = [mainString rangeOfString:@"long"];

NSRange结构体持有location 和 length。在这个示例当中，substringRange将会得到{10,4}范围内的子串，@"long"开头的l字母是主字符串当中从0开始的下标到10的字母，@"long"是一个四个字符长度的子串。  
同样的，如果你需要编写定制的绘图代码的话，你需要和Quartz框架进行交互，它需要的结构体基于CGFloat数据类型，例如OS X上的NSPoint 和 NSSize 以及iOS上的 CGPoint 和 CGSize。同样的，CGFloat在不同的架构上定义是不同的。  
更多关于Quartz 2D绘制引擎的相关信息，参见“Quartz 2D编程指南”。
## 对象可以表示原始类型的值
如果你想把基本类型的值表达为对象的话，比如下个段落当中提到的集合类，你可以使用Cocoa 和 Cocoa Touch框架提供的基本值类。
### 字符串可以被NSString类的实例对象表示
就像你在之前的章节当中看到的那样，NSString被用来表示一组字符串，比如Hello World。有很多种创建字符串的方法，比如标准的alloc init，类工厂方法或者字面量语法：  
>NSString *firstString = [[NSString alloc] initWithCString:"Hello World!" encoding:NSUTF8StringEncoding];  
    NSString *secondString = [NSString stringWithCString:"Hello World!"
                                                encoding:NSUTF8StringEncoding];  
    NSString *thirdString = @"Hello World!";

所有示例的方法的效果都是一样的——创建一个要求展现的字符串。  
NSString类本身是不可变的，意思是它的值在创建的时候就被设置了，并且随后不可以被更改。如果你想表达一个不同的字符串的话，你得创建一个新的字符串，类似这样：  
> NSString *name = @"John";  
    name = [name stringByAppendingString:@"ny"];    // returns a new string object  

NSMutableString类是NSString类的可变子类，它允许你在运行时通过appendString: 或 appendFormat:方法更改字符串，类似这样：  
> NSMutableString *name = [NSMutableString stringWithString:@"John"];  
    [name appendString:@"ny"];   // same object, but now represents "Johnny"

#### 格式化字符串通常用来使用其他对象或者值来构建字符串
如果你想要构建一个包含多个值的字符串的话，你需要用到**格式化字符串**。这让你能够使用格式化符号指定哪些值应该被插入：  
> int magicNumber = ...  
    NSString *magicString = [NSString stringWithFormat:@"The magic number is %i", magicNumber];

可用的格式化符号在“字符串格式符”中有相关描述。更多关于字符串的使用，参见字符串编程指南。
### 数字可以被NSNumber类的实例对象表示
NSNumber类被用来展示任何基于C的基本类型，包括char, double, float, int, long, short和 它们的无符号版本，同样支持OC的布尔类型，BOOL。  
同NSString类一样，你在创建NSNumber实例的时候有着大量的选择，包括alloc init或者类工厂方法：    
>  NSNumber *magicNumber = [[NSNumber alloc] initWithInt:42];  
    NSNumber *unsignedNumber = [[NSNumber alloc] initWithUnsignedInt:42u];  
    NSNumber *longNumber = [[NSNumber alloc] initWithLong:42l];  
    NSNumber *boolNumber = [[NSNumber alloc] initWithBOOL:YES];  
    NSNumber *simpleFloat = [NSNumber numberWithFloat:3.14f];  
    NSNumber *betterDouble = [NSNumber numberWithDouble:3.1415926535];  
    NSNumber *someChar = [NSNumber numberWithChar:'T'];

同样的，使用OC的字面量语法创建NSNumber的实例也是可以的：  
> NSNumber *magicNumber = @42;  
    NSNumber *unsignedNumber = @42u;  
    NSNumber *longNumber = @42l;  
    NSNumber *boolNumber = @YES;  
    NSNumber *simpleFloat = @3.14f;  
    NSNumber *betterDouble = @3.1415926535;  
    NSNumber *someChar = @'T';  

这些示例等同于使用NSNumber的类工厂方法。  
一旦你创建了NSNumber对象，你就可以使用存取方法来访问它的标准值：  
> int scalarMagic = [magicNumber intValue];  
    unsigned int scalarUnsigned = [unsignedNumber unsignedIntValue];  
    long scalarLong = [longNumber longValue];  
    BOOL scalarBool = [boolNumber boolValue];  
    float scalarSimpleFloat = [simpleFloat floatValue];  
    double scalarBetterDouble = [betterDouble doubleValue];  
    char scalarChar = [someChar charValue];

NSNumber类同样为额外的OC的基本类型提供了方法。比如，如果你想要创建一个对象来表示NSInteger 和 NSUInteger的话，请确保你使用的是正确的方法：  
> NSInteger anInteger = 64;  
    NSUInteger anUnsignedInteger = 100;  
    NSNumber *firstInteger = [[NSNumber alloc] initWithInteger:anInteger];  
    NSNumber *secondInteger = [NSNumber numberWithUnsignedInteger:anUnsignedInteger];  
    NSInteger integerCheck = [firstInteger integerValue];  
    NSUInteger unsignedCheck = [secondInteger unsignedIntegerValue];  

所有的NSNumber实例都是不可变的，并且没有可变的子类；如果你需要另一个不一样的数字的话，请直接使用另一个NSNumber实例。  

	注意：NSNumber实际上是一个类簇。意思是当你在运行时创建一个实例的时候，你将会得到一个合适的混合子类持有给予的值。只需要将创建的对象视作NSNumber的实例即可。

### 其他类型的值可以被NSValue类的实例对象表示
NSNumber类本身是基于NSValue类的子类，后者对于一个单一值或者数据进行了对象封装。为了基于C基本类型，NSValue还可以被用来表示指针和结构体。  
NSValue类提供了大量的工厂方法来根据标准结构创建一个值，这让穿件一个实例来表达一个值变的很简单。举例来说，一个NSRange，之前章节中的一个示例：  
> NSString *mainString = @"This is a long string";  
    NSRange substringRange = [mainString rangeOfString:@"long"];  
    NSValue *rangeValue = [NSValue valueWithRange:substringRange];  

通过NSValue对象来表达自定义的结构体也是可以的。如果你有特殊的需要来使用一个C的结构体（而不是一个OC的对象）来保存信息的话，类似这样：  
> typedef struct {  
    int i;  
    float f;  
} MyIntegerFloatStruct;

你可以使用一个NSValue的实例，通过提供一个指向结构体的指针，同样也是一个OC编码的类型。@encode()编译器指令被用来生成正确的OC类型，类似这样：  
> struct MyIntegerFloatStruct aStruct;  
    aStruct.i = 42;  
    aStruct.f = 3.14;  
    NSValue *structValue = [NSValue value:&aStruct
                             withObjCType:@encode(MyIntegerFloatStruct)];  

标准C当中的引用操作符（&）被用来为value参数提供aStruct的地址。
## 大部分的集合都是对象
尽管使用一个C的数组来持有基本类型的数据是可以的，或者对象的指针也可以，但是大部分OC当中的集合都是Cocoa 和 Cocoa Touch集合类的实例之一，比如NSArray, NSSet 和 NSDictionary。  
这些类用来管理一组对象，意思是任何你想添加到一个集合当中的元素都必须是一个OC的类的实例。如果你想添加一个基本类型的话，你必须先创建一个合适的NSNumber 或 NSValue的实例变量来表达它。  
集合类对于它的元素是使用强引用的，而不是以某种方法再拷贝一份。意思是任何你添加到集合当中的元素，将会和集合的生命周期一样长，这在“通过持有和引用管理对象”中有相关描述。  
为了能够跟踪它的对象元素，每个Cocoa 和 Cocoa Touch集合类做了某些事情来使跟踪变得简单，例如枚举，访问具体的元素或者查找一个特殊的对象是否是集合的一部分。  
基本的NSArray, NSSet 和 NSDictionary类是不可变的，意思是他们的内容在创建的时候就被设置了。每个类都有一个可变的子类来让你能够随意的添加或者移除对象。  
有关Cocoa 和 Cocoa Touch中不同的集合的相关信息，参见“集合编程主题”。
### 数组是有序的集合
NSArray是用来表示一组有序的对象的集合。唯一的要求是每个元素都必须是一个OC对象——无需每个对象都是同一个类的实例。  
为了在数组当中维持顺序，每个元素都是存储在基于0的索引的，见图6-1。  

图6-1 一个OC对象的数组  

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/orderedarrayofobjects.png)

#### 生成数组
就像本章之前提到的封装值的类一样，你可以通过alloc init 、类工厂方法或者字面量语法来生成一个数组。  
创建数组的时候有大量的初始化和工厂方法供使用，取决于对象的数量：  
> +(id)arrayWithObject:(id)anObject;  
+(id)arrayWithObjects:(id)firstObject, ...;  
-(id)initWithObjects:(id)firstObject, ...;

arrayWithObjects: 和 initWithObjects:方法都包含了以nil为休止符，可跟多个变量参数，意思是你必须在最后一个变量参数的位置填上nil，类似这样：  
> NSArray *someArray =
  [NSArray arrayWithObjects:someObject, someString, someNumber, someValue, nil];

这个示例创建了一个类似之前图6-1中提到的数组。第一个对象，someObject将拥有一个数组下标0；最后一个对象someValue将拥有数组下标3。  
如果不小心在一组数组元素当中插入了一个nil的话，类似这样：  
> id firstObject = @"someString";  
    id secondObject = nil;  
    id thirdObject = @"anotherString";  
    NSArray *someArray =
  [NSArray arrayWithObjects:firstObject, secondObject, thirdObject, nil];

在这个示例当中，someArray将只包含firstObject一个元素，因为secondObject为nil，它被当作了数组的最后一个元素。
##### 字面语法
同样的，使用OC的字面量语法也可以创建一个数组，类似这样：  
> NSArray *someArray = @[firstObject, secondObject, thirdObject];

在使用字面量语法创建数组的时候，你不应该在末尾再添加nil了，事实上，nil是一个无效值。如果你执行以下代码的话，你将在运行的时候得到一个异常，例如：  
> id firstObject = @"someString";  
    id secondObject = nil;  
    NSArray *someArray = @[firstObject, secondObject];  
    // exception: "attempt to insert nil object"

如果你确实需要在一个集合里面表现一个nil值的话，你应该使用NSNull的单例，这在“使用NSNull来表达nil”中有相关描述。
#### 查询数组对象
一旦你创建了一个数组，你可以查询元素的数量或者判断它是否包含一个元素：  
> NSUInteger numberOfItems = [someArray count];  
    if ([someArray containsObject:someString]) {. 
        ...  
    }  
 
你还可以使用给定的元素的索引来查询数组。如果你试图请求一个无效的索引的话，你将会在运行时得到一个越界的异常，所以你应该永远先检测数组元素的个数：  
> if ([someArray count] > 0) {   
        NSLog(@"First item is: %@", [someArray objectAtIndex:0]);  
    }

这个示例判断了数组元素个数是否大于零。如果是的话，那么它打印第一个元素的内容，第一个元素的下标是0。
##### 添加下标
还有一种替代objectAtIndex:的下标的方法，就像C当中访问一个数组的元素那样。之前的示例可以被重写为这样：  
> if ([someArray count] > 0) {  
        NSLog(@"First item is: %@", someArray[0]);  
    }

#### 排序数据对象
NSArray类同样还提供了大量的方法来对元素进行排序。由于NSArray是不可变的，这些方法都会返回一个新的包含排序好了的元素的数组。  
举个例子，你可以将一个字符串数组当中的元素通过调用compare:函数来进行排序，类似这样：  
> NSArray *unsortedStrings = @[@"gammaString", @"alphaString", @"betaString"];  
    NSArray *sortedStrings =
                 [unsortedStrings sortedArrayUsingSelector:@selector(compare:)];


#### 可变性
尽管NSArray是不可变的，这对每个元素都没有影响。举个例子，如果你将一个可变的字符串添加到一个不可变的数组当中的话，类似这样：  
> NSMutableString *mutableString = [NSMutableString stringWithString:@"Hello"];  
NSArray *immutableArray = @[mutableString];

你改变字符串的话，是没有任何问题的：  
> if ([immutableArray count] > 0) {  
	id string = immutableArray[0];   
	if ([string isKindOfClass:[NSMutableString class]]) {  
		[string appendString:@" World!"];  
	}    
	}

如果你想在数组创建完成后添加或删除元素的话，你就得用到NSMutableArray了，它提供了大量的方法来添加、删除或者替换更多的元素：  
> NSMutableArray *mutableArray = [NSMutableArray array];  
    [mutableArray addObject:@"gamma"];  
    [mutableArray addObject:@"alpha"];  
    [mutableArray addObject:@"beta"];  
    [mutableArray replaceObjectAtIndex:0 withObject:@"epsilon"];  

这个示例创建的数组最终由@"epsilon", @"alpha", @"beta"元素组成。  
直接通过对可变数组内的元素进行排序而不创建一个新的数组也是可以的：  
> [mutableArray sortUsingSelector:@selector(caseInsensitiveCompare:)];

这样的话，这个数组将会被以降序、不区分大小写的顺序来排列为：@"alpha", @"beta", @"epsilon"。
### 集合是无序的集合
NSSet很像一个数组，但是它管理着一组无序的唯一的对象，见图6-2.  

图6-2 一组对象的集合   

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/unorderedsetofobjects.png)

由于集合不关心顺序，所以它在检测内部元素的时候，比数组更高效。  
基本的NSSet同样是不可变的，所以它的内容必须是在创建的时候就指定好，使用alloc init或者类工厂方法都可以，类似这样：  
> NSSet *simpleSet =
      [NSSet setWithObjects:@"Hello, World!", @42, aValue, anObject, nil];

就像NSArray一样，initWithObjects: 和 setWithObjects:方法都以nil结尾，可带有多个参数。NSSet 的可变子类是 NSMutableSet。  
即使你向一个集合添加超过一次的同样的一个元素的话，集合也只保存唯一的一个引用：  
> NSNumber *number = @42;  
    NSSet *numberSet =
      [NSSet setWithObjects:number, number, number, number, nil];  
    // numberSet only contains one object

更多关于集合的信息，参见”Set：无序的元素集合“
### 字典包含了键值对
与简单的维护一组有序或者无序的元素不同，一个NSDictionary通过key来存储对象，可以用于之后的检索。  
使用字符串来作为字典的key是很好的一种方法，见图6-3 。

图6-3 字典中的对象

![](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Art/dictionaryofobjects.png)  

	注意：使用其他的对象也可以作为字典的key，但是要注意，每个key都是被字典拷贝使用的，所以作为key的对象要实现NSCopying协议。  
	如果你想使用KVC的话，这在“KVC变成指南”中有相关描述，你必须使用字符串作为字典中对象的key。
	
#### 生成字典
你可以通过alloc init方法或者类工厂方法来创建字典，类似这样：  
> NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                   someObject, @"anObject",
             @"Hello, World!", @"helloString",
                          @42, @"magicNumber",
                    someValue, @"aValue",
                             nil];

注意dictionaryWithObjectsAndKeys: 和 initWithObjectsAndKeys:方法，每个方法都是对象在key的前面，并且在一组对象和key的最后以nil为结尾。  
##### 字面语法
OC同样为创建字典提供了字面量语法，类似这样：  
> NSDictionary *dictionary = @{
                  @"anObject" : someObject,
               @"helloString" : @"Hello, World!",
               @"magicNumber" : @42,
                    @"aValue" : someValue
    };

注意使用字典的字面量语法的时候，key必须在对象之前，并且无需使用nil为结尾。
#### 查询字典

#### 可变性

### 使用NSNull来表示nil

## 使用集合保存你的对象

## 使用高效的集合枚举技术

### 快速枚举能够让枚举一个集合更简单

### 大部分集合同样支持枚举对象

### 大部分集合支持基于Block的枚举

# 使用Block

## Block语法

### Block能够带参数和返回值

### Block能够从闭包中获取值

#### 使用__block变量来共享存储

### 你可以将Block作为函数或者消息的参数

#### Block应该永远在一个函数的最后一个参数的位置

### 使用类型定义来简化Block语法

### 对象可以使用属性来跟踪Block

### 当持有self的时候，避免强引用循环

## Block能够简化枚举

## Block能够简化并发任务

### 使用Block操作队列

### 在GCD中使用Block安排作业

# 处理error

## 大部分error情况下使用NSError 

### 一些代理方法会警告你使用error

### 一些方法通过引用来传递error

### 尽可能的恢复或者展示error给用户

### 生成你自己的error

## 异常用于处理程序的error情况

# 惯例

## 一些名字必须是贯穿你的app的唯一的

### 类名必须在整个App当中都是唯一的

### 方法名最好具有丰富的表达性并且在类当中唯一

#### 在类库的分类的方法当中应该始终使用前缀

### 局部变量在同一个作用域范围内必须唯一

## 一些方法名必须遵从惯例

### 存取器方法必须遵从惯例 

### 对象的初始化方法必须遵从惯例











