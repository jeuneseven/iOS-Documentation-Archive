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

Number是一个父类，它声明了一些公有方法以供子类调用。但是它没有声明一个实例变量来保存一个数字。字类声明了接口变量并实现了被Number定义的接口。  
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