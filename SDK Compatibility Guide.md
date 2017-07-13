[SDK Compatibility Guide 原文链接](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163i)  

# 简介
Xcode包含的SDK让你能够创建运行在指定版本的iOS或者OS X系统上的软件——包括不同于你正在开发的版本。这项技术能够让你利用新的功能构建一个单一的二进制包就可以在一个系统当中运行并提供支持，并且在运行在一个较早版本系统当中时，可以无缝的降级。一些Apple的框架会根据应用程序构建的SDK自动修改其行为, 以提高兼容性。  
	
	注意：本文档没有阐述如何编写同时运行在iOS和OS X系统的代码。尽管Xcode能够让你通过一个简单的选择来更换不同的SDK来转换平台，但是在iOS和Mac的app当中还是有一些基本设计上的不同的。参见“从cocoa迁移”来获取更多信息。
	
如果你的app需要兼容不同的iOS或者OS X版本的话，请阅读本文档。	
## 本文的组织结构

# 基于SDK开发概览

## 框架中的行为选择

# 为基于SDK的开发配置项目

## SDK头文件以及根类库

## 基于SDK以及开发target的设置

## 弱连接以及Apple开发类库

## 配置基于Makefile的项目

## 设置预编译文件

# 使用基于SDK开发

## 在iOS中使用弱连接的类

## 使用弱连接的函数、方法和符号表

## 弱连接到整个框架

## 为不同的SDKs配置不同的编译条件

## 查找弃用的API使用情况

## 判断操作系统和框架的版本