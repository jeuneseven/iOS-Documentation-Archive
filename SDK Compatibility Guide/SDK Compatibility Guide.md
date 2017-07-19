[SDK Compatibility Guide 原文链接](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163i)  

# 简介
Xcode包含的SDK能够让你创建运行在指定系统版本的iOS或者OS X上的软件——包括不同于你正在使用的系统版本。这项技术能够让你利用新的功能构建一个单一的二进制包就可以在一个系统当中运行并提供支持，并且在运行在一个较早版本系统当中时，可以无缝的降级。一些Apple的框架会根据应用程序构建的SDK自动修改其行为, 以提高兼容性。  
	
	注意：本文档没有阐述如何编写同时运行在iOS和OS X系统的代码。尽管Xcode能够让你通过一个简单的选项来更换不同的SDK以便转换平台，但是在iOS和Mac的app当中还是有一些基本设计上的不同的。参见“从Cocoa迁移”来获取更多信息。
	
如果你的app需要兼容不同的iOS或者OS X版本的话，请阅读本文档。
## 本文的组织结构
本文档包含以下章节：  

* 基于SDK开发概览——描述了如何基于SDK进行开发工作。
* 为基于SDK的开发配置项目——描述和如何使用SDK来配置你的工程。
* 使用基于SDK开发——阐述了如何使用弱链接类、方法、函数，如何弱链接一个框架，如何为不同的SDKs有条件的进行编译，以及如何在你的代码当中查找废弃的API。

# 基于SDK开发概览
Apple使得SDKs对于指定版本的iOS和OS X都可用。使用这些SDKs能够让你针对操作系统的头文件和库进行构建，而不是仅仅你正在运行的版本。举个例子，你正在使用的是OS X 10.6的系统，但是你可以在上面构建10.4的版本。  
在Xcode 3.2以及之后的版本当中，OS X SDKs被作为Xcode的一个套件的部份进行安装。Xcode版本说明当中列出了每个发布的版本支持的SDKs。当为iOS进行开发时，你应该始终从iOS开发者中心网站中下载SDK进行使用。  
请在以下方式中利用基于SDK进行开发：

* 你可以针对一个操作系统的版本对其进行优化构建，并且向前兼容它之后的版本，但是不要指定更新的功能。
* 你可以在几个操作系统版本之间进行构建，以便它可以在较老的系统版本上进行加载但是由能够使用较新的功能。这能够让你给那些升级到新版本操作系统的用户提供的软件当中运行新的功能，但是还能够为那些未升级的用户提供同样的功能。


## 框架中的行为选择

# 为基于SDK的开发配置项目
本章描述了iOS和OS X SDKs的安装配置，解释了如何使用一个特定版本的SDK来设置你的Xcode工程。
## SDK头文件以及根类库

## 基于SDK以及开发target的设置

## 弱连接以及Apple开发类库

## 配置基于Makefile的项目

## 设置预编译文件

# 使用基于SDK开发
本章描述了如何在你的Xcode项目中基于SDK开发技术进行开发，解释了以下你能够做的事情：  

* 使用弱链接的类、方法和函数来支持运行在不同操作系统版本上的app
* 弱链接一整个类库
* 有条件的为不同的SDK进行编译
* 在你的代码中查找废弃的API
* 在运行时判断操作系统版本或者类库版本

对于弱链接的相关背景知识，参见“弱链接以及Apple类库”。

	重要：当编写OC代码的时候，你依赖弱链接的类、方法和函数以及类库。当编写Swift的时候，使用“availability condition”代替，这在“Swift编程指南（Swift 4）”当中的‘检查可用的API’段落有相关描述。

## 在iOS中使用弱连接的类
如果你的Xcode项目使用了弱链接的类，你必须确保在使用这些类之前，这些类在运行时是可用的状态。如果你尝试使用一个不可用的类将会得到动态链接器处得到一个运行时绑定错误，这将会终止响应的进程。  
使用基于iOS 4.2以及之后版本SDK的Xcode项目应该使用NSObject的类方法来检查一个弱链接的类在运行时是否可用。这样简单，有效机制是利用NS_CLASS_AVAILABLE类可用的宏定义，这在iOS的大部分系统库当中都是可用的。  

	重要：请检查近期的iOS发布说明中的系统库列表，查看尚未支持NS_CLASS_AVAILABLE宏定义的类库。

对于支持NS_CLASS_AVAILABLE宏定义的iOS系统类库，请参照如下演示代码来使用弱链接类：  

	if ([UIPrintInteractionController class]) {
    // Create an instance of the class and use it.
	} else {
    // Alternate code path to follow when the
    // class is not available.
	}

这样做有用是因为如果一个弱链接的类事不可用的，给它发送信息就像给nil发送信息一样。如果你的子类是弱链接的类，并且父类是不可用的，那么子类也会表现为不可用。  
这里用到的class方法的前提是你要确保该类库是支持NS_CLASS_AVAILABLE宏定义的。你也必须要配置相应的工程设置项。在适当的位置配置这些必须的设置，之前的代码就会安全的检测一个类是否可用，即使在一个不存在该类的iOS系统版本上也可以这样检测。这些设置包含以下内容：  

* 你的Xcode相比基于的SDK必须是iOS 4.2或更高的版本。该项设置在构建设置编辑器当中的名字是SDKROOT (Base SDK)。
* 你的项目部署的target必须是iOS 3.1或更高的版本。该项设置的名称是MACOSX_DEPLOYMENT_TARGET (OS X Deployment Target)。
* 你的项目的编译器必须是LLVM-GCC 4.2或更高的版本，或者是LLVM compiler (Clang) 1.5或更高版本。该项设置的名称是GCC_VERSION (C/C++ Compiler Version)。
* 你必须确保在你的工程部署target当中的任何系统类库都是弱链接的，而不是必须的。参见“链接到整体系统类库”以及“Xcode工程管理指南”中的链接库和系统框架部分。

使用Xcode构建设置编辑器的相关信息，参见“Xcode项目设置指南”中的“构建产品”部分。  
在OS X当中（以及在iOS当中，不符合刚刚列出的条件的集合中），你不能够使用class方法来判断一个弱链接的类是否可用。不过，你可以使用NSClassFromString函数来达到同样的效果：  

	Class cls = NSClassFromString (@"NSRegularExpression");
	if (cls) {
    // Create an instance of the class and use it.
	} else {
    // Alternate code path to follow when the
    // class is not available.
	}

## 使用弱连接的函数、方法和符号表

## 弱连接到整个框架

## 为不同的SDKs配置不同的编译条件

## 查找弃用的API使用情况

## 判断操作系统和框架的版本