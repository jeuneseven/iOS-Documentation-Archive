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

## 一个Collection View就是一组合作的对象

## 重用视图能够提高性能

## 布局对象控制了界面展示

## Collection View自动初始化了动画

# 设计你的数据源和代理

## 数据源管理着你的内容

## 配置cell和辅助视图

## 插入，删除和移动段落和单元格

# 使用布局

# 接入手势支持

# 创建自定义布局

# 自定义布局举例