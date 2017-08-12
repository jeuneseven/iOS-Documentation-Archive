[Error Handling Programming Guide 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40001806)

# 介绍
任何程序在运行时发生error的话，都需要对其进行处理。举例来说，程序可能无法打开一个文件，或者可能无法解析一个XML文档。通常发生这类error的情况下，程序应当告知使用者。并且程序应当试图避免引起问题的error。  
Cocoa (以及 Cocoa Touch)为开发者提供了开发工具来处理以下任务：Foundation 框架中的 NSError类以及Application Kit框架中的新的方法和机制都支持在app中的error处理。NSError对象封装了针对一个error的相关信息，包括发起该error的域名（子系统）和本地化的字符串来描述一个error警告。在app当中，同样有框架来让app中不同的对象改善error对象中的相关信息，并且还有可能从error中恢复。  

	重要：NSError对象在OS X和iOS当中都可用。不过，error响应和error恢复的相关API和机制仅在OS X中的Application Kit中可用。

如果你想了解NSError的API以及机制和如何使用它们，请阅读本文档。
## 本文档的组织结构
Cocoa Error处理编程指南有以下文章：

* error对象，域名，和code：描述了NSError对象的相关属性，详细描述了它的域名以及error code，并且讨论了一个error对象的“user info”字典当中可能出现的内容，包括本地化的信息字符串和底层的error。
* 使用和创建error对象：解释了如何评估一个error，如何使用NSError对象展示一个error消息，以及如何实现一个返回NSError对象引用的方法。
* error响应和error恢复：描述了在一款app当中通过Application Kit框架来在响应链中传递error，给予每个对象以机会在展示error之前来定制它。本章还讨论了恢复error的相关角色，如果用户请求的话，一个对象是可以被设计为从error恢复的。
* 处理接收到的error：讨论了在error响应链中的的对象，你将处理一个接收到的error并且对其定制化。
* 从error恢复：阐述了用户想从error恢复的过程。

与iOS相关的两个章节是：error对象，域名，和code、使用和创建error对象
## 另请参见
“Mac中基于文档的app编程指南”中的“文档体系结构支持健壮的错误处理”一章为子类化那些重载的方法（通过使用一个NSError的引用参数）提供了一些很有价值的建议。  

# error对象，域名，代码
cocoa的程序使用NSError对象来传递运行时的错误信息给用户知道。大部分情况下，程序展示错误信息是以对话框或者表单的形式。不过也会有阐释信息以及询问用户是否从错误中恢复或者用户自己纠正错误的情况。  
一个NSError对象的核心属性——或者简单来说，一个error对象——是error的域名，一个特定领域的error code以及一个“用户信息”字典，它包含了有关error的对象，大部分显式的描述和可以恢复的字符串。本章阐述了error对象的原因，描述了它的属性以及讨论了你如何在cocoa代码当中使用它。
## 为什么会有Error对象？
由于它们是对象，所以NSError类的实例比一些简单的error code和error字符串有更多的优点。它们一次性的将一些error信息封装，包括本地化的error字符串。NSError对象还能够被归档和拷贝，并且它们能够在 app 当中传递和修改。尽管NSError并不是一个抽象类（因此可以被直接使用），你还可以通过子类继承NSError类对其进行扩展。  
出于分层的error域的概念，NSError 对象可以嵌入底层子系统的错误, 从而提供有关错误的更详细、细致入微的信息。error对象还提供了从error恢复的机制，这种机制通过引用一个指定对象作为error的恢复调度。
## error域名
由于大量的历史原因，OS X当中的错误代码被以域名的方式隔离开。举例来说，Carbon的错误代码，它的类型是OSStatus，它是在早于OS X的Macintosh操作系统中存在的。另一方面，POSIX的错误代码源自POSIX一致性的类UNIX，比如BSD。Foundation框架声明在NSError.h中的以下字符串常量为四种主要的错误域名：  

	NSMachErrorDomain
	NSPOSIXErrorDomain
	NSOSStatusErrorDomain
	NSCocoaErrorDomain


## error codes

## 用户信息字典

### 本地化的error信息

### 恢复的可能性

### 潜在的error

### 特殊域名的key

# 使用和创建error对象

## 处理从方法返回的error

### OS X中的error处理的替代选择

## 显示从error对象返回的信息

### 通过Application对象传递显示error（OS X）

## 创建和返回NSError对象

### error和异常的提示

# error的响应和error的恢复

## error响应链

## 自定义error

## error的恢复

# 处理收到的error

## 通过error响应链向上传递error

## 自定义error对象

# 从error恢复