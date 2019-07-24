[Table View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html#//apple_ref/doc/uid/TP40007451)

# 介绍

## 关于iOS应用中的 Table Views
在iOS 应用程序中，table view是常见的通用用户界面对象。一个table view是展示在多行可滚动列表的数据，数据也可被分为段。  
table view有很多用处：  

* 让用户通过层级结构数据导航
* 展示元素的索引列表
* 展示详细信息并以可视化的分组控制
* 展示可选列表

图1-1 各种table view  

![](file:///Users/lizhankun/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.iOS.docset/Contents/Resources/Documents/documentation/UserExperience/Conceptual/TableView_iPhone/Art/types_of_table_views.jpg)

table view只有一列，并只允许垂直方向滚动。它由段落组成。每个段落可以拥有一个header和一个footer来展示文本或者图片。不过，很多table view都只有一个段落，并且没有可见的header或者footer。在程序中，UIKit框架通过索引数字来定位行和段落：段落从0开始直到n-1，是从table view的头部到底部；行是在一个段落中从0到n-1。table view也能拥有其本身的header和footer，且与段落的区分开；table view的header展示在第一段的第一行之前，table view的footer展示在最后一个段落的最后一行之后。  

## 概览  
一个table view就是一个 UITableView 类的实例变量，它有两种基本样式，简单样式和分组样式。简单样式的table view是一个没有断开的列表；分组的table view从视觉上看是分成段的。一个table view有数据源，可能还会有代理。数据源对象提供数据来构成段落以及table view的行。代理对象定制了它的展示和行为。  

```
相关章节：table view的样式和辅助视图
```

### Table View使用cell来绘制行
一个Table View是使用cell来绘制行的，即UITableViewCell对象。cell是一种能够展示文本、图片或其他类型内容的视图。在正常和选中状态下可以拥有背景视图。cell还能够有辅助视图，用来作为选中或设置一个选项的功能。  
UIKit框架定义了四种标准cell样式，每种对于默认的三个内容元素都有其自己的布局：主label，详情label，以及图片。你也可以创建你自己的自定义cell来为你的应用程序的Table View创造独特的样式。  
当你在故事版编辑器中配置Table View的属性时，你可以从两种cell内容类型中进行选择，静态cell或者动态类型。  

* 静态cell。
* 动态类型。

```
相关章节：Table View样式和辅助视图，近距离观察Table View Cell
```

### 响应选中行

### 在编辑模式下你可以添加、删除和重新排序行

### 使用故事版创建Table View

## 预备知识

## 另请参阅

# Table View样式和辅助视图

## Table View样式

### 无格式的Table View

### 分组Table View

## Table View Cell的标准样式

## 辅助视图

# Table View API概览

## Table View

## Table View 控制器

## 数据源和代理

## 扩展NSIndexPath类

## Table View Cell

# 使用Table View导航数据层级

## 分层数据模型和Table View

### 数据模型作为模型对象的分层

### Table View 和数据模型

## View Controller和基于导航的应用

### 导航控制器

### 导航栏

### Table View控制器

### 在基于导航的应用中管理Table View

## 基于导航的应用的设计模式

# 创建和配置一个Table View

## Table View的基本创建

## 创建和配置Table View的推荐方式

## 使用故事版来创建Table View

### 选择Table View的展示样式

### 选择Table View的内容类型

### 设计Table View的行

### 创建额外的Table View

### 通过创建一个简单的应用学习更多

## 使用代码来创建Table View

### 采取数据源和代理

### 创建和配置一个Table View

## 通过数据构成Table View

## 通过数据构成静态Table View

## 构成索引

## 可选的Table View配置

### 添加自定义标题

### 提供段落标题

### 缩进一行

### 改变行高

### 定制化cell

# 近距离观察Table View Cell

## cell对象的特性

## 在预定义样式中使用cell对象

## 定制cell

### 从故事版加载Table View Cell

#### 动态行内容的技术

#### 静态行内容的技术

### 编码方式添加子视图到cell的内容视图中

## 提高Table View Cell的可用性

## Cells 和 Table View的性能

# 管理选中效果

## Table View中的选中

## 响应选中

## 编码方式选中和滚动

# 插入和删除行和段

## 在编辑模式下插入和删除一行

### 当一个Table View被编辑时

### 删除Table View一行的示例

### 添加Table View一行的示例

## 批量插入，删除和重加载行和段

### 批量插入和删除操作的示例

### 操作和索引路径的顺序

# 管理行的存储

## 当一行被重新定位时发生了什么

## 移动一行的示例