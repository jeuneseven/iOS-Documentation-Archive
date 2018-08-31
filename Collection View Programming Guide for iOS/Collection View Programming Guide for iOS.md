[Collection View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

# 介绍
## 关于iOS Collection View
collection view是一种使用灵活可变的布局展示一组有序数据元素的方式。通常使用collection view来展示类似网格布局的元素，但iOS中的collection view的能力不仅仅是行和列那么简单。使用collection view 能够通过定义好的子类精确布局可见元素并能够动态改变，所以你可以实现单元格，堆列，环绕布局，动态的改变布局，或任何你能够想象的布局类型。  
collection view将被展示的数据和用来展示数据的可视化元素严格区分开。在大部分情况下，你的应用程序只需要负责管理数据即可。你的应用程序也可以提供视图对象来展示数据。collection view会利用你的视图对象并完成它们在屏幕上布局的所有工作。这个过程会结合布局对象来做，布局对象指定了你的视图的位置和可视化属性，它还可以子类化来适合你的应用程序所需。因此，你负责提供数据，布局对象提供布局相关信息，collection view会将两者结合来完成最终的显示。

### 概览

#### Collection View管理着数据驱动视图的可视化展示

#### 流式布局支持网格以及其他面向行的展示

#### 手势能够被用在cell和布局操作上

#### 自定义布局能够让你不局限于网格

### 预备知识

### 另请参阅

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