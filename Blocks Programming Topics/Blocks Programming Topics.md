[Blocks Programming Topics 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40007502)

# 介绍
Block对象是一种C语言级别的句法和运行时功能。它和标准C的函数很像，但除了执行代码之外，它还包含变量绑定自动（栈）或手动（堆）内存。那么block就能够持有一组状态（数据），它能够在执行时用来影响行为。  
你可以使用blocks来组成函数表达式并可以传递给API，随意存储以及多线程使用。Blocks尤其适合用来作为回调，因为block同时带有回调时要执行的代码以及要执行时所需要的数据。  
Blocks在OS X v10.6 Xcode开发工具中的GCC和Clang自带。你可以在OS X v10.6和iOS4.0以及之后的版本中使用blocks。blocks运行时是开源的，且在“LLVM的编译器子项目仓库”中可以找到。Blocks同样出现在C标准工作组的“N1370: 苹果对于C的扩展”中。因为OC和C++同样都是从C派生出来的，blocks被设计用来同时支持三种语言（OC++也同样）。语法本身也体现了这一点。  
若要了解block对象是什么以及你如何从C，C++或者OC中使用它们，你需要阅读本文档。  
## 本文档的组织结构
本文档包含以下章节：  

* “从Blocks开始”提供了一个快速，实用的blocks介绍。
* “概念概览”提供了一个blocks概念的介绍。
* “声明和创建Blocks”展示了你如何声明一个block变量并如何实现它。
* “Blocks和变量”描述了blocks和变量之间的交互，并定义了__block存储类型标识符。
* “使用Blocks”阐述了各种使用范式。

# 从Blocks开始

## 声明和使用Block

## 直接使用Block

## Blocks与Cocoa

## __block变量

# 概念概览

## Block功能

## 用例

# 声明和创建Blocks

## 声明一个Block的引用

## 创建一个Block

## 全局Blocks

# Blocks和变量

## 变量的类型

## __block存储类型

## 对象和Block变量

### OC对象

### C++对象

### Blocks

# 使用Blocks

## 调用一个Block

## 使用Block作为函数参数

## 使用Block作为方法参数

## 拷贝Blocks

## 要避免的模式

## 调试