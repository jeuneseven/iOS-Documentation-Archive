[A Short Practical Guide to Blocks 原文链接](https://developer.apple.com/library/content/featuredarticles/Short_Practical_Guide_Blocks/index.html#//apple_ref/doc/uid/TP40009758)

# Blocks精简实用指南

Blocks是一种强大的C语言级别的功能，它是Cocoa应用程序开发的一部分。它类似于“closures”和“lambdas”，你在其他的脚本语言或编程语言中（比如Ruby，Python和Lisp）可能找到类似的功能。尽管blocks语法和存储的细节乍一看比较模糊，但你会发现它实际上很容易融入你的工程代码。  
以下章节从一个顶部的视角讨论了blocks的一些功能，并展示了它们使用的一些典型方式。若要查看详细的blocks的描述，请参考“Blocks编程主题”。  

## 内容：
* 为什么使用Blocks？
* 系统框架APIs中的Blocks
* Blocks和并发

## 为什么使用Blocks？
Blocks是一种封装了一组任务的对象——或者用不那么抽象的术语来说，就是一段代码——这些代码可以在任何时候执行。它们本质上是轻量的匿名函数，它可以被当做函数的参数进行传递，也可以从其他函数和方法中返回。Blocks本身有一组类型参数列表，也可以声明返回类型。你也可以将一个block赋值给一个变量，然后你可以将其当做一个函数进行调用。  
脱字符(^)被用来作为blocks的句法标记。举例来说，以下代码声明了一个带有两个整形变量和返回一个整型值的block。它将参数列表放到第二个脱字符后，并将实现体放到大括号中，最后将其赋值给Multiply变量：  

	int (^Multiply)(int, int) = ^(int num1, int num2) {
	    return num1 * num2;
	};
	int result = Multiply(7, 4); // Result is 28.

作为方法或函数的参数，blocks可以作为一种类型的回调并可以被作为一种限于方法或函数的代理。通过在block中传递，调用的代码能够定制化方法或函数的行为。当被调用时，方法或函数会执行一些工作，并在适当的时机回调调用的代码——通过block——从它当中请求额外的信息或获得应用程序特定的行为。  
blocks作为函数和方法的参数的一个优势是它们能够在调用的时间点提供给调用者以回调。

### 完成和错误处理

### 通知处理

### 枚举

### 视图动画和过渡

### 排序

## 系统框架APIs中的Blocks