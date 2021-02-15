[Cocoa Fundamentals Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Introduction/Introduction.html#//apple_ref/doc/uid/TP40002974-CH1-SW1)

# 简介

对于开发新手而言，Cocoa可能像是个汪洋大海，未知的技术的新世界。各种功能，工具，概念，设计，术语，编程接口以及这种开发环境的编程语言都可能不熟悉。Cocoa基础指南让熟悉Cocoa这一初始步骤变得简单。它为Cocoa的技术概览提供了方向。它介绍了其功能，基本概念，术语，体系结构和底层设计模式。  
你可以为两个平台构建Cocoa应用：OS X操作系统和iOS，类似iPhone，iPad和iPod touch的多点触控设备操作系统。Cocoa基础指南展现了两个平台中与Cocoa相关的信息，尽可能的整合了信息并在必要的位置指出平台的差异。目的是一旦你对Cocoa的一个平台熟悉了，很容易就从一个软件开发平台的知识迁移到另一个。  
Cocoa基础指南意在逐步理解Cocoa开发全貌。它从基本信息开始——什么是Cocoa遵照的组建和能力——并以查阅其主要架构为止。每个章节都在其前一章节解释了。每个段落都对于一个子模块介绍了详情，但只在一个较高层次进行描述。一个段落会经常将你引用到另一个提供更全面描述的文档。    
在Cocoa 开发文档集合中，《Cocoa基础指南》是概念入口文档。对于阅读其他基本Cocoa指南是先决条件，比如《Cocoa绘制指南》，《视图编程指南》，以及《iOS应用编程指南》。《Cocoa基础指南》会依据先导阅读，但读者应该精通C语言编程并属性他们将要进行开发的平台的能力和技术，你可以通过阅读《Mac技术概览》对此熟悉，对于iOS而言，阅读《iOS技术概览》。

## 本文档组织结构

Cocoa基础指南有如下章节：  

* 什么是Cocoa？ 从功能性和概括性的结构透析介绍了Cocoa，描述了其功能，框架和开发环境。
* Cocoa对象 阐释了优势和OC的基本使用，还介绍了常用功能，接口和所有Cocoa对象的生命周期。
* 给一个Cocoa程序添加行为 描述了使用Cocoa框架编写一个程序是什么样的，以及解释了如何创建一个子类。
* Cocoa设计模式 描述了Cocoa适配设计模式，特别是MVC和对象模型。
* 与对象进行交互 讨论了编程接口和在Cocoa对象之间的沟通机制，包括代理，通知和绑定。

## 另请参阅

在技术书库中你还可以找到很多优秀的第三方介绍Cocoa的文章。你可以用这些书补充你在Cocoa基础指南中的所学。此外，还有一些其他的Apple文章你也可以作为一个Cocoa开发者阅读：  

* OC编程语言 描述了OC编程语言和运行时环境。
* 模型对象实现指南 讨论了子类设计和实现的基本问题。
* 开发CocoaOC应用程序 《教程》展示了如何使用Xcode开发环境构建一个简单的OS X的Cocoa应用程序，Cocoa框架和OC。《你的第一个iOS应用》是一份引导你从创建一个简单的iOS应用到展示如何使用基本的Xcode开发环境以及OC和Cocoa框架的指南。
* iOS应用编程指南 介绍了用来开发运行iOS设备的应用程序的特定框架。

# 什么是Cocoa？

Cocoa 是一个在OS X操作系统以及iOS上的应用程序环境，操作系统是用在类似iPhone，iPad, 和 iPod touch等设备上的。它由一组面向对象的软件库，一个运行时系统，以及一个整合的开发环境组成。  
本章扩展了此定义，描述了 Cocoa 在两个平台上的目的、功能和组件。阅读Cocoa的功能描述对于Cocoa的开发人员来说是重要的第一步。  

## Cocoa环境

Cocoa是一套面向对象的框架，它为运行在OS X和iOS上的应用程序提供了运行时环境。Cocoa对于OS X是一个优秀的应用程序环境，但对于iOS来讲是唯一的应用环境。（Carbon是一个在OS X的替代环境，但它是一个可以与共存的框架）

### Cocoa简介

### Cocoa是如何适配OS X的

### Cocoa是如何适配iOS的

## Cocoa应用的功能

## 开发环境

### 平台SDKs

### 开发流程概览

### Xcode

### 界面编辑器

### iOS模拟器应用

### 性能应用和工具

## Cocoa框架

### Foundation

### AppKit (OS X)

### UIKit (iOS)

### AppKit和UIKit类对比

### Core Data

### 其他框架和Cocoa API

## 一点历史

# Cocoa对象

## 一个简单的Cocoa命令行工具

## OC面向对象编程

Cocoa中遍布面向对象，从其编程范式到其机制再到其事件驱动架构。OC，Cocoa的开发语言，也是彻底的面向对象，尽管其基础是ANSI C。它为消息分发和定义新的类并指定句法约定提供了运行时支持。OC支持其他编程语言类似C++和Java等的大部分的抽象和机制。这包括继承，封装，复用和多态。  
但OC与其他面向对象语言不同，尤其是在比较重要的地方。比如，OC不像C++，不允许运算符重载，模板或者多重继承。  
尽管OC没有这些功能，但它作为一个面向对象的编程语言是有所补偿的。下文继续探究OC的特殊功能。  

```
附加阅读：《OC编程语言》大部分章节的简介信息都可以作为OC语言的最佳指导，查阅该文档作为详情和OC的补充介绍。
```

### OC的优势

如果你是一个面向对象概念的新手程序员，  

图 2-1 一个对象的isa指针  
![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Art/ns_gadget.gif)

# 给一个Cocoa程序添加行为

# Cocoa设计模式

# 与对象交互