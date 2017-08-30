[Testing with Xcode 原文链接](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/01-introduction.html#//apple_ref/doc/uid/TP40014132)

# 介绍（关于使用Xcode测试）
Xcode能够为你提供大量的软件测试能力。测试你的项目能够提高你的项目的健壮性，减少Bugs，以及提升你的产品发布和销售的速度。经过良好测试的app能够提升用户体验。测试还能够帮助你更快更好的开发，消耗更少，并且能够帮助不同的开发人员协调开发进度。  

![](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/Art/twx-intro-1_2x.png)  

## 概览
在本文档中，你将会学到如何使用这些包含在Xcode当中的测试相关的功能。所有新建的测试相关的target都会自动添加XCTest框架。

* 快速开始。从Xcode 5开始，并且介绍了XCTest框架，为工程配置测试的过程已经流程化和自动化了，结合测试的导航栏来更好的使用测试和运行测试。
* 性能压测。Xcode 6以及之后的版本包含了创建测试用例的能力，并且能够让你基于一个准线来对程序进行压测和性能测试。
* UI测试。Xcode 7增加了测试一款app UI的能力。它包含了录制UI交互操作为源代码，让你能够将其转换为测试用例。
* 持续集成和Xcode 服务器。Xcode测试能够被使用命令行脚本执行，或者被一台运行Xcode 服务器的Mac自动化执行。

## 预备知识
你应该熟悉app设计以及编程的相关概念
## 另请参阅

参见以下这些WWDC的会议视频来更好的了解Xcode测试能力。

* WWDC 2013：Xcode 5当中的测试（409）
* WWDC 2014：Xcode 6当中的测试（414）
* WWDC 2015：Xcode 7当中的UI测试（406）
* WWDC 2015：Xcode 7当中的持续集成和代码覆盖率（410）

# 快速开始

## 介绍测试状态栏

## 为你的app添加测试相关内容

### 创建测试Target

### 运行测试查看结果

### 编写测试用例再次运行

### 为代码运行setUp()和tearDown()方法

## 概要

# 测试的基本点

## 确定测试的范围

## 性能测试

## 用户界面测试

## app和类库测试

## XCTest——Xcode测试框架

## 当测试的时候从何开始

# 编写测试类和方法

## 测试Targets、测试Bundles和测试导航栏

## 创建一个测试类

## 测试类的结构

## 测试执行流程

## 编写测试方法

## 为异步操作队列编写测试用例

## 编写性能测试用例

## 编写UI测试用例

## 使用Swift编写测试用例

## XCTest断言

## 在Objective-C 和 Swift中使用断言

# 运行测试查看结果

## 运行测试用例的相关命令

### 使用测试状态栏

### 使用源代码编辑器

### 使用Product菜单

## 显示测试结果

## 结合Schemes和Test Targets一起使用

## Build设置——测试app和测试类库

### Build默认设置

# 调试测试

## 测试调试工作流

## 测试的具体工具

### 测试失败断点

### 使用项目菜单当中的命令来运行测试

### 编辑器助手分类

### 测试期间的异常断点

# 代码覆盖率

## 可用的代码覆盖率

## 代码覆盖率是如何适配测试的

# 自动化和测试过程

## 持续集成基于服务的测试

## 命令行测试

### 使用xcodebuild运行测试

### 结合ssh使用xcodebuild

## 使用Xcode Server和持续集成

# 用户界面测试

## 必备条件

## 一些概念以及API

## Apis

## 从UI录制开始

## 编写UI测试用例

# 附录A：编写可测试的代码

## 指南

# 附录B：从OCUnit转换到XCTest

## 从OCUnit 转换到 XCTest

## 手动从OCUnit 转换到 XCTest