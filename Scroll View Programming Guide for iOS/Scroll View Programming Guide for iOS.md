[Scroll View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008179)

# 介绍
## 关于滚动视图编程
当内容需要被展示和操作，但整个屏幕不够的时候，就需要iOS应用中的Scroll view了。Scroll view有两个主要用途：  

* 让用户拖拽他们想要展示的内容区域
* 让用户使用捏合手势放大或缩小展示内容区域

下图展示了一个 UIScrollView 类的典型使用方式。子视图是一个UIImageView，它包含一张小男孩的图片。当用户拖拽他/她在屏幕上的手指时，图片的视角就会进行移动，正如你在图片中看到的那样，滚动指示器就展现出来了。当用户手指离开时，指示器就消失了。

![](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/NSImageView_UIScrollView.jpg)

### 概览
UIScrollView 类提供了以下功能：  

* 滚动不能够适应整个屏幕的内容
* 放大或缩小内容，能够让你的应用程序支持标准的捏合手势来放大缩小
* 限制一次只能够滚动到一屏幕内容（paging模式）

UIScrollView 类对其展示的内容无需指定特定视图；它只是直接滚动其子视图。这种简单的模式之所以可行是因为在iOS上scroll view没有对初始滚动做额外的控制

#### 基本的视图滚动是很容易实现的

#### 使用代理来支持捏合缩放手势

#### 要支持捏合和触摸手势的缩放，需要在内容视图中实现代码

#### 要支持分页模式，你需要三个子视图

### 预备知识
在阅读本文之前，请阅读《iOS App编程指南》来理解开发iOS应用程序的基本过程。最好再阅读一下《iOS视图控制器编程指南》来了解视图控制器的基本信息，它通常是和scrollview结合使用的。
### 如何使用本文档

### 另请参见

# 创建和配置滚动视图

## 创建滚动视图

### 在界面编辑器中创建滚动视图

### 以编码方式创建滚动视图

## 添加子视图

## 配置滚动视图的内容大小，内容内边距以及滚动指示

# 滚动滚动视图的内容

## 以编码方式滚动

### 滚动到一个特定的位置

### 将一个矩形可视化区域滚动到顶部

## 滚动时会发送代理消息

### 简单的方式：跟踪一个滚动事件的开始和结束

### 完整的代理消息发送顺序

# 基于放大效果使用捏合手势

## 支持捏合缩放手势

## 编码方式的缩放

## 通知代理缩放已经结束

## 当缩放时确保缩放内容sharp

# 通过触摸缩放

## 实现触摸事件代码

### 初始化

### 实现touchesBegan:withEvent:

### 实现touchesEnded:withEvent:

### 实现touchesCancelled:withEvent:

## ScrollViewSuite示例工程

# 使用分页模式滚动

## 配置分页模式

## 配置一个分页滚动视图的子视图

# 嵌套滚动视图

## 相同方向的滚动

## 交叉方向的滚动