[Data Formatting Guide 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i)

# 简介

## Cocoa数据格式化编程指南简介

你可以使用格式化器来解释和创建字符串来表示其他的数据类型，并且还能检测输入框和其他单元格中的文字。格式化器是一个抽象类的子类的实例，NSFormatter。Foundation框架提供了NSFormatter类的两个具体的子类 NSNumberFormatter 和 NSDateFormatter。（Core Foundation 提供了两个等价的不公开类型 CFNumberFormatter 和 CFDateFormatter，这些类似但并不能直接桥接使用。）你可以创建NSFormatter的子类来自定义格式化。  
你可以阅读本文档来获取一些关于如何创建和使用日期和数字格式化器的基本理解，以及如何创建一个自定义的格式化器对象。  

### 本文档组织结构

《数据格式化》讲述如何使用数据格式化。  
《数字格式化》讲述如何使用数字格式化。
《格式化和用户界面元素》讲述如何在OS X上设置一个格式化器给用户界面元素，以及元素和其格式化器之间的交互。  
《创建一个自定义格式化》概括了如何创建一个自定义的格式化类。