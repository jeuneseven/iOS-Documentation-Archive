[Concepts in Objective-C Programming 原文链接](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010810)

# 关于Cocoa和Cocoa Touch的基本编程概念
很多Cocoa和Cocoa Touch框架的编程接口都是基于你对于概念的理解的。这些概念表达了很多框架的核心设计理念。通晓这些概念会让你的软件编程过程非常顺畅。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/controller_object.jpg). 

## 概览
本文档阐述了Cocoa和Cocoa Touch框架的核心理念、设计模式以及基本运行机制。这些文章是按照字母排序的。  
## 如何使用本文档
如果你完整阅读本文档的话，你将会获取到关于Cocoa和Cocoa Touch应用开发环境的很多重要信息。然而，大部分文档的读者是以下两种：  

* 其他文档链接到本文档——尤其是那些准备开发iOS和OS X程序的开发者
* 一些内嵌的短文（一般出现在当你点击一个有波折号下划线的单词或短语时）链接到一篇文章《最终讨论》

## 预备知识
最好具备一些面向对象语言的编程经验
## 另请参阅
《OC编程语言》对于本文档覆盖的语言相关的概念提供了更为深入的讨论。
# 类簇
类簇是Foundation框架中广泛使用的一种设计模式。类簇将一组私有的实体子类集合在一个公有的抽象父类下。这些聚合在一起的类即简化了面向对象的框架的公开显式的架构又没有降低函数的丰富性类簇是基于抽象工厂设计模式的。
## 没有类簇的情况：概念简单但是接口复杂
为了展示类簇的结构和优势，请假设构建一个类的层级，这个类定义的对象来存储多种不同类型的数据，char、int、float、double等。通常来讲，多种数据类型就意味着多种功能（例如他们可以互相转换，可以被表示为一个字符串），他们都需要被一个单一的类来表示。但是他们对于存储的需要是不同的，所以用同一个类来表达他们是很低效的。考虑到这种情况，图1-1设计了一种类的结构来解决这个问题。

图1-1 一个简单的number类的层级  
![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster1.gif)

Number是一个父类，它声明了一些公有方法以供子类调用。但是它没有声明一个实例变量来保存一个数字。子类声明了接口变量并实现了被Number定义的接口。  
看上去这个设计似乎很简单。但是，如果用一种通用的方式修改这些基于C的数据类型到一个地方的话，这个类的结构看上去要像这样（见图1-2）：

图1-2 一个复杂的的number类的层级  
![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster2.gif)

如果概念比较简单的话（生成一个类来管理多种值），这会很容易扩展成很多的类。类簇的结构展现了一种设计模式大大简化了概念。

## 使用类簇的情况：概念简单接口也简单
使用类簇设计模式来解决这个问题，简化了类的层级，见图1-3（私有类以灰色显示）

图1-3 使用类簇的number类
![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster3.gif)

使用这个类的用户将会只看到一个公开的类，Number，那么它是如何实例化子类的属性呢？答案在于抽象了父类的实例化方法。

## 生成实例化
一个类簇中的抽象父类必须为生成私有的字类的实例声明方法。基于你调用的初始化方法为子类属性分配对象是父类的职责——你不应该去选择类的实例。  
在Foundation框架中，通常你是使用类方法或者alloc init方法来初始化一个对象。拿Foundation框架中的NSNumber举例来说，你应该发送这些消息来创建number对象。
> NSNumber *aChar = [NSNumber numberWithChar:’a’];  
NSNumber *anInt = [NSNumber numberWithInt:1];  
NSNumber *aFloat = [NSNumber numberWithFloat:1.0];  
NSNumber *aDouble = [NSNumber numberWithDouble:1.0];  

你无需在工厂方法的返回值处释放对象。很多类提供了标准的alloc和init方法来初始化对象，这需要你来管理对象的释放。  
每个返回的对象（aChar, anInt, aFloat, 和aDouble等）都有可能属于一个不同的私有子类（事实上也是如此）。尽管每个对象的类的从属关系已经隐藏了，在公有的接口中，存着被抽象父类生命的接口，NSNumber。可能没那么精确，但是这方便了aChar, anInt, aFloat, 和aDouble等对象成为NSNumber类等一个实例，因为他们通过NSNumber类方法初始化，并且通过NSNumber类声明的实例方法来存取。

## 类簇具有多个公开的父类
在上面的例子中，一个抽象的父类为很多私有的子类声明了很多公有的接口。这种属于类簇最纯粹的用法。很有可能（通常也是常有的情况），有两个（或者多个）抽象的公开类为类簇声明接口。这种情况在Foundation框架中很常见，列表1－1列出了包含类簇的清单：  

列表1-1 类簇和它们的公开超类  

| 类簇 | 公开超类 |
|:------------- |:---------------:|
| NSData | NSData/NSMutableData |
| NSArray | NSArray/NSMutableArray |
| NSDictionary | NSDictionary/NSMutableDictionary |
| NSString | NSString/NSMutableString |

其它类似这种情况的类簇也是存在的，但这清楚的阐述了两个抽象的节点如何以编程的形式在一个类簇中声明接口。在每个类簇中，一个公开的节点声明的方法，所有的类簇的对象都可以响应，另一个节点声明的方法智能被该类簇的对象访问和修改。  
类簇接口的分解性帮助面向对象的框架在编程上更为丰富。例如，想象一个对象表示一本书，声明了以下方法：  
> - (NSString *)title;

一个book对象可以反悔它本身的实例变量或者生成一个新的字符串对象然后返回它（这无所谓）。这清楚的表达了这个返回的字符串是无法被修改的。任何企图修改这个返回的对象都会引起编译器的报错。

## 在类簇中生成字类
类簇结构在简化和扩展性上做了取舍：拥有少量的公开类代替大量的私有的单个类，使得学习和使用一个框架中的类变得更容易，但是多少增加了在类簇中生成字类的难度。然而，如果很少生成字类的话，那么类簇的架构久很有用了。类簇在foundation框架中大量使用就是因为这种情况。  
如果你发现一个类簇没有提供你编程中要用到的函数，那么这时候一个字类可能就比较适合了。例如，假如你在NSArray类簇中希望生成一个数组对象来存储基于文件的内容而不是基于基于内存的内容。因为你需要修改底层类的存储机制，你最好生成一子类做这件事。  
另一方面，某些情况下可能对于类簇中的对象定义一个类更为合适（可能更方便）。假设你的程序需要在某些数据被修改的时候得到提示。在这种情况下，生成一个简单的类，该类包含foundation框架定义的包含数据的对象，这可能是比较好的方法。这个类的对象能够提示修改的数据，拦截消息，作用于消息，并且转发消息给内嵌的数据对象。  
总之，如果你需要管理你的对象的存储，生成一个子类。其他情况的话，生成一个复合对象，该对象包含一个标准的foundation框架的对象。后续章节会对这两种情况有更详细的介绍。

### 子类化
想要在一个类簇中新建一个类，你必须：  

* 生成一个类簇抽象父类的子类
* 声明它的存储
* 重载所有父类的初始化方法
* 重载父类的原始方法（详情如下）

