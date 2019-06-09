[Transitioning to ARC Release Notes 原文链接](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226)

自动引用技术（ARC）是一个编译器的功能，它为OC对象提供了自动内存管理。你无须再考虑retain和release操作，ARC能够让你将精力集中在有趣的代码上，对象图表以及在你的应用程序中的对象之间的关系。  

![](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Art/ARC_Illustration.jpg)

# 摘要
ARC是通过在编译期间添加代码来确保对象能够根据需要来存活或销毁的。从概念上讲，它和手动引用计数一样，遵循的同样的内存管理规则（在“高级内存管理编程指南”中有相关描述），它是通过为你添加适当的内存管理调用。  
为了让编译器能够生成正确的代码，ARC限制了你能够使用的方法以及如何使用免费的桥接（参见“免费桥接类型”一节）。ARC同样也为对象引用和声明属性引入了新的生命周期修饰符。  
ARC在OSX v10.6和v10.7的Xcode 4.2和iOS 4以及iOS 5之后可以引用。弱引用在OSX v10.6和iOS 4中不再支持。  
Xcode提供了一个工具来自动的操作ARC转换（比如移除retain和release调用）并帮助你修复在迁移时无法自动处理的问题（选择Edit > Refactor > Convert to Objective-C ARC）。迁移工具会转换所有项目中的文件来使用ARC。你也可以选择使用在每个文件的基础上使用ARC，如果你想要在某个文件上使用手动引用计数的话。

另请参见：  

* 高级内存管理编程指南
* Core Foundation内存管理编程指南

# ARC概览

## ARC强制新规定

## ARC引入了新的生命周期的限定符

## ARC使用了新的语句来管理自动释放池

## 跨平台管理连接的模式变得一致

## 栈变量被初始化为nil

## 使用编译器标识来开启或禁用ARC

# 管理免费的桥接

## 编译器会负责处理从cocoa方法返回的CF对象

## 使用所有权关键字的转换函数参数

# 当转换一个项目时的常见问题

# 常见问题